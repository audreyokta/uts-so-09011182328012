#!/bin/bash
# Nama  : Audrey Okta Ramadhini
# NIM   : 09011182328012
# Kelas : SKU3B

# 2. Variabel direktori sumber, tujuan, dan file log
NIM="09011182328012"
SOURCE_DIR="$HOME/data_${NIM}"
BACKUP_DIR="$HOME/backup_${NIM}"
LOG_FILE="${BACKUP_DIR}/backup.log"
FILE_LIST="${BACKUP_DIR}/daftar_file.txt"

# Fitur Pengembangan 1: Parameter ekstensi file (default: txt)
EXT="${1:-txt}"

# 3. Membuat direktori tujuan jika belum ada
mkdir -p "$BACKUP_DIR"

# Menyiapkan format tanggal dan jam
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
LOG_DATE=$(date +"%Y-%m-%d %H:%M:%S")
ARCHIVE_NAME="backup_${NIM}_${TIMESTAMP}.tar.gz"
ARCHIVE_PATH="${BACKUP_DIR}/${ARCHIVE_NAME}"

# 4. Mencari semua file .txt (termasuk di subdirektori) dan menyimpan daftarnya
find "$SOURCE_DIR" -type f -name "*.${EXT}" > "$FILE_LIST"

# Menghitung jumlah file yang di-backup
FILE_COUNT=$(wc -l < "$FILE_LIST")

# 5. Mengarsipkan dan mengompresi file hasil pencarian
tar -czvf "$ARCHIVE_PATH" -T "$FILE_LIST"

# 6. Verifikasi isi arsip tanpa mengekstraknya
echo "=== Verifikasi Isi Arsip ==="
tar -tzvf "$ARCHIVE_PATH"

# Mengambil ukuran file arsip
ARCHIVE_SIZE=$(du -h "$ARCHIVE_PATH" | cut -f1)

# 7. Mencatat proses backup ke file log (1 baris per eksekusi)
echo "${LOG_DATE} | ${ARCHIVE_NAME} | ${FILE_COUNT} | ${ARCHIVE_SIZE}" >> "$LOG_FILE"

# Fitur Pengembangan 2: Rotasi arsip (hanya menyimpan 5 arsip terbaru)
ls -1t "${BACKUP_DIR}"/backup_"${NIM}"_*.tar.gz 2>/dev/null | tail -n +6 | xargs -r rm -f --
