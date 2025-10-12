-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 19, 2025 at 03:57 PM
-- Server version: 10.4.25-MariaDB
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hr_management`
--

-- --------------------------------------------------------

--
-- Table structure for table `attendance_logs`
--

CREATE TABLE `attendance_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `employee_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `device_id` bigint(20) UNSIGNED DEFAULT NULL,
  `user_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `punch_time` timestamp NULL DEFAULT NULL,
  `type` enum('fingerprint','manual') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'fingerprint',
  `direction` enum('in','out') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `latitude` decimal(10,7) DEFAULT NULL,
  `longitude` decimal(10,7) DEFAULT NULL,
  `location_text` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `raw_payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`raw_payload`)),
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `deleted_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `attendance_logs`
--

INSERT INTO `attendance_logs` (`id`, `employee_id`, `device_id`, `user_id`, `punch_time`, `type`, `direction`, `latitude`, `longitude`, `location_text`, `raw_payload`, `created_by`, `created_at`, `updated_at`, `updated_by`, `deleted_at`, `deleted_by`) VALUES
(1, '0002', NULL, '2', '2025-08-18 13:57:35', 'manual', 'in', '23.8277957', '90.4306185', NULL, NULL, NULL, '2025-08-18 13:57:35', '2025-08-18 13:57:35', NULL, NULL, NULL),
(2, '0002', NULL, '2', '2025-08-18 16:11:03', 'manual', 'in', '23.8222151', '90.4225428', NULL, NULL, NULL, '2025-08-18 16:11:03', '2025-08-18 16:11:03', NULL, NULL, NULL),
(3, '0002', NULL, '2', '2025-08-18 16:11:11', 'manual', 'in', '23.8222151', '90.4225428', NULL, NULL, NULL, '2025-08-18 16:11:11', '2025-08-18 16:11:11', NULL, NULL, NULL),
(4, '0002', NULL, '2', '2025-08-18 16:12:45', 'manual', 'out', '23.8222151', '90.4225428', NULL, NULL, NULL, '2025-08-18 16:12:45', '2025-08-18 16:12:45', NULL, NULL, NULL),
(5, '0002', NULL, '2', '2025-08-18 16:14:16', 'manual', 'out', '23.8222151', '90.4225428', NULL, NULL, NULL, '2025-08-18 16:14:16', '2025-08-18 16:14:16', NULL, NULL, NULL),
(6, '0002', NULL, '2', '2025-08-18 16:14:18', 'manual', 'in', '23.8222151', '90.4225428', NULL, NULL, NULL, '2025-08-18 16:14:18', '2025-08-18 16:14:18', NULL, NULL, NULL),
(7, '0002', NULL, '2', '2025-08-18 16:14:44', 'manual', 'in', '23.8222151', '90.4225428', NULL, NULL, NULL, '2025-08-18 16:14:44', '2025-08-18 16:14:44', NULL, NULL, NULL),
(8, '0003', NULL, '3', '2025-08-18 16:28:41', 'manual', 'in', '23.8222151', '90.4225428', NULL, NULL, NULL, '2025-08-18 16:28:41', '2025-08-18 16:28:41', NULL, NULL, NULL),
(9, '0003', NULL, '3', '2025-08-18 16:30:41', 'manual', 'out', '23.8277929', '90.4306235', NULL, NULL, NULL, '2025-08-18 16:30:41', '2025-08-18 16:30:41', NULL, NULL, NULL),
(10, '0003', NULL, '3', '2025-08-18 16:32:56', 'manual', 'in', '23.8222151', '90.4225428', NULL, NULL, NULL, '2025-08-18 16:32:56', '2025-08-18 16:32:56', NULL, NULL, NULL),
(11, '0003', NULL, '3', '2025-08-18 16:33:03', 'manual', 'out', '23.8222151', '90.4225428', NULL, NULL, NULL, '2025-08-18 16:33:03', '2025-08-18 16:33:03', NULL, NULL, NULL),
(12, '0003', NULL, '3', '2025-08-18 16:33:19', 'manual', 'in', '23.8222151', '90.4225428', NULL, NULL, NULL, '2025-08-18 16:33:19', '2025-08-18 16:33:19', NULL, NULL, NULL),
(13, '0003', NULL, '3', '2025-08-18 16:33:29', 'manual', 'out', '23.8222151', '90.4225428', NULL, NULL, NULL, '2025-08-18 16:33:29', '2025-08-18 16:33:29', NULL, NULL, NULL),
(14, '0003', NULL, '3', '2025-08-18 16:34:53', 'manual', 'in', '23.8222151', '90.4225428', NULL, NULL, NULL, '2025-08-18 16:34:53', '2025-08-18 16:34:53', NULL, NULL, NULL),
(15, '0003', NULL, '3', '2025-08-18 16:35:21', 'manual', 'out', '23.8222151', '90.4225428', NULL, NULL, NULL, '2025-08-18 16:35:21', '2025-08-18 16:35:21', NULL, NULL, NULL),
(16, '0003', NULL, '3', '2025-08-18 16:35:25', 'manual', 'in', '23.8222151', '90.4225428', NULL, NULL, NULL, '2025-08-18 16:35:25', '2025-08-18 16:35:25', NULL, NULL, NULL),
(17, '0003', NULL, '3', '2025-08-18 16:35:39', 'manual', 'in', '23.8222151', '90.4225428', NULL, NULL, NULL, '2025-08-18 16:35:39', '2025-08-18 16:35:39', NULL, NULL, NULL),
(18, '0003', NULL, '3', '2025-08-18 16:35:45', 'manual', 'out', '23.8222151', '90.4225428', NULL, NULL, NULL, '2025-08-18 16:35:45', '2025-08-18 16:35:45', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `branches`
--

CREATE TABLE `branches` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `deleted_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `branches`
--

INSERT INTO `branches` (`id`, `name`, `slug`, `address`, `created_by`, `created_at`, `updated_at`, `updated_by`, `deleted_at`, `deleted_by`) VALUES
(1, 'Quincy Schultz', 'quincy-schultz', 'Corrupti laboris om', 1, '2025-08-17 13:43:27', '2025-08-17 13:43:27', NULL, NULL, NULL),
(2, 'Larissa Riggs', 'larissa-riggs', 'Optio dolores asper', 1, '2025-08-17 13:43:31', '2025-08-17 13:43:31', NULL, NULL, NULL),
(3, 'Evangeline Baird', 'evangeline-baird', 'Doloribus aliquam vo', 1, '2025-08-17 13:43:39', '2025-08-17 13:43:39', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `departments`
--

CREATE TABLE `departments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `deleted_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `departments`
--

INSERT INTO `departments` (`id`, `name`, `slug`, `description`, `created_by`, `created_at`, `updated_at`, `updated_by`, `deleted_at`, `deleted_by`) VALUES
(1, 'Cadman Clark', 'cadman-clark', 'Quia itaque commodi', 1, '2025-08-18 13:55:17', '2025-08-18 13:55:17', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `designations`
--

CREATE TABLE `designations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `deleted_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `designations`
--

INSERT INTO `designations` (`id`, `name`, `slug`, `description`, `created_by`, `created_at`, `updated_at`, `updated_by`, `deleted_at`, `deleted_by`) VALUES
(1, 'Joy Frye', 'joy-frye', 'Perspiciatis ration', 1, '2025-08-18 13:55:03', '2025-08-18 13:55:03', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `devices`
--

CREATE TABLE `devices` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `branch_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `serial_no` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ip` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('active','inactive') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `last_seen_at` timestamp NULL DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `deleted_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `devices`
--

INSERT INTO `devices` (`id`, `branch_id`, `name`, `slug`, `serial_no`, `ip`, `status`, `last_seen_at`, `created_by`, `created_at`, `updated_at`, `updated_by`, `deleted_at`, `deleted_by`) VALUES
(1, 1, 'Colin Franco', 'colin-franco', 'Et deleniti et quasi', '127.0.0.1', 'active', NULL, 1, '2025-08-17 13:44:54', '2025-08-17 13:52:31', 1, NULL, NULL),
(2, 1, 'Barrett Lewis', 'barrett-lewis', 'Laboriosam est fugi', '127.0.0.1', 'active', NULL, 1, '2025-08-17 13:47:11', '2025-08-17 13:50:31', 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `device_commands`
--

CREATE TABLE `device_commands` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `device_id` bigint(20) UNSIGNED NOT NULL,
  `command_text` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('pending','sent','done','failed') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `executed_at` timestamp NULL DEFAULT NULL,
  `response` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `device_employees`
--

CREATE TABLE `device_employees` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `employee_id` bigint(20) UNSIGNED DEFAULT NULL,
  `device_id` bigint(20) UNSIGNED DEFAULT NULL,
  `status` enum('add_pending','delete_pending','synced','failed') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'add_pending',
  `synced_at` timestamp NULL DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `deleted_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `finger_prints`
--

CREATE TABLE `finger_prints` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `employee_id` bigint(20) UNSIGNED NOT NULL,
  `finger_index` tinyint(3) UNSIGNED NOT NULL DEFAULT 0,
  `template` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `format` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ZK',
  `source_device_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `deleted_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2019_08_19_000000_create_failed_jobs_table', 1),
(4, '2019_12_14_000001_create_personal_access_tokens_table', 1),
(5, '2025_07_12_115914_create_designations_table', 1),
(6, '2025_08_04_174107_create_departments_table', 1),
(7, '2025_08_17_182520_create_branches_table', 1),
(8, '2025_08_17_182928_create_devices_table', 1),
(9, '2025_08_17_183022_create_device_commands_table', 1),
(10, '2025_08_17_183042_create_device_employees_table', 1),
(11, '2025_08_17_183105_create_finger_prints_table', 1),
(12, '2025_08_17_183130_create_attendance_logs_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `role` enum('admin','employee') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'employee',
  `employee_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `department_id` int(11) DEFAULT NULL,
  `designation_id` int(11) DEFAULT NULL,
  `branch_id` bigint(20) UNSIGNED DEFAULT NULL,
  `card_no` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `device_user_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mobile` varchar(11) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password_plain` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(400) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cv_path` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` enum('active','inactive') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'active',
  `last_login_at` datetime DEFAULT NULL,
  `last_logout_at` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `created_by` int(11) NOT NULL,
  `password_reset_code` int(11) DEFAULT NULL,
  `two_factor_code` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `two_factor_expires_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `deleted_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `role`, `employee_id`, `department_id`, `designation_id`, `branch_id`, `card_no`, `device_user_id`, `name`, `email`, `mobile`, `password_plain`, `password`, `remember_token`, `image`, `cv_path`, `status`, `last_login_at`, `last_logout_at`, `created_at`, `updated_at`, `created_by`, `password_reset_code`, `two_factor_code`, `two_factor_expires_at`, `deleted_at`, `deleted_by`) VALUES
(1, 'admin', '0001', 1, 1, NULL, NULL, NULL, 'Mr. Admin', 'admin@mail.com', '12345679810', '123456', '$2y$10$cLzAtFkTpywEKgOmKVPOeeiFuBYjLkLqvsMOYxgmKXgnWFYzXVOJq', NULL, NULL, NULL, 'active', '2025-08-18 23:58:49', NULL, '2025-08-17 13:36:06', '2025-08-18 17:58:49', 1, NULL, NULL, NULL, NULL, NULL),
(2, 'employee', '0002', 1, 1, NULL, NULL, NULL, 'Zane Huber', 'wypi@mailinator.com', '01609605489', '123456', '$2y$10$cLzAtFkTpywEKgOmKVPOeeiFuBYjLkLqvsMOYxgmKXgnWFYzXVOJq', NULL, NULL, NULL, 'active', NULL, NULL, '2025-08-18 13:55:41', '2025-08-18 15:30:06', 1, NULL, NULL, NULL, NULL, NULL),
(3, 'employee', '0003', 1, 1, NULL, NULL, NULL, 'Yeo Knapp', 'dele@mailinator.com', '01609605898', '123456', '$2y$10$jixQ6piVvRrqEdWAAuhZS.YHBeCIKru8gZSWHBC.UAxbX/zoMasNe', NULL, NULL, NULL, 'active', '2025-08-18 22:28:37', NULL, '2025-08-18 13:56:02', '2025-08-18 16:28:37', 1, NULL, NULL, NULL, NULL, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `attendance_logs`
--
ALTER TABLE `attendance_logs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uniq_attendance_triplet` (`employee_id`,`punch_time`,`device_id`);

--
-- Indexes for table `branches`
--
ALTER TABLE `branches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `designations`
--
ALTER TABLE `designations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `devices`
--
ALTER TABLE `devices`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `devices_serial_no_unique` (`serial_no`),
  ADD KEY `devices_branch_id_foreign` (`branch_id`);

--
-- Indexes for table `device_commands`
--
ALTER TABLE `device_commands`
  ADD PRIMARY KEY (`id`),
  ADD KEY `device_commands_device_id_foreign` (`device_id`);

--
-- Indexes for table `device_employees`
--
ALTER TABLE `device_employees`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `device_employees_employee_id_device_id_unique` (`employee_id`,`device_id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `finger_prints`
--
ALTER TABLE `finger_prints`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `finger_prints_employee_id_finger_index_unique` (`employee_id`,`finger_index`),
  ADD KEY `finger_prints_source_device_id_foreign` (`source_device_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD UNIQUE KEY `users_mobile_unique` (`mobile`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `attendance_logs`
--
ALTER TABLE `attendance_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `branches`
--
ALTER TABLE `branches`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `departments`
--
ALTER TABLE `departments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `designations`
--
ALTER TABLE `designations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `devices`
--
ALTER TABLE `devices`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `device_commands`
--
ALTER TABLE `device_commands`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `device_employees`
--
ALTER TABLE `device_employees`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `finger_prints`
--
ALTER TABLE `finger_prints`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `devices`
--
ALTER TABLE `devices`
  ADD CONSTRAINT `devices_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `device_commands`
--
ALTER TABLE `device_commands`
  ADD CONSTRAINT `device_commands_device_id_foreign` FOREIGN KEY (`device_id`) REFERENCES `devices` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `finger_prints`
--
ALTER TABLE `finger_prints`
  ADD CONSTRAINT `finger_prints_source_device_id_foreign` FOREIGN KEY (`source_device_id`) REFERENCES `devices` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
