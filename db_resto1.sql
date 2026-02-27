-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 27, 2026 at 03:25 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_resto1`
--

-- --------------------------------------------------------

--
-- Table structure for table `detail_orderans`
--

CREATE TABLE `detail_orderans` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `id_orderan` bigint(20) UNSIGNED DEFAULT NULL,
  `id_menu` bigint(20) UNSIGNED DEFAULT NULL,
  `jumlah` int(11) DEFAULT NULL,
  `metode_pesanan` enum('takeaway','dinein') DEFAULT NULL,
  `catatan` text DEFAULT NULL,
  `status` enum('processing','done') DEFAULT 'processing',
  `subtotal` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `detail_orderans`
--

INSERT INTO `detail_orderans` (`id`, `id_orderan`, `id_menu`, `jumlah`, `metode_pesanan`, `catatan`, `status`, `subtotal`, `created_at`, `updated_at`) VALUES
(1, 1, 11, 1, 'dinein', '', 'done', 5000, '2026-02-21 00:58:01', '2026-02-21 08:06:04'),
(2, 1, 12, 1, 'dinein', '', 'done', 6000, '2026-02-21 00:58:01', '2026-02-21 08:06:01'),
(3, 1, 10, 1, 'dinein', '', 'done', 28000, '2026-02-21 00:58:01', '2026-02-21 08:05:59'),
(4, 1, 9, 1, 'dinein', '', 'done', 25000, '2026-02-21 00:58:01', '2026-02-21 08:05:56'),
(5, 2, 11, 2, 'takeaway', '', 'done', 10000, '2026-02-21 07:35:00', '2026-02-21 14:42:21'),
(6, 2, 13, 1, 'takeaway', '', 'done', 25000, '2026-02-21 07:35:00', '2026-02-21 14:42:23'),
(7, 2, 10, 1, 'takeaway', '', 'done', 28000, '2026-02-21 07:35:00', '2026-02-21 14:42:25'),
(8, 2, 9, 1, 'takeaway', '', 'done', 25000, '2026-02-21 07:35:00', '2026-02-21 14:42:27'),
(9, 3, 13, 2, 'dinein', '', 'done', 50000, '2026-02-21 07:42:00', '2026-02-21 14:50:10'),
(10, 3, 8, 1, 'dinein', '', 'done', 15000, '2026-02-21 07:42:00', '2026-02-21 14:42:35'),
(11, 3, 12, 1, 'dinein', '', 'done', 6000, '2026-02-21 07:42:00', '2026-02-21 14:42:34'),
(12, 3, 11, 1, 'dinein', '', 'done', 5000, '2026-02-21 07:42:00', '2026-02-21 14:42:31'),
(13, 4, 11, 2, 'takeaway', '', 'done', 10000, '2026-02-21 22:19:44', '2026-02-22 05:20:40'),
(14, 4, 10, 1, 'takeaway', '', 'done', 28000, '2026-02-21 22:19:44', '2026-02-22 05:20:42'),
(15, 5, 10, 1, 'dinein', '', 'done', 28000, '2026-02-21 23:31:13', '2026-02-22 06:40:50'),
(16, 5, 13, 1, 'dinein', '', 'done', 25000, '2026-02-21 23:31:13', '2026-02-22 06:40:56'),
(17, 5, 12, 1, 'dinein', '', 'done', 6000, '2026-02-21 23:31:13', '2026-02-22 06:40:54'),
(18, 5, 11, 1, 'dinein', '', 'done', 5000, '2026-02-21 23:31:13', '2026-02-22 06:40:52'),
(19, 6, 10, 1, 'takeaway', '', 'done', 28000, '2026-02-21 23:31:29', '2026-02-22 06:41:02'),
(20, 7, 11, 2, 'takeaway', '', 'done', 10000, '2026-02-21 23:34:19', '2026-02-22 06:41:05'),
(21, 8, 10, 1, 'takeaway', '', 'done', 28000, '2026-02-21 23:34:26', '2026-02-22 06:41:07'),
(22, 9, 10, 1, 'takeaway', '', 'done', 28000, '2026-02-21 23:35:58', '2026-02-22 06:41:10'),
(23, 10, 10, 1, 'takeaway', '', 'done', 28000, '2026-02-21 23:40:01', '2026-02-22 06:41:04'),
(24, 11, 10, 1, 'dinein', '', 'done', 28000, '2026-02-21 23:43:49', '2026-02-22 06:44:05'),
(25, 11, 13, 1, 'dinein', '', 'done', 25000, '2026-02-21 23:43:49', '2026-02-22 06:44:15'),
(26, 11, 11, 2, 'dinein', '', 'done', 10000, '2026-02-21 23:43:49', '2026-02-22 06:44:07'),
(27, 11, 12, 1, 'dinein', '', 'done', 6000, '2026-02-21 23:43:49', '2026-02-22 06:44:11'),
(28, 12, 10, 2, NULL, NULL, 'processing', 56000, NULL, NULL),
(29, 13, 10, 2, NULL, NULL, 'processing', 56000, NULL, NULL),
(30, 14, 9, 2, NULL, NULL, 'processing', 50000, NULL, NULL),
(31, 14, 11, 2, NULL, NULL, 'processing', 10000, NULL, NULL),
(32, 14, 12, 2, NULL, NULL, 'processing', 12000, NULL, NULL),
(33, 15, 9, 2, NULL, NULL, 'processing', 50000, NULL, NULL),
(34, 15, 11, 2, NULL, NULL, 'processing', 10000, NULL, NULL),
(35, 15, 9, 5, NULL, NULL, 'processing', 125000, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `karyawans`
--

CREATE TABLE `karyawans` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nama_karyawan` varchar(255) NOT NULL,
  `no_hp` varchar(255) DEFAULT NULL,
  `alamat` text DEFAULT NULL,
  `jabatan` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `karyawans`
