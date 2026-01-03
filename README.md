# MyActiPay

MyActiPay adalah aplikasi berbasis **Java Web (JSP & Servlet)** yang digunakan untuk pengelolaan kas kegiatan.  
Aplikasi ini memungkinkan setiap anggota memiliki target iuran yang dapat dibayarkan secara bertahap (dicicil), serta dilengkapi dengan proses validasi pembayaran oleh admin sebelum pembayaran dihitung ke dalam total kas.

Aplikasi ini dikembangkan sebagai **tugas akhir mata kuliah Java Web 1**.

---

## 📌 Latar Belakang

Pengelolaan kas kegiatan di lingkungan kelas sering kali masih dilakukan secara manual, sehingga rawan terjadi kesalahan pencatatan, keterlambatan rekap data, serta kurangnya transparansi dalam pengelolaan keuangan.

Oleh karena itu, aplikasi MyActiPay dibuat untuk membantu proses pencatatan dan pengelolaan kas kegiatan agar lebih **terstruktur, transparan, dan mudah dikelola** dengan memanfaatkan teknologi Java Web.

---

## ✨ Fitur Utama

- Pengelolaan data anggota
- Pengelolaan kegiatan kas
- Penentuan target iuran per anggota
- Pembayaran iuran secara bertahap (cicilan)
- Validasi pembayaran oleh admin
- Status pembayaran (menunggu, diterima, ditolak, lunas)
- Rekap dan laporan data kas
- Manajemen hak akses (Admin & User)

---

## 🛠️ Teknologi & Library yang Digunakan

### Teknologi Utama
- Java Web (JSP & Servlet)
- Apache Tomcat
- MySQL
- NetBeans IDE

### Library & Tools Pendukung
- **jbcrypt-0.4.jar**  
  Digunakan untuk enkripsi password pengguna.
- **mysql-connector-j-8.2.0.jar**  
  Digunakan sebagai driver koneksi antara aplikasi Java dan database MySQL.
- **commons-fileupload-1.4.jar**  
  Digunakan untuk menangani proses upload file (misalnya foto profil).
- **commons-io-2.6.jar**  
  Digunakan untuk mendukung proses input/output file.
- **Bootstrap**  
  Digunakan untuk mempercantik tampilan antarmuka aplikasi.
- **SweetAlert**  
  Digunakan untuk menampilkan notifikasi interaktif (berhasil, gagal, konfirmasi).

---

## 📁 Struktur Project

Project ini menggunakan struktur standar **Java Web Application (NetBeans – Ant)** sebagai berikut:
```

MyActiPay/
├── build/
│ └── web/
│
├── nbproject/ 
│
├── resources/ 
│ ├── database/ 
│ ├── libraries/
│ └── dokumentasi/ #(Buku panduan)
│
├── src/
│ └── conf/ 
│ └── DatabaseConfig.java
│
├── web/
│ ├── META-INF/
│ │
│ ├── admin/
│ │
│ ├── fungsi/
| ├── ... 
│ └── koneksi.jsp
│ │
│ ├── img/
│ ├── profile/
│ └── gambar kegiatan/ 
│ │
│ ├── partisi/ 
│ ├── foother.jsp 
│ └── navbar.jsp 
│ │
│ ├── daftar.jsp 
│ ├── login.jsp 
│ ├── index.jsp
│ ├── detail_akun.jsp
│ ├── edit_akun.jsp 
│ ├── pembayaran.jsp 
│ ├── riwayat_pembayaran.jsp 
│ └── rekap_pembayaran.jsp 
│
├── build.xml 
└── README.md
```

---

## ▶️ Cara Menjalankan Aplikasi

Clone repository:
   ```bash
   git clone https://github.com/saufud/MyActiPay_tugas.git
