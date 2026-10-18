#!/bin/bash
# Nama  : Audrey Okta Ramadhini
# NIM   : 09011182328012
# Kelas : SKU3B

# Variabel jeda waktu (bawaan 60 detik)
INTERVAL=60
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Menjalankan backup.sh berulang kali
while true; do
    "$SCRIPT_DIR/backup.sh"
    sleep "$INTERVAL"
done