--

INSERT INTO `karyawans` (`id`, `nama_karyawan`, `no_hp`, `alamat`, `jabatan`, `created_at`, `updated_at`) VALUES
(1, 'Ryan', NULL, NULL, 'chef', '2026-02-21 00:03:49', '2026-02-21 00:03:49'),
(2, 'Intan', NULL, NULL, 'kasir', '2026-02-21 00:04:13', '2026-02-21 00:04:13');

-- --------------------------------------------------------

--
-- Table structure for table `kategoris`
--

CREATE TABLE `kategoris` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nama_kategori` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `kategoris`
--

INSERT INTO `kategoris` (`id`, `nama_kategori`, `created_at`, `updated_at`) VALUES
(1, 'Makanan', NULL, NULL),
(2, 'minuman', NULL, NULL),
(3, 'Cemilan', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `mejas`
--

CREATE TABLE `mejas` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nomor_meja` varchar(255) NOT NULL,
  `status` enum('available','booking') DEFAULT 'available',
  `kapasitas` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mejas`
--

INSERT INTO `mejas` (`id`, `nomor_meja`, `status`, `kapasitas`, `created_at`, `updated_at`) VALUES
(1, '10', 'available', 4, '2026-02-21 00:58:01', '2026-02-21 00:58:01'),
(2, '11', 'available', 4, '2026-02-21 07:42:00', '2026-02-21 07:42:00'),
(3, '15', 'available', 4, '2026-02-21 23:31:13', '2026-02-21 23:31:13'),
(4, '2', 'available', 4, NULL, NULL),
(5, '1', 'available', 4, NULL, NULL),
(6, '5', 'available', 2, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `menus`
--

CREATE TABLE `menus` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nama_menu` varchar(255) NOT NULL,
  `harga` int(11) NOT NULL,
  `id_kategori` bigint(20) UNSIGNED DEFAULT NULL,
  `stok_porsi` int(11) DEFAULT NULL,
  `foto` varchar(255) DEFAULT NULL,
  `deskripsi` text DEFAULT NULL,
  `status` enum('available','sold out') DEFAULT 'available',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `menus`
--

