-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Waktu pembuatan: 22 Des 2025 pada 04.59
-- Versi server: 10.4.28-MariaDB
-- Versi PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `kas_kelas`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `kegiatan`
--

CREATE TABLE `kegiatan` (
  `id` varchar(50) NOT NULL,
  `nama_kegiatan` varchar(255) NOT NULL,
  `target_kas` int(11) NOT NULL,
  `tanggal_mulai` date NOT NULL DEFAULT current_timestamp(),
  `tanggal_akhir` date NOT NULL,
  `status` enum('aktif','selesai') NOT NULL,
  `total_kas` int(11) DEFAULT NULL,
  `gambar` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `kegiatan`
--

INSERT INTO `kegiatan` (`id`, `nama_kegiatan`, `target_kas`, `tanggal_mulai`, `tanggal_akhir`, `status`, `total_kas`, `gambar`) VALUES
('KEG1764004752935', 'seminar nasional SI offline', 75000, '2025-11-25', '2025-12-31', 'selesai', 0, 'keg_64758f0a-c95e-47eb-ae8d-5fe2bd26afd7.jpg'),
('KEG1764005178236', 'beli rolan 1km', 50000, '2025-11-25', '2026-01-20', 'aktif', 0, 'keg_e24ee7f2-908f-41ff-8286-36e373e68808.jpg'),
('KEG1764126853810', 'seminar nasional SI online', 50000, '2025-11-26', '2025-11-06', 'selesai', 0, 'keg_4927f62c-2526-4686-9415-eef1e0d658d6.jpg'),
('KEG1764257881983', 'pantai', 100000, '2025-11-27', '2025-12-31', 'aktif', 0, 'keg_10e8ebbc-c7f0-4d7d-9aee-b8fd79390a99.jpg');

-- --------------------------------------------------------

--
-- Struktur dari tabel `pembayaran`
--

CREATE TABLE `pembayaran` (
  `id` varchar(50) NOT NULL,
  `nim` varchar(12) NOT NULL,
  `id_kegiatan` varchar(50) NOT NULL,
  `tanggal_bayar` date NOT NULL DEFAULT current_timestamp(),
  `jumlah_bayar` int(11) NOT NULL,
  `status` enum('menunggu','diterima','ditolak') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `pembayaran`
--

INSERT INTO `pembayaran` (`id`, `nim`, `id_kegiatan`, `tanggal_bayar`, `jumlah_bayar`, `status`) VALUES
('BYR1764149671695', '241091700289', 'KEG1764004752935', '2025-11-26', 50000, 'diterima'),
('BYR1764173548800', '241091700289', 'KEG1764004752935', '2025-11-26', 50000, 'diterima'),
('BYR1764174070688', '241091700289', 'KEG1764005178236', '2025-11-26', 10000, 'ditolak'),
('BYR1764174129320', '241091700289', 'KEG1764005178236', '2025-11-26', 5000, 'diterima'),
('BYR1764174326433', '241091700289', 'KEG1764005178236', '2025-11-26', 20000, 'diterima'),
('BYR1764174422884', '241091700289', 'KEG1764126853810', '2025-11-26', 25000, 'diterima'),
('BYR1764174559639', '241091700289', 'KEG1764126853810', '2025-11-26', 10000, 'diterima'),
('BYR1764174608706', '241091700289', 'KEG1764126853810', '2025-11-26', 15000, 'diterima'),
('BYR1764174771679', '241091700289', 'KEG1764005178236', '2025-11-26', 10000, 'diterima'),
('BYR1764174849006', '241091700289', 'KEG1764005178236', '2025-11-26', 3000, 'diterima'),
('BYR1764174916406', '241091700289', 'KEG1764005178236', '2025-11-26', 1000, 'diterima'),
('BYR1764175056676', '241091700289', 'KEG1764005178236', '2025-11-26', 2000, 'ditolak'),
('BYR1764175301805', '241091700289', 'KEG1764005178236', '2025-11-26', 5000, 'diterima'),
('BYR1764175343717', '241091700289', 'KEG1764005178236', '2025-11-26', 6000, 'ditolak'),
('BYR1764175362563', '241091700289', 'KEG1764005178236', '2025-11-26', 6000, 'diterima'),
('BYR1764176753440', '112233', 'KEG1764005178236', '2025-11-27', 25000, 'diterima'),
('BYR1764176992640', '112233', 'KEG1764126853810', '2025-11-27', 25000, 'diterima'),
('BYR1764177024956', '112233', 'KEG1764126853810', '2025-11-27', 25000, 'diterima'),
('BYR1764259955669', '112233', 'KEG1764257881983', '2025-11-27', 50000, 'diterima'),
('BYR1764259989766', '241091700289', 'KEG1764257881983', '2025-11-27', 75000, 'diterima'),
('BYR1764260373699', '241091700289', 'KEG1764257881983', '2025-11-27', 25000, 'ditolak'),
('BYR1764260458254', '241091700289', 'KEG1764257881983', '2025-11-27', 25000, 'diterima'),
('BYR1764317754022', '241091700327', 'KEG1764004752935', '2025-11-28', 75000, 'diterima'),
('BYR1764317767090', '241091700327', 'KEG1764004752935', '2025-11-28', 75000, 'diterima'),
('BYR1764318300242', '241091700327', 'KEG1764004752935', '2025-11-28', 75000, 'ditolak');

-- --------------------------------------------------------

--
-- Struktur dari tabel `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `nim` varchar(12) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `profil` varchar(255) DEFAULT NULL,
  `no_telpon` varchar(12) NOT NULL,
  `role` enum('ADMIN','USER') NOT NULL,
  `jenis_kelamin` enum('Laki-Laki','Perempuan') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `users`
--

INSERT INTO `users` (`id`, `nim`, `username`, `password`, `profil`, `no_telpon`, `role`, `jenis_kelamin`) VALUES
(32, '123456', 'ADMIN', '$2a$10$bALNez77b0YPxyY/KnKpMu4Lpy/9iprzPwpRbGF8a/JDH1gewbSHi', 'ADMIN_61157513-0c71-44e0-98a4-ddc7e76e0d29.jpg', '123', 'ADMIN', 'Laki-Laki'),
(37, '241091700289', 'Saufud alehan', '$2a$10$Hk5361Lc4s0aU1iIZgogR.uFEf1yNwEHYpXgU/rTdfk1iyqANrInK', 'saufud _1764149606635', '085719965709', 'USER', 'Laki-Laki'),
(38, '112233', 'ahmad sahroni', '$2a$10$GpYmrFF6rWsHxAw24Oo7IOAtF7ZYgZIev/gGxvGdItYYDSFZnmTcC', 'ahmad sahroni_1764176730201', '0878', 'USER', 'Laki-Laki'),
(39, '241091700327', 'zahrapebriani', '$2a$10$7CbOrRLIFhWlnBEVbXD5FuVBv9Hay7k2Z8gWv49CcuaY/UCjJ9E3i', 'zahrapebriani_1764316538483', '083896109170', 'USER', 'Perempuan');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `kegiatan`
--
ALTER TABLE `kegiatan`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `pembayaran`
--
ALTER TABLE `pembayaran`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pembayaran_user` (`nim`),
  ADD KEY `pembayaran_kegiatan` (`id_kegiatan`);

--
-- Indeks untuk tabel `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nim` (`nim`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `pembayaran`
--
ALTER TABLE `pembayaran`
  ADD CONSTRAINT `pembayaran_kegiatan` FOREIGN KEY (`id_kegiatan`) REFERENCES `kegiatan` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `pembayaran_user` FOREIGN KEY (`nim`) REFERENCES `users` (`nim`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
