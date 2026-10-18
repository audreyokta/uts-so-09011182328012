
#!/bin/bash
# Nama  : Audrey Okta Ramadhini
# NIM   : 09011182328012
# Kelas : SKU7A

SOURCE_DIR="$HOME/data_09011182328012"
BACKUP_DIR="$HOME/backup_09011182328012"
LOG_FILE="$BACKUP_DIR/backup.log"

# Membuat direktori tujuan
mkdir -p "$BACKUP_DIR"

# Memastikan direktori sumber tersedia
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Direktori sumber tidak ditemukan."
    exit 1
fi

# Menentukan nama arsip berdasarkan tanggal dan waktu
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
DATETIME=$(date '+%Y-%m-%d %H:%M:%S')
ARCHIVE="backup_09011182328012_${TIMESTAMP}.tar.gz"
ARCHIVE_PATH="$BACKUP_DIR/$ARCHIVE"
FILE_LIST=$(mktemp)

# Mencari seluruh file TXT termasuk subdirektori
find "$SOURCE_DIR" -type f -name "*.txt" -print0 > "$FILE_LIST"
FILE_COUNT=$(tr -cd '\0' < "$FILE_LIST" | wc -c)

# Memastikan terdapat file untuk diarsipkan
if [ "$FILE_COUNT" -eq 0 ]; then
    echo "Tidak ada file TXT untuk di-backup."
    rm -f "$FILE_LIST"
    exit 1
fi

# Membuat arsip terkompresi
if ! tar --null -czvf "$ARCHIVE_PATH" -T "$FILE_LIST"; then
    echo "Backup gagal."
    rm -f "$FILE_LIST"
    exit 1
fi

# Memeriksa isi arsip tanpa mengekstrak
tar -tzvf "$ARCHIVE_PATH"

# Menghitung ukuran arsip
SIZE=$(du -h "$ARCHIVE_PATH" | cut -f1)

# Mencatat hasil backup ke log, satu baris setiap proses
echo "$DATETIME | $ARCHIVE | $FILE_COUNT | $SIZE" >> "$LOG_FILE"

# Menghapus arsip lama, menyisakan lima arsip terbaru
cd "$BACKUP_DIR" || exit 1
ls -1t backup_09011182328012_*.tar.gz 2>/dev/null |
    tail -n +6 |
    while IFS= read -r old_archive; do
        rm -f -- "$old_archive"
    done

rm -f "$FILE_LIST"

echo "Backup selesai: $ARCHIVE"
echo "Jumlah file: $FILE_COUNT"
echo "Ukuran arsip: $SIZE"