INSERT INTO `menus` (`id`, `nama_menu`, `harga`, `id_kategori`, `stok_porsi`, `foto`, `deskripsi`, `status`, `created_at`, `updated_at`) VALUES
(8, 'mie goreng jomokerto', 15000, NULL, 29, '1771648605_6999365da4b29.jpg', '', 'available', '2026-02-20 21:32:12', '2026-02-20 21:36:45'),
(9, 'nasi goreng firaun', 25000, NULL, 48, '1771648674_699936a29a17c.jpg', '', 'available', '2026-02-20 21:37:54', '2026-02-20 21:40:47'),
(10, 'Nasgor Seafood', 28000, NULL, 21, '1771658318_69995c4e52d4b.jpg', '', 'available', '2026-02-21 00:18:38', '2026-02-21 00:18:38'),
(11, 'Es teh', 5000, NULL, 56, '1771658409_69995ca90afd0.jpg', '', 'available', '2026-02-21 00:20:09', '2026-02-21 00:20:09'),
(12, 'Es Jeruk', 6000, NULL, 63, '1771658585_69995d595d274.jpg', '', 'available', '2026-02-21 00:23:05', '2026-02-21 00:23:05'),
(13, 'ayam goreng bawang putih', 25000, NULL, 40, '1771658975_69995edf4e156.jpg', '', 'available', '2026-02-21 00:29:35', '2026-02-21 00:29:35'),
(14, 'nasgor bugis', 20000, 1, 40, NULL, NULL, 'available', NULL, NULL),
(15, 'mie goreng', 18000, 1, 50, NULL, NULL, 'available', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `orderans`
--

CREATE TABLE `orderans` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nama_konsumen` varchar(255) NOT NULL,
  `total_bayar` int(11) DEFAULT NULL,
  `tanggal_orderan` datetime DEFAULT NULL,
  `status` enum('pending','dibayar','batal') DEFAULT 'pending',
  `id_user` bigint(20) UNSIGNED DEFAULT NULL,
  `id_meja` bigint(20) UNSIGNED DEFAULT NULL,
  `metode_pembayaran` enum('cash','qris','cashless') DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orderans`
--

INSERT INTO `orderans` (`id`, `nama_konsumen`, `total_bayar`, `tanggal_orderan`, `status`, `id_user`, `id_meja`, `metode_pembayaran`, `created_at`, `updated_at`) VALUES
(1, 'bizor', 64000, '2026-02-21 08:58:01', 'dibayar', 5, 1, 'cash', '2026-02-21 00:58:01', '2026-02-21 00:58:01'),
(2, 'rusdi', 88000, '2026-02-21 15:35:00', 'dibayar', 5, NULL, 'qris', '2026-02-21 07:35:00', '2026-02-21 07:35:00'),
(3, 'rxs', 76000, '2026-02-21 15:42:00', 'dibayar', 5, 2, 'cash', '2026-02-21 07:42:00', '2026-02-21 07:42:00'),
(4, 'benua dev', 38000, '2026-02-22 06:19:44', 'dibayar', 5, NULL, 'qris', '2026-02-21 22:19:44', '2026-02-21 22:19:44'),
(5, 'Benua Dev', 64000, '2026-02-22 07:31:13', 'dibayar', 5, 3, 'cash', '2026-02-21 23:31:13', '2026-02-21 23:31:13'),
(6, 'rei', 28000, '2026-02-22 07:31:29', 'dibayar', 5, NULL, 'cash', '2026-02-21 23:31:29', '2026-02-21 23:31:29'),
(7, 'tes', 10000, '2026-02-22 07:34:19', 'dibayar', 5, NULL, 'cash', '2026-02-21 23:34:19', '2026-02-21 23:34:19'),
(8, 'tes', 28000, '2026-02-22 07:34:26', 'dibayar', 5, NULL, 'cash', '2026-02-21 23:34:26', '2026-02-21 23:34:26'),
(9, 'tes', 28000, '2026-02-22 07:35:58', 'dibayar', 5, NULL, 'cash', '2026-02-21 23:35:58', '2026-02-21 23:35:58'),
(10, 'tes', 28000, '2026-02-22 07:40:01', 'dibayar', 5, NULL, 'cash', '2026-02-21 23:40:01', '2026-02-21 23:40:01'),
(11, 'Benua Dev', 69000, '2026-02-22 07:43:49', 'dibayar', 5, 1, 'cash', '2026-02-21 23:43:49', '2026-02-21 23:43:49'),
(12, 'Customer', 56000, '2026-02-26 01:50:34', 'dibayar', NULL, 4, 'cash', NULL, NULL),
(13, 'Customer', 56000, '2026-02-26 02:08:22', 'dibayar', NULL, 5, 'cash', NULL, NULL),
(14, 'Customer', 72000, '2026-02-26 10:18:49', 'dibayar', NULL, 5, 'cash', NULL, NULL),
(15, 'Customer', 185000, '2026-02-26 10:37:59', 'dibayar', NULL, 1, 'cash', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `update_stokharians`
--

CREATE TABLE `update_stokharians` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `id_menu` bigint(20) UNSIGNED DEFAULT NULL,
  `jumlah_porsi` int(11) DEFAULT NULL,
  `tanggal_update` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','kasir','chef') NOT NULL,
  `status` enum('aktif','nonaktif') DEFAULT 'aktif',
  `id_karyawan` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password`, `role`, `status`, `id_karyawan`, `created_at`, `updated_at`) VALUES
(4, 'ryan70', 'Chef@gmail.com', '$2y$10$./PKOEv86pg/IqLtzZckxuPw9HiXVAjkHSDZKqPSd.N20ObVsARw2', 'chef', 'aktif', 1, '2026-02-21 00:03:49', '2026-02-21 00:03:49'),
(5, 'intan76', 'Kasir@gmail.com', '$2y$10$2hofraBFqbT80VvvF8qmaOz7Ac9QTLRw3y5b/vQXQ1VvDEIsdvls.', 'kasir', 'aktif', 2, '2026-02-21 00:04:13', '2026-02-21 00:04:13'),
(6, 'bayu', 'kasir2@gmail.com', '123456', 'kasir', 'aktif', NULL, NULL, NULL),
(7, 'abi', 'Chef2@gmail.com', '123456', 'chef', 'aktif', NULL, NULL, NULL),
(8, 'admin', 'admin@gmail.com', 'admin123', 'admin', 'aktif', NULL, NULL, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `detail_orderans`
--
ALTER TABLE `detail_orderans`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_orderan` (`id_orderan`),
  ADD KEY `id_menu` (`id_menu`);

--
-- Indexes for table `karyawans`
--
ALTER TABLE `karyawans`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `kategoris`
--
ALTER TABLE `kategoris`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mejas`
--
ALTER TABLE `mejas`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `menus`
--
ALTER TABLE `menus`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_kategori` (`id_kategori`);

--
-- Indexes for table `orderans`
--
ALTER TABLE `orderans`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_user` (`id_user`),
  ADD KEY `id_meja` (`id_meja`);

--
-- Indexes for table `update_stokharians`
--
ALTER TABLE `update_stokharians`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_menu` (`id_menu`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_karyawan` (`id_karyawan`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `detail_orderans`
--
ALTER TABLE `detail_orderans`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `karyawans`
--
ALTER TABLE `karyawans`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `kategoris`
--
ALTER TABLE `kategoris`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `mejas`
--
ALTER TABLE `mejas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `menus`
--
ALTER TABLE `menus`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `orderans`
--
ALTER TABLE `orderans`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `update_stokharians`
--
ALTER TABLE `update_stokharians`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `detail_orderans`
--
ALTER TABLE `detail_orderans`
  ADD CONSTRAINT `detail_orderans_ibfk_1` FOREIGN KEY (`id_orderan`) REFERENCES `orderans` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `detail_orderans_ibfk_2` FOREIGN KEY (`id_menu`) REFERENCES `menus` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `menus`
--
ALTER TABLE `menus`
  ADD CONSTRAINT `menus_ibfk_1` FOREIGN KEY (`id_kategori`) REFERENCES `kategoris` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `orderans`
--
ALTER TABLE `orderans`
  ADD CONSTRAINT `orderans_ibfk_1` FOREIGN KEY (`id_user`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `orderans_ibfk_2` FOREIGN KEY (`id_meja`) REFERENCES `mejas` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `update_stokharians`
--
ALTER TABLE `update_stokharians`
  ADD CONSTRAINT `update_stokharians_ibfk_1` FOREIGN KEY (`id_menu`) REFERENCES `menus` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`id_karyawan`) REFERENCES `karyawans` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
