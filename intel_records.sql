-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 05, 2025 at 02:44 AM
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
-- Database: `intel_records`
--

-- --------------------------------------------------------

--
-- Table structure for table `activity_logs`
--

CREATE TABLE `activity_logs` (
  `log_id` int(11) NOT NULL,
  `officer_id` varchar(50) NOT NULL,
  `action` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `activity_logs`
--

INSERT INTO `activity_logs` (`log_id`, `officer_id`, `action`, `description`, `date`) VALUES
(170, 'intel_pres', 'Login', 'User logged in successfully', '2025-03-11 17:00:57'),
(171, 'intel_pres', 'Login', 'User logged in successfully', '2025-03-12 03:23:42'),
(172, 'intel_pres', 'Add Payment', 'Payment of ₱100 added for Member: Marianita Palagar (ID: 2021-09843)', '2025-03-12 03:28:58'),
(173, 'intel_pres', 'Delete Member', 'Deleted member: Marianita Palagar (ID: 2021-09843)', '2025-03-12 03:29:04'),
(174, 'intel_pres', 'Delete Member', 'Deleted member: Rechell Ann Penaranda (ID: 2023-04027)', '2025-03-12 03:29:23'),
(175, 'intel_pres', 'Delete Member', 'Deleted member: Quency Athena Gariando (ID: 2023-12578)', '2025-03-12 09:19:02'),
(176, 'intel_pres', 'Import Member', 'Imported member: Quency Athena Gariando (ID: 2023-12578)', '2025-03-12 09:19:14'),
(177, 'intel_pres', 'Import Member', 'Imported member: Marianita Palagar (ID: 2021-09843)', '2025-03-12 09:19:14'),
(178, 'intel_pres', 'Login', 'User logged in successfully', '2025-03-13 01:11:21'),
(179, 'intel_pres', 'Login', 'User logged in successfully', '2025-03-17 02:58:41'),
(180, 'intel_pres', 'Update Member', 'Updated member: Phil Sebastian Cainong (ID: 2023-10982)', '2025-03-17 02:59:22'),
(181, 'intel_pres', 'Update Member', 'Updated member: Phil Sebastian Cainong (ID: 2023-10982)', '2025-03-17 03:01:30'),
(182, 'intel_pres', 'Update Member', 'Updated member: Phil Sebastian Cainong (ID: 2023-10982)', '2025-03-17 03:03:30'),
(183, 'intel_pres', 'Login', 'User logged in successfully', '2025-03-17 04:09:44'),
(184, 'intel_pres', 'Login', 'User logged in successfully', '2025-03-18 05:14:04'),
(185, 'intel_pres', 'Update Member', 'Updated member: Phil Sebastian Cainong (ID: 2023-10982)', '2025-03-18 05:17:23'),
(186, 'intel_pres', 'Update Member', 'Updated member: Phil Sebastian Cainong (ID: 2023-10982)', '2025-03-18 05:20:15'),
(187, 'intel_pres', 'Update Member', 'Updated member: Phil Sebastian Cainong (ID: 2023-10982)', '2025-03-18 05:20:24'),
(188, 'intel_pres', 'Update Member', 'Updated member: Marianita Palagar (ID: 2021-09843)', '2025-03-18 05:20:35'),
(189, 'intel_pres', 'Delete Member', 'Deleted member: Quency Athena Gariando (ID: 2023-12578)', '2025-03-18 05:21:15'),
(190, 'intel_pres', 'Import Member', 'Imported member: Quency Athena Gariando (ID: 2023-12578)', '2025-03-18 05:21:58'),
(191, 'intel_pres', 'Update Member', 'Updated member: Marianita Palagar (ID: 2021-09843)', '2025-03-18 05:22:31'),
(192, 'intel_pres', 'Update Member', 'Updated member: Marianita Palagar (ID: 2021-09843)', '2025-03-18 05:33:34'),
(193, 'intel_pres', 'Update Member', 'Updated member: Marianita Palagar (ID: 2021-09843)', '2025-03-18 05:33:37'),
(194, 'intel_pres', 'Update Member', 'Updated member: Marianita Palagar (ID: 2021-09843)', '2025-03-18 05:33:38'),
(195, 'intel_pres', 'Update Member', 'Updated member: Marianita Palagar (ID: 2021-09843)', '2025-03-18 05:34:29'),
(196, 'intel_pres', 'Login', 'User logged in successfully', '2025-03-21 13:47:56'),
(197, 'intel_pres', 'Login', 'User logged in successfully', '2025-03-21 13:58:37'),
(198, 'intel_pres', 'Login', 'User logged in successfully', '2025-03-26 06:26:37'),
(199, 'intel_pres', 'Login', 'User logged in successfully', '2025-04-03 16:31:16'),
(200, 'intel_pres', 'Add Member', 'Added member: Sean Oliver Lopez (ID: 2025-14647)', '2025-04-03 22:01:00'),
(201, 'intel_pres', 'Add Fee', 'Added fee: INTEL FEE (₱0.00) for Sean Oliver Lopez', '2025-04-03 22:01:00'),
(202, 'intel_pres', 'Delete Member', 'Deleted member: Sean Oliver Lopez (ID: 2023-98745)', '2025-04-03 22:06:16'),
(203, 'intel_pres', 'Add Member', 'Added member: Sean Oliver Lopez (ID: 2024-09234)', '2025-04-03 22:07:12'),
(204, 'intel_pres', 'Add Fee', 'Added fee: INTEL FEE (₱100) for Sean Oliver Lopez', '2025-04-03 22:07:12'),
(205, 'intel_pres', 'Add Payment', 'Payment of ₱100 added for Member: Phil Sebastian Cainong (ID: 2023-10982)', '2025-04-03 22:17:20'),
(206, 'intel_pres', 'Update Fees', 'Reduced fees by ₱100 for Member: Phil Sebastian Cainong (ID: 2023-10982)', '2025-04-03 22:17:20'),
(207, 'intel_pres', 'Add Payment', 'Payment of ₱100 added for Member: Phil Sebastian Cainong (ID: 2023-10982)', '2025-04-04 08:00:52'),
(208, 'intel_pres', 'Delete Fee', 'Deleted fee for Semester: 1st semester, SY: 23-24', '2025-04-04 08:00:52'),
(209, 'intel_pres', 'Add Payment', 'Payment of ₱100 added for Member: Sean Oliver Lopez (ID: 2024-09234)', '2025-04-04 08:02:36'),
(210, 'intel_pres', 'Delete Fee', 'Deleted fee for Semester: 2nd semester, SY: 24-25', '2025-04-04 08:02:36'),
(211, 'intel_pres', 'Add Payment', 'Payment of ₱100 added for Member: Sean Oliver Lopez (ID: 2024-09234)', '2025-04-04 08:03:23'),
(212, 'intel_pres', 'Delete Fee', 'Deleted fee for Semester: 1st semester, SY: 24-25', '2025-04-04 08:03:23'),
(213, 'intel_pres', 'Add Payment', 'Payment of ₱100 added for Member: Phil Sebastian Cainong (ID: 2023-10982)', '2025-04-04 08:07:15'),
(214, 'intel_pres', 'Delete Fee', 'Deleted fee for Semester: 2ns semester, SY: 23-24', '2025-04-04 08:07:15'),
(215, 'intel_pres', 'Update Member', 'Updated member: Zhen Mae Hersan (ID: 2023-04321)', '2025-04-04 08:32:50'),
(216, 'intel_pres', 'Update Fees', 'Updated fees for Zhen Mae Hersan: ₱100, Semesters: 1, School Years: 1', '2025-04-04 08:32:50'),
(217, 'intel_pres', 'Add Fees', 'Added fee: Standard Fee (₱100) for Semester: 1st Semester, SY: 24-25', '2025-04-04 09:11:21'),
(218, 'intel_pres', 'Add Fees', 'Added fee: INTEL FEE (₱100) for Semester: 2nd Semester, SY: 24-25', '2025-04-04 09:22:29'),
(219, 'intel_pres', 'Add Payment', 'Payment of ₱100 added for Member: Zhen Mae Hersan (ID: 2023-04321)', '2025-04-04 09:25:59'),
(220, 'intel_pres', 'Delete Fee', 'Deleted fee for Semester: 1st semester, SY: 24-25', '2025-04-04 09:25:59'),
(221, 'intel_pres', 'Add Payment', 'Payment of ₱100 added for Member: Phil Sebastian Cainong (ID: 2023-10982)', '2025-04-04 09:30:51'),
(222, 'intel_pres', 'Delete Fee', 'Deleted fee for Semester: 1st semester, SY: 24-25', '2025-04-04 09:30:51'),
(223, 'intel_pres', 'Delete Member', 'Deleted member: Sean Oliver Lopez (ID: 2023-14647)', '2025-04-04 09:34:33'),
(224, 'intel_pres', 'Delete Member', 'Deleted member: Sean Oliver Lopez (ID: 2025-14647)', '2025-04-04 09:34:39'),
(225, 'intel_pres', 'Add Payment', 'Payment of ₱100 added for Member: Quency Athena Gariando (ID: 2023-12578)', '2025-04-04 09:36:35'),
(226, 'intel_pres', 'Delete Fee', 'Deleted fee for Semester: 1st Semester, SY: 24-25', '2025-04-04 09:36:35'),
(227, 'intel_pres', 'Add Member', 'Added member: Marilyn Asebto (ID: 2024-16754)', '2025-04-04 09:49:08'),
(228, 'intel_pres', 'Add Fee', 'Added fee: INTEL FEE (₱100) for Marilyn Asebto', '2025-04-04 09:49:08'),
(229, 'intel_vpres', 'Login', 'User logged in successfully', '2025-04-04 10:29:30'),
(230, 'intel_pres', 'Login', 'User logged in successfully', '2025-04-04 10:45:18'),
(231, 'intel_vpres', 'Login', 'User logged in successfully', '2025-04-04 10:49:26'),
(232, 'intel_pres', 'Login', 'User logged in successfully', '2025-04-04 10:50:12'),
(233, 'intel_vpres', 'Login', 'User logged in successfully', '2025-04-04 10:54:06'),
(234, 'intel_pres', 'Login', 'User logged in successfully', '2025-04-04 11:01:40'),
(235, 'intel_vpres', 'Login', 'User logged in successfully', '2025-04-04 11:02:33'),
(236, 'intel_pres', 'Login', 'User logged in successfully', '2025-04-04 11:03:16'),
(237, 'intel_vpres', 'Login', 'User logged in successfully', '2025-04-04 11:06:20'),
(238, 'intel_pres', 'Login', 'User logged in successfully', '2025-04-04 11:08:29'),
(239, 'intel_vpres', 'Login', 'User logged in successfully', '2025-04-04 11:19:59'),
(240, 'intel_pres', 'Login', 'User logged in successfully', '2025-04-04 11:20:21'),
(241, 'intel_vpres', 'Login', 'User logged in successfully', '2025-04-04 11:23:02'),
(242, 'intel_pres', 'Login', 'User logged in successfully', '2025-04-04 11:23:24'),
(243, 'intel_pres', 'Login', 'User logged in successfully', '2025-04-04 12:11:50'),
(244, 'intel_vpres', 'Login', 'User logged in successfully', '2025-04-04 12:12:02'),
(245, 'intel_pres', 'Login', 'User logged in successfully', '2025-04-04 12:13:58'),
(246, 'intel_pres', 'Add Payment', 'Payment of ₱100 added for Member: Leonice Narbonita (ID: 2023-11780), Semester: 1st Semester, SY: 24-25', '2025-04-04 12:22:46'),
(247, 'intel_pres', 'Delete Fee', 'Deleted fee for Semester: 1st Semester, SY: 24-25', '2025-04-04 12:22:46'),
(248, 'intel_pres', 'Add Payment', 'Payment of ₱100 added for Member: Leonice Narbonita (ID: 2023-11780), Semester: 2nd Semester, SY: 24-25', '2025-04-04 12:22:46'),
(249, 'intel_pres', 'Delete Fee', 'Deleted fee for Semester: 2nd Semester, SY: 24-25', '2025-04-04 12:22:46'),
(250, 'intel_pres', 'Add Fees', 'Added fee: INTEL FEE (₱100) for Semester: 1st Semester, SY: 24-25', '2025-04-04 12:23:17'),
(251, 'intel_pres', 'Add Fees', 'Added fee: INTEL FEE (₱100) for Semester: 2nd Semester, SY: 24-25', '2025-04-04 12:23:28'),
(252, 'intel_pres', 'Add Fees', 'Added fee: INTEL FEE (₱100) for Semester: 1st Semester, SY: 24-25', '2025-04-04 12:27:36'),
(253, 'intel_pres', 'Add Fees', 'Added fee: INTEL FEE (₱100) for Semester: 1st Semester, SY: 2024-2025', '2025-04-04 12:37:27'),
(254, 'intel_pres', 'Add Fees', 'Added fee: INTEL FEE (₱100) for Semester: 2nd Semester, SY: 2024-2025', '2025-04-04 12:37:41'),
(255, 'intel_pres', 'Add Fees', 'Added fee: INTEL FEE (₱100) for Semester: 2nd Semester, SY: 2024-2025', '2025-04-04 12:37:56'),
(256, 'intel_pres', 'Add Fees', 'Added fee: INTEL FEE (₱100) for Semester: 2nd Semester, SY: 2024-2025', '2025-04-04 12:41:19'),
(257, 'intel_pres', 'Add Fees', 'Added fee: INTEL FEE (₱100) for Semester: 1st Semester, SY: 2024-2025', '2025-04-04 12:41:33'),
(258, 'intel_pres', 'Add Fees', 'Added fee: INTEL FEE (₱100) for Semester: 1st Semester, SY: 2023-2024', '2025-04-04 12:41:54'),
(259, 'intel_pres', 'Add Fees', 'Added fee: INTEL FEE (₱100) for Semester: 2nd Semester, SY: 2023-2024', '2025-04-04 12:42:12'),
(260, 'intel_pres', 'Add Fees', 'Added fee: INTEL FEE (₱100) for Semester: 1st Semester, SY: 2023-2024', '2025-04-04 12:42:34'),
(261, 'intel_pres', 'Add Payment', 'Payment of ₱100 added for Member: Phil Sebastian Cainong (ID: 2023-10982), Semester: 1st Semester, SY: 2024-2025', '2025-04-04 12:43:49'),
(262, 'intel_pres', 'Delete Fee', 'Deleted fee for Semester: 1st Semester, SY: 2024-2025', '2025-04-04 12:43:49'),
(263, 'intel_pres', 'Add Payment', 'Payment of ₱100 added for Member: Phil Sebastian Cainong (ID: 2023-10982), Semester: 2nd Semester, SY: 2024-2025', '2025-04-04 12:43:49'),
(264, 'intel_pres', 'Delete Fee', 'Deleted fee for Semester: 2nd Semester, SY: 2024-2025', '2025-04-04 12:43:49'),
(265, 'intel_pres', 'Update Member', 'Updated member: Marilyn Asebto (ID: 2024-16754)', '2025-04-04 12:45:03'),
(266, 'intel_pres', 'Update Fees', 'Updated fees for Marilyn Asebto: ₱0, Semesters: 1, School Years: 1', '2025-04-04 12:45:03'),
(267, 'intel_pres', 'Update Member', 'Updated member: Marilyn Asebto (ID: 2024-16754)', '2025-04-04 12:45:27'),
(268, 'intel_pres', 'Update Fees', 'Updated fees for Marilyn Asebto: ₱0, Semesters: 1, School Years: 1', '2025-04-04 12:45:27'),
(269, 'intel_treasurer', 'Login', 'User logged in successfully', '2025-04-04 12:49:11'),
(270, 'intel_pres', 'Login', 'User logged in successfully', '2025-04-04 12:50:14'),
(271, 'intel_pres', 'Add Fees', 'Added fee: INTEL FEE (₱100) for Semester: 1st Semester, SY: 2024-2025', '2025-04-04 12:50:34'),
(272, 'intel_pres', 'Add Fees', 'Added fee: INTEL FEE (₱100) for Semester: 1st Semester, SY: 2024-2025', '2025-04-04 12:51:30'),
(273, 'intel_pres', 'Add Fees', 'Added fee: INTEL FEE (₱100) for Semester: 2nd Semester, SY: 2024-2025', '2025-04-04 12:51:46'),
(274, 'intel_pres', 'Add Fees', 'Added fee: INTEL FEE (₱100) for Semester: 1st Semester, SY: 2023-2024', '2025-04-04 12:51:56'),
(275, 'intel_pres', 'Add Fees', 'Added fee: INTEL FEE (₱100) for Semester: 2nd Semester, SY: 2023-2024', '2025-04-04 12:52:04'),
(276, 'intel_treasurer', 'Login', 'User logged in successfully', '2025-04-04 12:52:30'),
(277, 'intel_pres', 'Login', 'User logged in successfully', '2025-04-04 12:52:56'),
(278, 'intel_pres', 'Login', 'User logged in successfully', '2025-04-04 12:59:08'),
(279, 'intel_pres', 'Add Member', 'Added member: Jonah May Busante (ID: 2024-19243)', '2025-04-04 13:57:22'),
(280, 'intel_pres', 'Add Member', 'Added member: Ana Theresa Baldon (ID: 2023-54789)', '2025-04-04 13:58:07'),
(281, 'intel_pres', 'Add Fees', 'Added fee: INTEL FEE (₱100) for Semester: 1st Semester, SY: 2024-2025', '2025-04-04 14:01:40'),
(282, 'intel_pres', 'Add Fees', 'Added fee: INTEL FEE (₱100) for Semester: 2nd Semester, SY: 2024-2025', '2025-04-04 14:01:47'),
(283, 'intel_pres', 'Add Fees', 'Added fee: INTEL FEE (₱100) for Semester: 2nd Semester, SY: 2023-2024', '2025-04-04 14:01:58'),
(284, 'intel_pres', 'Add Fees', 'Added fee: INTEL FEE (₱100) for Semester: 2nd Semester, SY: 2023-2024', '2025-04-04 14:02:05'),
(285, 'intel_pres', 'Add Fees', 'Added fee: INTEL FEE (₱100) for Semester: 2nd Semester, SY: 2023-2024', '2025-04-04 14:02:24'),
(286, 'intel_pres', 'Add Fees', 'Added fee: INTEL FEE (₱100) for Semester: 1st Semester, SY: 2023-2024', '2025-04-04 14:02:47'),
(287, 'intel_pres', 'Add Fees', 'Added fee: INTEL FEE (₱100) for Semester: 1st Semester, SY: 2022-2023', '2025-04-05 00:29:40'),
(288, 'intel_pres', 'Add Fees', 'Added fee: INTEL FEE (₱100) for Semester: 2nd Semester, SY: 2022-2023', '2025-04-05 00:30:11');

-- --------------------------------------------------------

--
-- Table structure for table `fees`
--

CREATE TABLE `fees` (
  `member_id` varchar(25) NOT NULL,
  `fee_amount` smallint(6) NOT NULL,
  `fee_type` varchar(50) NOT NULL,
  `semester` varchar(50) NOT NULL,
  `school_year` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `fees`
--

INSERT INTO `fees` (`member_id`, `fee_amount`, `fee_type`, `semester`, `school_year`) VALUES
('2021-09843', 100, 'INTEL FEE', '1st Semester', '2024-2025'),
('2023-04321', 100, 'INTEL FEE', '1st Semester', '2024-2025'),
('2023-11780', 100, 'INTEL FEE', '1st Semester', '2024-2025'),
('2023-12578', 100, 'INTEL FEE', '1st Semester', '2024-2025'),
('2024-09234', 100, 'INTEL FEE', '1st Semester', '2024-2025'),
('2024-10742', 100, 'INTEL FEE', '1st Semester', '2024-2025'),
('2021-09843', 100, 'INTEL FEE', '2nd Semester', '2024-2025'),
('2023-04321', 100, 'INTEL FEE', '2nd Semester', '2024-2025'),
('2023-11780', 100, 'INTEL FEE', '2nd Semester', '2024-2025'),
('2023-12578', 100, 'INTEL FEE', '2nd Semester', '2024-2025'),
('2024-09234', 100, 'INTEL FEE', '2nd Semester', '2024-2025'),
('2024-10742', 100, 'INTEL FEE', '2nd Semester', '2024-2025'),
('2021-09843', 100, 'INTEL FEE', '1st Semester', '2023-2024'),
('2023-04321', 100, 'INTEL FEE', '1st Semester', '2023-2024'),
('2023-10982', 100, 'INTEL FEE', '1st Semester', '2023-2024'),
('2023-11780', 100, 'INTEL FEE', '1st Semester', '2023-2024'),
('2023-12578', 100, 'INTEL FEE', '1st Semester', '2023-2024'),
('2024-09234', 100, 'INTEL FEE', '1st Semester', '2023-2024'),
('2024-10742', 100, 'INTEL FEE', '1st Semester', '2023-2024'),
('2021-09843', 100, 'INTEL FEE', '2nd Semester', '2023-2024'),
('2023-04321', 100, 'INTEL FEE', '2nd Semester', '2023-2024'),
('2023-10982', 100, 'INTEL FEE', '2nd Semester', '2023-2024'),
('2023-11780', 100, 'INTEL FEE', '2nd Semester', '2023-2024'),
('2023-12578', 100, 'INTEL FEE', '2nd Semester', '2023-2024'),
('2024-09234', 100, 'INTEL FEE', '2nd Semester', '2023-2024'),
('2024-10742', 100, 'INTEL FEE', '2nd Semester', '2023-2024'),
('2023-10982', 100, 'INTEL FEE', '1st Semester', '2024-2025'),
('2024-16754', 100, 'INTEL FEE', '1st Semester', '2024-2025'),
('2023-10982', 100, 'INTEL FEE', '2nd Semester', '2024-2025'),
('2024-16754', 100, 'INTEL FEE', '2nd Semester', '2024-2025'),
('2024-16754', 100, 'INTEL FEE', '1st Semester', '2023-2024'),
('2024-16754', 100, 'INTEL FEE', '2nd Semester', '2023-2024'),
('2023-54789', 100, 'INTEL FEE', '1st Semester', '2024-2025'),
('2023-62721', 100, 'INTEL FEE', '1st Semester', '2024-2025'),
('2024-19243', 100, 'INTEL FEE', '1st Semester', '2024-2025'),
('2023-54789', 100, 'INTEL FEE', '2nd Semester', '2024-2025'),
('2023-62721', 100, 'INTEL FEE', '2nd Semester', '2024-2025'),
('2024-19243', 100, 'INTEL FEE', '2nd Semester', '2024-2025'),
('2023-54789', 100, 'INTEL FEE', '2nd Semester', '2023-2024'),
('2023-62721', 100, 'INTEL FEE', '2nd Semester', '2023-2024'),
('2024-19243', 100, 'INTEL FEE', '2nd Semester', '2023-2024'),
('2023-54789', 100, 'INTEL FEE', '1st Semester', '2023-2024'),
('2023-62721', 100, 'INTEL FEE', '1st Semester', '2023-2024'),
('2024-19243', 100, 'INTEL FEE', '1st Semester', '2023-2024'),
('2021-09843', 100, 'INTEL FEE', '1st Semester', '2022-2023'),
('2023-04321', 100, 'INTEL FEE', '1st Semester', '2022-2023'),
('2023-10982', 100, 'INTEL FEE', '1st Semester', '2022-2023'),
('2023-11780', 100, 'INTEL FEE', '1st Semester', '2022-2023'),
('2023-12578', 100, 'INTEL FEE', '1st Semester', '2022-2023'),
('2023-54789', 100, 'INTEL FEE', '1st Semester', '2022-2023'),
('2023-62721', 100, 'INTEL FEE', '1st Semester', '2022-2023'),
('2024-09234', 100, 'INTEL FEE', '1st Semester', '2022-2023'),
('2024-10742', 100, 'INTEL FEE', '1st Semester', '2022-2023'),
('2024-16754', 100, 'INTEL FEE', '1st Semester', '2022-2023'),
('2024-19243', 100, 'INTEL FEE', '1st Semester', '2022-2023'),
('2021-09843', 100, 'INTEL FEE', '2nd Semester', '2022-2023'),
('2023-04321', 100, 'INTEL FEE', '2nd Semester', '2022-2023'),
('2023-10982', 100, 'INTEL FEE', '2nd Semester', '2022-2023'),
('2023-11780', 100, 'INTEL FEE', '2nd Semester', '2022-2023'),
('2023-12578', 100, 'INTEL FEE', '2nd Semester', '2022-2023'),
('2023-54789', 100, 'INTEL FEE', '2nd Semester', '2022-2023'),
('2023-62721', 100, 'INTEL FEE', '2nd Semester', '2022-2023'),
('2024-09234', 100, 'INTEL FEE', '2nd Semester', '2022-2023'),
('2024-10742', 100, 'INTEL FEE', '2nd Semester', '2022-2023'),
('2024-16754', 100, 'INTEL FEE', '2nd Semester', '2022-2023'),
('2024-19243', 100, 'INTEL FEE', '2nd Semester', '2022-2023');

-- --------------------------------------------------------

--
-- Table structure for table `members`
--

CREATE TABLE `members` (
  `member_id` varchar(25) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `middle_name` varchar(30) DEFAULT NULL,
  `contact_num` varchar(15) NOT NULL,
  `email` varchar(60) NOT NULL,
  `status` enum('Active','Inactive') NOT NULL,
  `membership_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `members`
--

INSERT INTO `members` (`member_id`, `last_name`, `first_name`, `middle_name`, `contact_num`, `email`, `status`, `membership_date`) VALUES
('2021-09843', 'Palagar', 'Marianita', 'Cainong', '9457281938', 'marianita@gmail.com', 'Inactive', '2025-04-04 09:57:57'),
('2023-04321', 'Hersan', 'Zhen Mae', '', '0912457689', 'zhenmae.hersan@evsu.edu.ph', 'Inactive', '2025-04-04 09:57:57'),
('2023-10982', 'Cainong', 'Phil Sebastian', '', '09662985421', 'philsebastian.cainong@evsu.edu.ph', 'Active', '2025-04-04 09:57:57'),
('2023-11780', 'Narbonita', 'Leonice', 'Poblete', '09123456789', 'leonice.narbonita@evsu.edu.ph', 'Active', '2025-04-04 09:57:57'),
('2023-12578', 'Gariando', 'Quency Athena', 'Cainong', '9768902341', 'quency@gmail.com', 'Active', '2025-04-04 09:57:57'),
('2023-54789', 'Baldon', 'Ana Theresa', '', '09335627183', 'anatheresa.baldon@evsu.edu.ph', 'Active', '2025-04-04 13:58:07'),
('2023-62721', 'Lazarte', 'David', '', '09654367128', 'david.lazarte@evsu.ph', 'Active', '2025-04-04 13:42:53'),
('2024-09234', 'Lopez', 'Sean Oliver', '', '09542739182', 'seanoliver.lopez@evsu.edu.ph', 'Active', '2025-04-04 09:57:57'),
('2024-10742', 'Lopez', 'John Michael', 'Arias', '9830913481', 'jmlopez@gmail.com', 'Active', '2025-04-04 09:57:57'),
('2024-16754', 'Asebto', 'Marilyn', '', '09754267381', 'marilyn.asebto@evsu.edu.ph', 'Active', '2025-04-04 09:57:57'),
('2024-19243', 'Busante', 'Jonah May', 'Nalnalucab', '09452317865', 'jonahmay.busante@evsu.edu.ph', 'Active', '2025-04-04 13:57:22');

-- --------------------------------------------------------

--
-- Table structure for table `officers`
--

CREATE TABLE `officers` (
  `officer_id` varchar(50) NOT NULL,
  `member_id` varchar(25) NOT NULL,
  `role_id` varchar(30) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `officers`
--

INSERT INTO `officers` (`officer_id`, `member_id`, `role_id`, `username`, `password`) VALUES
('intel_pres', '2023-04321', 'intel_president', 'intel_pres', '$2y$10$rJsG/00hLtRhRkTPZhvja.gdIbWzGXMG/WVM1g6KIuoh2.AJQqbhK'),
('intel_secretary', '2023-11780', 'intel_secretary', 'intel_sec', '$2y$10$a0a7J4G7HID8sb1EBnaxTO7QxQg7AIrEbomYXadZaZwlFFUzM4fiS'),
('intel_treasurer', '2023-11780', 'intel_treasurer', 'intel_treas', '$2y$10$rvI6miAlmjrTaeaO63EYL.a6Tvu0cHKpfbFT2HTHjhvPO0HlvIsF6'),
('intel_vpres', '2023-10982', 'intel_vpresident', 'intel_vpres', '$2y$10$HsbgjHS5PP7/6dEFT5OjQeOHsSO4umKVMa5xTi2XdHVi7kLP9PiVq');

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `payment_id` int(11) NOT NULL,
  `member_id` varchar(25) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `payment_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`payment_id`, `member_id`, `amount`, `payment_date`) VALUES
(16, '2023-10982', 100.00, '2025-04-04 06:17:20'),
(17, '2023-10982', 100.00, '2025-04-04 16:00:52'),
(18, '2024-09234', 100.00, '2025-04-04 16:02:36'),
(19, '2024-09234', 100.00, '2025-04-04 16:03:23'),
(20, '2023-10982', 100.00, '2025-04-04 16:07:15'),
(21, '2023-04321', 100.00, '2025-04-04 17:25:59'),
(22, '2023-10982', 100.00, '2025-04-04 17:30:51'),
(23, '2023-12578', 100.00, '2025-04-04 17:36:35'),
(24, '2023-11780', 100.00, '2025-04-04 20:22:46'),
(25, '2023-11780', 100.00, '2025-04-04 20:22:46'),
(26, '2023-10982', 100.00, '2025-04-04 20:43:49'),
(27, '2023-10982', 100.00, '2025-04-04 20:43:49');

-- --------------------------------------------------------

--
-- Table structure for table `role`
--

CREATE TABLE `role` (
  `role_id` varchar(30) NOT NULL,
  `role_name` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `role`
--

INSERT INTO `role` (`role_id`, `role_name`) VALUES
('intel_1styr_representative', '1st year Representative'),
('intel_2ndyr_representative', '2nd year Representative'),
('intel_3rdyr_representative', '3rd year Representative'),
('intel_4thyr_representative', '4th year Representative'),
('intel_auditor', 'Auditor'),
('intel_pio', 'Public Information Officer'),
('intel_president', 'President'),
('intel_secretary', 'Secretary'),
('intel_treasurer', 'Treasurer'),
('intel_vpresident', 'Vice President');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD PRIMARY KEY (`log_id`),
  ADD KEY `officer_id` (`officer_id`);

--
-- Indexes for table `fees`
--
ALTER TABLE `fees`
  ADD KEY `member_id` (`member_id`);

--
-- Indexes for table `members`
--
ALTER TABLE `members`
  ADD PRIMARY KEY (`member_id`);

--
-- Indexes for table `officers`
--
ALTER TABLE `officers`
  ADD PRIMARY KEY (`officer_id`),
  ADD KEY `role_id` (`role_id`),
  ADD KEY `officers_ibfk_1` (`member_id`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`payment_id`),
  ADD KEY `payments_ibfk_1` (`member_id`);

--
-- Indexes for table `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`role_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `activity_logs`
--
ALTER TABLE `activity_logs`
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=289;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `payment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `activity_logs`
--
ALTER TABLE `activity_logs`
  ADD CONSTRAINT `officer_fk` FOREIGN KEY (`officer_id`) REFERENCES `officers` (`officer_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `officer_id` FOREIGN KEY (`officer_id`) REFERENCES `officers` (`officer_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `fees`
--
ALTER TABLE `fees`
  ADD CONSTRAINT `member_id` FOREIGN KEY (`member_id`) REFERENCES `members` (`member_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `officers`
--
ALTER TABLE `officers`
  ADD CONSTRAINT `officers_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `members` (`member_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `officers_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `role` (`role_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `members` (`member_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
