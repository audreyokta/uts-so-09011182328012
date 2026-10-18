# Tugas Besar UTS Sistem Operasi

## 1. Identitas
* **Nama**: Audrey Okta Ramadhini
* **NIM**: 09011182328012
* **Kelas**: SKU3B

## 2. Deskripsi
Script ini mencadangkan file `.txt` dari `~/data_09011182328012` ke `~/backup_09011182328012` menggunakan `find`, mengarsipkannya dengan `tar -czvf`, memverifikasi isi arsip dengan `tar -tzvf`, dan mencatat log ke `backup.log`.

## 3. Cara Menjalankan
* Backup satu kali: `./script/backup.sh`
* Backup berulang di background: `./script/backup_loop.sh &`
* Menggunakan alias: `source script/alias.sh` lalu ketik `bk012`

## 4. Fitur Pengembangan
1. **Rotasi Arsip**: Hanya menyimpan 5 arsip terbaru dan menghapus arsip lama secara otomatis. Cara mencoba: jalankan `./script/backup.sh` lebih dari 5 kali lalu cek dengan `ls -lt ~/backup_09011182328012`.
2. **Parameter Ekstensi**: Dapat memilih ekstensi file sebagai argumen. Cara mencoba: `./script/backup.sh pdf`.

## 5. Bukti Job Control
```text
audreyokta@Audreyokta:~/uts-so-09011182328012$ ./script/backup_loop.sh &
[1] 3741
audreyokta@Audreyokta:~/uts-so-09011182328012$ jobs -l
[1]+  3741 Running                 ./script/backup_loop.sh &
audreyokta@Audreyokta:~/uts-so-09011182328012$ fg
./script/backup_loop.sh
^Z
[1]+  Stopped                 ./script/backup_loop.sh
audreyokta@Audreyokta:~/uts-so-09011182328012$ bg
[1]+ ./script/backup_loop.sh &
audreyokta@Audreyokta:~/uts-so-09011182328012$ ps x
    PID TTY      STAT   TIME COMMAND
   3332 pts/0    Ss     0:00 bash
   3741 pts/0    S      0:00 /bin/bash ./script/backup_loop.sh
   3784 pts/0    S      0:00 sleep 60
   3785 pts/0    R+     0:00 ps x
audreyokta@Audreyokta:~/uts-so-09011182328012$ kill %1
[1]+  Terminated              ./script/backup_loop.sh
```

## 6. Kendala dan Solusi
* **Kendala 1**: Muncul pesan `no such job` saat menjalankan `fg` dan `bg`.
  * **Solusi**: Menjalankan `./script/backup_loop.sh &` terlebih dahulu di background sebelum memanggil `fg` dan `bg`.
* **Kendala 2**: Teks terpotong saat menempelkan teks panjang melalui Shared Clipboard VirtualBox.
  * **Solusi**: Menambahkan isi file secara bertahap per bagian menggunakan operator append (`>>`).
