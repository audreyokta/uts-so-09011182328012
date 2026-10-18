#!/bin/bash
# Nama  : Audrey Okta Ramadhini
# NIM   : 09011182328012
# Kelas : Reguler

INTERVAL=60
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

while true; do
    "$SCRIPT_DIR/backup.sh"
    sleep "$INTERVAL"
done
