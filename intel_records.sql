-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 11, 2025 at 10:01 AM
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
(288, 'intel_pres', 'Add Fees', 'Added fee: INTEL FEE (₱100) for Semester: 2nd Semester, SY: 2022-2023', '2025-04-05 00:30:11'),
(289, 'intel_pres', 'Import Member', 'Imported member: Tricia Edloy (ID: 2025-65423)', '2025-04-05 05:43:41'),
(290, 'intel_pres', 'Import Member', 'Imported member: Kent Coricor (ID: 2025-09457)', '2025-04-05 05:43:41'),
(291, 'intel_pres', 'Import Member', 'Imported member: Andreia Beros (ID: 2025-77643)', '2025-04-05 05:43:41'),
(292, 'intel_pres', 'Add Fees', 'Added fee: INTEL FEE (₱100) for Semester: 1st Semester, SY: 2024-2025', '2025-04-05 05:44:53'),
(293, 'intel_pres', 'Add Fees', 'Added fee: INTEL FEE (₱100) for Semester: 2nd Semester, SY: 2024-2025', '2025-04-05 05:45:07'),
(294, 'intel_vpres', 'Login', 'User logged in successfully', '2025-04-05 05:45:53'),
(295, 'intel_treasurer', 'Login', 'User logged in successfully', '2025-04-05 05:54:40'),
(296, 'intel_treasurer', 'Add Payment', 'Payment of ₱100 added for Member: Ana Theresa Baldon (ID: 2023-54789), Semester: 1st Semester, SY: 2023-2024', '2025-04-05 05:56:21'),
(297, 'intel_treasurer', 'Delete Fee', 'Deleted fee for Semester: 1st Semester, SY: 2023-2024', '2025-04-05 05:56:21'),
(298, 'intel_treasurer', 'Add Payment', 'Payment of ₱100 added for Member: Ana Theresa Baldon (ID: 2023-54789), Semester: 2nd Semester, SY: 2023-2024', '2025-04-05 05:56:21'),
(299, 'intel_treasurer', 'Delete Fee', 'Deleted fee for Semester: 2nd Semester, SY: 2023-2024', '2025-04-05 05:56:21'),
(300, 'intel_pres', 'Login', 'User logged in successfully', '2025-04-05 06:04:13'),
(301, 'intel_pres', 'Login', 'User logged in successfully', '2025-04-05 09:51:05'),
(302, 'intel_pres', 'Login', 'User logged in successfully', '2025-04-05 10:04:10'),
(303, 'intel_pres', 'Login', 'User logged in successfully', '2025-04-05 19:21:19'),
(304, 'intel_vpres', 'Login', 'User logged in successfully', '2025-04-05 19:25:19'),
(305, 'intel_pres', 'Login', 'User logged in successfully', '2025-04-05 19:27:26'),
(306, 'intel_vpres', 'Login', 'User logged in successfully', '2025-04-05 19:29:59'),
(307, 'intel_pres', 'Login', 'User logged in successfully', '2025-04-05 19:33:41'),
(308, 'intel_pres', 'Add Payment', 'Payment of ₱100 added for Member: Phil Sebastian Cainong (ID: 2023-10982), Semester: 1st Semester, SY: 2024-2025', '2025-04-06 09:14:15'),
(309, 'intel_pres', 'Delete Fee', 'Deleted fee for Semester: 1st Semester, SY: 2024-2025', '2025-04-06 09:14:15'),
(310, 'intel_pres', 'Add Payment', 'Payment of ₱100 added for Member: Phil Sebastian Cainong (ID: 2023-10982), Semester: 2nd Semester, SY: 2024-2025', '2025-04-06 09:16:36'),
(311, 'intel_pres', 'Delete Fee', 'Deleted fee for Member: Phil Sebastian Cainong (ID: 2023-10982), Semester: 2nd Semester, SY: 2024-2025', '2025-04-06 09:16:36'),
(312, 'intel_pres', 'Login', 'User logged in successfully', '2025-04-06 12:30:55'),
(313, 'intel_pres', 'Add Fees', 'Added fee: INTEL FEE (₱100) for Semester: 1st Semester, SY: 2024-2025', '2025-04-06 13:00:50'),
(314, 'intel_pres', 'Add Fees', 'Added fee: INTEL FEE (₱100) for Semester: 1st Semester, SY: 2024-2025', '2025-04-06 13:01:08'),
(315, 'intel_pres', 'Add Payment', 'Payment of ₱100 added for Member: Phil Sebastian Cainong (ID: 2023-10982), Semester: 1st Semester, SY: 2024-2025', '2025-04-06 13:03:20'),
(316, 'intel_pres', 'Delete Fee', 'Deleted fee for Member: Phil Sebastian Cainong (ID: 2023-10982), Semester: 1st Semester, SY: 2024-2025', '2025-04-06 13:03:20'),
(317, 'intel_pres', 'Update Member', 'Updated member: Zhen Mae Hersan (ID: 2023-04321)', '2025-04-06 16:24:00'),
(318, 'intel_pres', 'Update Fees', 'Updated fees for Zhen Mae Hersan: ₱0, Semesters: 1, School Years: 1', '2025-04-06 16:24:00'),
(319, 'intel_pres', 'Update Member', 'Updated member: Marianita Palagar (ID: 2021-09843)', '2025-04-06 16:24:20'),
(320, 'intel_pres', 'Update Fees', 'Updated fees for Marianita Palagar: ₱0, Semesters: 1, School Years: 1', '2025-04-06 16:24:20'),
(321, 'intel_pres', 'Update Member', 'Updated member: Marilyn Asebto (ID: 2024-16754)', '2025-04-06 16:38:29'),
(322, 'intel_pres', 'Update Fees', 'Updated infos for Marilyn Asebto: Last Name: Asebto, First Name: Marilyn, , 09754267381, marilyn.asebto@evsu.edu.ph, Inactive, 2024-16754', '2025-04-06 16:38:29'),
(323, 'intel_pres', 'Update Member', 'Updated member: Marilyn Asebto (ID: 2024-16754)', '2025-04-06 16:39:10'),
(324, 'intel_vpres', 'Login', 'User logged in successfully', '2025-04-06 16:54:17'),
(325, 'intel_treasurer', 'Login', 'User logged in successfully', '2025-04-06 16:55:21'),
(326, 'intel_pres', 'Login', 'User logged in successfully', '2025-04-06 16:59:29'),
(327, 'intel_pres', 'Update Member', 'Updated member: Marilyn Asebto (ID: 2024-16754)', '2025-04-06 17:14:22'),
(328, 'intel_pres', 'Delete Member', 'Deleted member: Marilyn Asebto (ID: 2024-16754)', '2025-04-06 17:24:37'),
(329, 'intel_pres', 'Update Member', 'Updated member: Ana Theresa Baldon (ID: 2023-54789)', '2025-04-06 17:24:43'),
(330, 'intel_pres', 'Update Member', 'Updated member: Ana Theresa Baldon (ID: 2023-54789)', '2025-04-06 17:24:55'),
(331, 'intel_pres', 'Update Member', 'Updated member: Ana Theresa Baldon (ID: 2023-54789)', '2025-04-06 17:32:59'),
(332, 'intel_pres', 'Update Member', 'Updated member: Ana Theresa Baldon (ID: 2023-54789)', '2025-04-06 17:33:09'),
(333, 'intel_pres', 'Update Member', 'Updated member: Ana Theresa Baldon (ID: 2023-54789)', '2025-04-06 17:37:07'),
(334, 'intel_pres', 'Update Member', 'Updated member: Ana Theresa Baldon (ID: 2023-54789)', '2025-04-06 17:37:16'),
(335, 'intel_pres', 'Import Member', 'Imported member: Marilyn Asebto (ID: 2023-55472)', '2025-04-06 17:53:44'),
(336, 'intel_pres', 'Delete Member', 'Deleted member: Marilyn Asebto (ID: 2023-55472)', '2025-04-06 17:55:50'),
(337, 'intel_pres', 'Import Member', 'Imported member: Marilyn Asebto (ID: 2023-55472)', '2025-04-06 17:56:00'),
(338, 'intel_pres', 'Delete Member', 'Deleted member: Marilyn Asebto (ID: 2023-55472)', '2025-04-06 18:01:50'),
(339, 'intel_pres', 'Import Member', 'Imported member: Marilyn Asebto (ID: 2023-55472)', '2025-04-06 18:01:59'),
(340, 'intel_pres', 'Add Fees', 'Added fee: INTEL FEE (₱100) for Semester: 1st Semester, SY: 2023-2024', '2025-04-06 18:02:29'),
(341, 'intel_pres', 'Add Fees', 'Added fee: INTEL FEE (₱100) for Semester: 2nd Semester, SY: 2023-2024', '2025-04-06 18:02:40'),
(342, 'intel_pres', 'Add Fees', 'Added fee: INTEL FEE (₱100) for Semester: 2nd Semester, SY: 2023-2024', '2025-04-06 18:03:12'),
(343, 'intel_pres', 'Add Fees', 'Added fee: INTEL FEE (₱100) for Semester: 1st Semester, SY: 2024-2025', '2025-04-06 18:03:27'),
(344, 'intel_pres', 'Add Fees', 'Added fee: INTEL FEE (₱100) for Semester: 2nd Semester, SY: 2024-2025', '2025-04-06 18:03:40'),
(345, 'intel_pres', 'Add Payment', 'Payment of ₱100 added for Member: Phil Sebastian Cainong (ID: 2023-10982), Semester: 1st Semester, SY: 2024-2025', '2025-04-06 18:18:31'),
(346, 'intel_pres', 'Delete Fee', 'Deleted fee for Member: Phil Sebastian Cainong (ID: 2023-10982), Semester: 1st Semester, SY: 2024-2025', '2025-04-06 18:18:31'),
(347, 'intel_pres', 'Delete Member', 'Deleted member: Ana Theresa Baldon (ID: 2023-54789)', '2025-04-06 18:29:12'),
(348, 'intel_pres', 'Add Payment', 'Payment of ₱100 added for Member: Phil Sebastian Cainong (ID: 2023-10982), Semester: 2nd Semester, SY: 2024-2025', '2025-04-06 18:33:11'),
(349, 'intel_pres', 'Delete Fee', 'Deleted fee for Member: Phil Sebastian Cainong (ID: 2023-10982), Semester: 2nd Semester, SY: 2024-2025', '2025-04-06 18:33:11'),
(350, 'intel_pres', 'Add Payment', 'Payment of ₱100 added for Member: Phil Sebastian Cainong (ID: 2023-10982), Semester: 1st Semester, SY: 2023-2024', '2025-04-06 18:35:17'),
(351, 'intel_pres', 'Delete Fee', 'Deleted fee for Member: Phil Sebastian Cainong (ID: 2023-10982), Semester: 1st Semester, SY: 2023-2024', '2025-04-06 18:35:17'),
(352, 'intel_pres', 'Add Payment', 'Payment of ₱100 added for Member: Zhen Mae Hersan (ID: 2023-04321), Semester: 1st Semester, SY: 2023-2024', '2025-04-06 18:49:36'),
(353, 'intel_pres', 'Delete Fee', 'Deleted fee for Member: Zhen Mae Hersan (ID: 2023-04321), Semester: 1st Semester, SY: 2023-2024', '2025-04-06 18:49:36'),
(354, 'intel_pres', 'Add Payment', 'Payment of ₱100 added for Member: Zhen Mae Hersan (ID: 2023-04321), Semester: 1st Semester, SY: 2024-2025', '2025-04-06 18:50:14'),
(355, 'intel_pres', 'Delete Fee', 'Deleted fee for Member: Zhen Mae Hersan (ID: 2023-04321), Semester: 1st Semester, SY: 2024-2025', '2025-04-06 18:50:14'),
(356, 'intel_pres', 'Add Payment', 'Payment of ₱100 added for Member: Zhen Mae Hersan (ID: 2023-04321), Semester: 2nd Semester, SY: 2024-2025', '2025-04-06 18:51:28'),
(357, 'intel_pres', 'Delete Fee', 'Deleted fee for Member: Zhen Mae Hersan (ID: 2023-04321), Semester: 2nd Semester, SY: 2024-2025', '2025-04-06 18:51:28'),
(358, 'intel_pres', 'Add Payment', 'Payment of ₱100 added for Member: Zhen Mae Hersan (ID: 2023-04321), Semester: 1st Semester, SY: 2022-2023', '2025-04-06 18:54:59'),
(359, 'intel_pres', 'Delete Fee', 'Deleted fee for Member: Zhen Mae Hersan (ID: 2023-04321), Semester: 1st Semester, SY: 2022-2023', '2025-04-06 18:54:59'),
(360, 'intel_pres', 'Add Payment', 'Payment of ₱100 added for Member: Zhen Mae Hersan (ID: 2023-04321), Semester: 2nd Semester, SY: 2022-2023', '2025-04-06 18:55:50'),
(361, 'intel_pres', 'Delete Fee', 'Deleted fee for Member: Zhen Mae Hersan (ID: 2023-04321), Semester: 2nd Semester, SY: 2022-2023', '2025-04-06 18:55:50'),
(362, 'intel_pres', 'Add Payment', 'Payment of ₱100 added for Member: Leonice Narbonita (ID: 2023-11780), Semester: 1st Semester, SY: 2023-2024', '2025-04-06 19:04:09'),
(363, 'intel_pres', 'Delete Fee', 'Deleted fee for Member: Leonice Narbonita (ID: 2023-11780), Semester: 1st Semester, SY: 2023-2024', '2025-04-06 19:04:09'),
(364, 'intel_pres', 'Add Payment', 'Payment of ₱100 added for Member: Leonice Narbonita (ID: 2023-11780), Semester: 1st Semester, SY: 2024-2025', '2025-04-06 19:23:32'),
(365, 'intel_pres', 'Delete Fee', 'Deleted fee for Member: Leonice Narbonita (ID: 2023-11780), Semester: 1st Semester, SY: 2024-2025', '2025-04-06 19:23:32'),
(366, 'intel_pres', 'Add Payment', 'Payment of ₱100 added for Member: Leonice Narbonita (ID: 2023-11780), Semester: 2nd Semester, SY: 2023-2024', '2025-04-06 19:23:32'),
(367, 'intel_pres', 'Delete Fee', 'Deleted fee for Member: Leonice Narbonita (ID: 2023-11780), Semester: 2nd Semester, SY: 2023-2024', '2025-04-06 19:23:32'),
(368, 'intel_pres', 'Update Member', 'Updated member: Marilyn Asebto (ID: 2023-55472)', '2025-04-06 19:32:14'),
(369, 'intel_pres', 'Add Fees', 'Added fee: INTEL FEE (₱100) for Semester: 1st Semester, SY: 2024-2025', '2025-04-06 19:32:31'),
(370, 'intel_pres', 'Add Payment', 'Payment of ₱100 added for Member: Jonah May Busante (ID: 2024-19243), Semester: 1st Semester, SY: 2024-2025', '2025-04-06 20:12:32'),
(371, 'intel_pres', 'Delete Fee', 'Deleted fee for Member: Jonah May Busante (ID: 2024-19243), Semester: 1st Semester, SY: 2024-2025', '2025-04-06 20:12:32'),
(372, 'intel_pres', 'Add Payment', 'Payment of ₱100 added for Member: Jonah May Busante (ID: 2024-19243), Semester: 1st Semester, SY: 2023-2024', '2025-04-06 20:12:32'),
(373, 'intel_pres', 'Delete Fee', 'Deleted fee for Member: Jonah May Busante (ID: 2024-19243), Semester: 1st Semester, SY: 2023-2024', '2025-04-06 20:12:32'),
(374, 'intel_pres', 'Add Payment', 'Payment of ₱100 added for Member: Jonah May Busante (ID: 2024-19243), Semester: 2nd Semester, SY: 2022-2023', '2025-04-06 20:12:32'),
(375, 'intel_pres', 'Delete Fee', 'Deleted fee for Member: Jonah May Busante (ID: 2024-19243), Semester: 2nd Semester, SY: 2022-2023', '2025-04-06 20:12:32'),
(376, 'intel_pres', 'Add Payment', 'Payment of ₱100 added for Member: Sean Oliver Lopez (ID: 2024-09234), Semester: 1st Semester, SY: 2024-2025', '2025-04-06 20:15:26'),
(377, 'intel_pres', 'Delete Fee', 'Deleted fee for Member: Sean Oliver Lopez (ID: 2024-09234), Semester: 1st Semester, SY: 2024-2025', '2025-04-06 20:15:26'),
(378, 'intel_pres', 'Add Payment', 'Payment of ₱100 added for Member: Sean Oliver Lopez (ID: 2024-09234), Semester: 1st Semester, SY: 2023-2024', '2025-04-06 20:15:26'),
(379, 'intel_pres', 'Delete Fee', 'Deleted fee for Member: Sean Oliver Lopez (ID: 2024-09234), Semester: 1st Semester, SY: 2023-2024', '2025-04-06 20:15:26'),
(380, 'intel_pres', 'Add Payment', 'Payment of ₱100 added for Member: Sean Oliver Lopez (ID: 2024-09234), Semester: 1st Semester, SY: 2022-2023', '2025-04-06 20:15:26'),
(381, 'intel_pres', 'Delete Fee', 'Deleted fee for Member: Sean Oliver Lopez (ID: 2024-09234), Semester: 1st Semester, SY: 2022-2023', '2025-04-06 20:15:26'),
(382, 'intel_pres', 'Add Member', 'Added member: Ana Ivy Cainong (ID: 2021-03756)', '2025-04-06 21:48:18'),
(383, 'intel_pres', 'Add Fees', 'Added fee: INTEL FEE (₱100) for Semester: 2nd Semester, SY: 2024-2025', '2025-04-06 21:48:42'),
(384, 'intel_pres', 'Add Payment', 'Payment of ₱100 added for Member: Tricia Edloy (ID: 2025-65423), Semester: 2nd Semester, SY: 2024-2025', '2025-04-06 21:49:20'),
(385, 'intel_pres', 'Delete Fee', 'Deleted fee for Member: Tricia Edloy (ID: 2025-65423), Semester: 2nd Semester, SY: 2024-2025', '2025-04-06 21:49:20'),
(386, 'intel_vpres', 'Login', 'User logged in successfully', '2025-04-06 22:44:55'),
(387, 'intel_vpres', 'Login', 'User logged in successfully', '2025-04-06 22:47:05'),
(388, 'intel_vpres', 'Login', 'User logged in successfully', '2025-04-06 22:51:32'),
(389, 'intel_pres', 'Login', 'User logged in successfully', '2025-04-06 22:51:59'),
(390, 'intel_pres', 'Add Payment', 'Payment of ₱100 added for Member: Leonice Narbonita (ID: 2023-11780), Semester: 2nd Semester, SY: 2022-2023', '2025-04-06 23:43:02'),
(391, 'intel_pres', 'Delete Fee', 'Deleted fee for Member: Leonice Narbonita (ID: 2023-11780), Semester: 2nd Semester, SY: 2022-2023', '2025-04-06 23:43:02'),
(392, 'intel_pres', 'Add Payment', 'Payment of ₱100 added for Member: Leonice Narbonita (ID: 2023-11780), Semester: 2nd Semester, SY: 2024-2025', '2025-04-06 23:51:09'),
(393, 'intel_pres', 'Delete Fee', 'Deleted fee for Member: Leonice Narbonita (ID: 2023-11780), Semester: 2nd Semester, SY: 2024-2025', '2025-04-06 23:51:09'),
(394, 'intel_pres', 'Add Payment', 'Payment of ₱100 added for Member: Phil Sebastian Cainong (ID: 2023-10982), Semester: 2nd Semester, SY: 2022-2023', '2025-04-07 00:06:06'),
(395, 'intel_pres', 'Delete Fee', 'Deleted fee for Member: Phil Sebastian Cainong (ID: 2023-10982), Semester: 2nd Semester, SY: 2022-2023', '2025-04-07 00:06:06'),
(396, 'intel_pres', 'Add Payment', 'Payment of ₱100 added for Member: Phil Sebastian Cainong (ID: 2023-10982), Semester: 1st Semester, SY: 2024-2025', '2025-04-07 00:06:06'),
(397, 'intel_pres', 'Delete Fee', 'Deleted fee for Member: Phil Sebastian Cainong (ID: 2023-10982), Semester: 1st Semester, SY: 2024-2025', '2025-04-07 00:06:06'),
(398, 'intel_pres', 'Update Member', 'Updated member: Ana Ivy Cainong (ID: 2021-03756)', '2025-04-07 00:08:06'),
(399, 'intel_pres', 'Add Payment', 'Payment of ₱100 added for Member: Quency Athena Gariando (ID: 2023-12578), Semester: 1st Semester, SY: 2024-2025', '2025-04-07 00:09:15'),
(400, 'intel_pres', 'Delete Fee', 'Deleted fee for Member: Quency Athena Gariando (ID: 2023-12578), Semester: 1st Semester, SY: 2024-2025', '2025-04-07 00:09:15'),
(401, 'intel_pres', 'Add Payment', 'Payment of ₱100 added for Member: Quency Athena Gariando (ID: 2023-12578), Semester: 2nd Semester, SY: 2023-2024', '2025-04-07 00:09:15'),
(402, 'intel_pres', 'Delete Fee', 'Deleted fee for Member: Quency Athena Gariando (ID: 2023-12578), Semester: 2nd Semester, SY: 2023-2024', '2025-04-07 00:09:15'),
(403, 'intel_treasurer', 'Login', 'User logged in successfully', '2025-04-07 00:22:52'),
(404, 'intel_treasurer', 'Add Payment', 'Payment of ₱100 added for Member: Leonice Narbonita (ID: 2023-11780), Semester: 1st Semester, SY: 2022-2023', '2025-04-07 00:23:11'),
(405, 'intel_treasurer', 'Delete Fee', 'Deleted fee for Member: Leonice Narbonita (ID: 2023-11780), Semester: 1st Semester, SY: 2022-2023', '2025-04-07 00:23:11'),
(406, 'intel_treasurer', 'Add Fees', 'Added fee: INTEL FEE (₱100) for Semester: 1st Semester, SY: 2024-2025', '2025-04-07 00:27:54'),
(407, 'intel_treasurer', 'Add Fees', 'Added fee: INTEL FEE (₱100) for Semester: 1st Semester, SY: 2022-2023', '2025-04-07 00:28:32'),
(408, 'intel_treasurer', 'Add Fees', 'Added fee: INTEL FEE (₱100) for Semester: 1st Semester, SY: 2023-2024 to 0 members', '2025-04-07 00:30:04'),
(409, 'intel_treasurer', 'Delete Member', 'Deleted member: Marilyn Asebto (ID: 2023-55472)', '2025-04-07 00:35:24'),
(410, 'intel_treasurer', 'Delete Member', 'Deleted member: Ana Ivy Cainong (ID: 2021-03756)', '2025-04-07 00:35:45'),
(411, 'intel_treasurer', 'Add Fees', 'Added fee: INTEL FEE (₱100) for Semester: 1st Semester, SY: 2024-2025 to 0 members', '2025-04-07 00:36:27'),
(412, 'intel_treasurer', 'Add Fees', 'Added fee: INTEL FEE (₱100) for Semester: 2nd Semester, SY: 2023-2024 to 0 members', '2025-04-07 00:36:41'),
(413, 'intel_treasurer', 'Add Payment', 'Payment of ₱100 added for Member: Andreia Beros (ID: 2025-77643), Semester: 1st Semester, SY: 2024-2025', '2025-04-07 00:37:41'),
(414, 'intel_treasurer', 'Delete Fee', 'Deleted fee for Member: Andreia Beros (ID: 2025-77643), Semester: 1st Semester, SY: 2024-2025', '2025-04-07 00:37:41'),
(415, 'intel_treasurer', 'Add Payment', 'Payment of ₱100 added for Member: Andreia Beros (ID: 2025-77643), Semester: 2nd Semester, SY: 2024-2025', '2025-04-07 00:37:41'),
(416, 'intel_treasurer', 'Delete Fee', 'Deleted fee for Member: Andreia Beros (ID: 2025-77643), Semester: 2nd Semester, SY: 2024-2025', '2025-04-07 00:37:41'),
(417, 'intel_treasurer', 'Add Fees', 'Added fee: INTEL FEE (₱100) for Semester: 1st Semester, SY: 2024-2025 to 0 members', '2025-04-07 00:38:03'),
(418, 'intel_treasurer', 'Add Fees', 'Added fee: INTEL FEE (₱100) for Semester: 2nd Semester, SY: 2024-2025 to 0 members', '2025-04-07 00:45:50'),
(419, 'intel_treasurer', 'Add Fees', 'Added fee: INTEL FEE (₱100) for Semester: 1st Semester, SY: 2024-2025 to 0 members', '2025-04-07 00:46:27'),
(420, 'intel_treasurer', 'Add Fees', 'Added fee: INTEL FEE (₱100) for Semester: 1st Semester, SY: 2023-2024 to 0 members', '2025-04-07 00:46:52'),
(421, 'intel_treasurer', 'Add Fees', 'Added fee: INTEL FEE (₱100) for Semester: 1st Semester, SY: 2025-2026 to 0 members', '2025-04-07 00:48:11'),
(422, 'intel_treasurer', 'Add Fees', 'Added fee: INTEL FEE (₱100) for Semester: 1st Semester, SY: 2024-2025', '2025-04-07 00:49:34'),
(423, 'intel_treasurer', 'Add Fees', 'Added fee: INTEL FEE (₱100) for Semester: 1st Semester, SY: 2024-2025', '2025-04-07 00:49:45'),
(424, 'intel_treasurer', 'Add Fees', 'Added fee: INTEL FEE (₱100) for Semester: 1st Semester, SY: 2025-2026', '2025-04-07 00:53:32'),
(425, 'intel_pres', 'Login', 'User logged in successfully', '2025-04-07 00:54:46'),
(426, 'intel_pres', 'Add Fees', 'Added fee: INTEL FEE (₱100) for Semester: 1st Semester, SY: 2025-2026', '2025-04-07 00:56:14'),
(427, 'intel_pres', 'Add Fees', 'Added fee: INTEL FEE (₱100) for Semester: 2nd Semester, SY: 2025-2026', '2025-04-07 00:56:43'),
(428, 'intel_pres', 'Add Member', 'Added member: Juan Dela Cruz (ID: 2023-01456)', '2025-04-07 02:04:33'),
(429, 'intel_pres', 'Delete Member', 'Deleted member: Juan Dela Cruz (ID: 2023-01456)', '2025-04-07 02:11:42'),
(430, 'intel_pres', 'Add Member', 'Added member: Juan Dela Cruz (ID: 2023-11432)', '2025-04-07 02:12:24'),
(431, 'intel_pres', 'Delete Member', 'Deleted member: Juan Dela Cruz (ID: 2023-11432)', '2025-04-07 02:22:38'),
(432, 'intel_pres', 'Delete Member', 'Deleted member: Kent Coricor (ID: 2025-09457)', '2025-04-07 02:40:49'),
(433, 'intel_pres', 'Delete Member', 'Deleted member: Tricia Edloy (ID: 2025-65423)', '2025-04-07 02:40:53'),
(434, 'intel_pres', 'Delete Member', 'Deleted member: Andreia Beros (ID: 2025-77643)', '2025-04-07 02:40:57'),
(435, 'intel_pres', 'Add Member', 'Added member: Juan Dela Cruz (ID: 2023-00000)', '2025-04-07 02:50:50'),
(436, 'intel_pres', 'Delete Member', 'Deleted member: Juan Dela Cruz (ID: 2023-00000)', '2025-04-07 03:04:48'),
(437, 'intel_pres', 'Add Member', 'Added member: Juan Dela Cruz (ID: 2023-00000)', '2025-04-07 03:06:16'),
(438, 'intel_pres', 'Add Fee', 'Added fee: INTEL FEE (100) for First Semester 2024-2025', '2025-04-07 03:06:16'),
(439, 'intel_pres', 'Import Member', 'Imported member: Tricia Edloy (ID: 2025-65423)', '2025-04-07 03:17:41'),
(440, 'intel_pres', 'Import Member', 'Imported member: Kent Coricor (ID: 2025-09457)', '2025-04-07 03:17:41'),
(441, 'intel_pres', 'Import Member', 'Imported member: Andreia Beros (ID: 2025-77643)', '2025-04-07 03:17:41'),
(442, 'intel_pres', 'Import Member', 'Imported member: Marilyn Asebto (ID: 2023-55472)', '2025-04-07 03:17:41'),
(443, 'intel_pres', 'Add Member', 'Added member: Mae Dela Cruz (ID: 2023-00001)', '2025-04-07 03:23:09'),
(444, 'intel_pres', 'Delete Member', 'Deleted member: Mae Dela Cruz (ID: 2023-00001)', '2025-04-07 03:25:46'),
(445, 'intel_pres', 'Add Member', 'Added member: Mae Dela Cruz (ID: 2023-00001)', '2025-04-07 03:29:48'),
(446, 'intel_pres', 'Delete Member', 'Deleted member: Mae Dela Cruz (ID: 2023-00001)', '2025-04-07 03:33:52'),
(447, 'intel_pres', 'Add Member', 'Added member: Mae Dela Cruz (ID: 2023-00001)', '2025-04-07 03:34:27'),
(448, 'intel_pres', 'Delete Member', 'Deleted member: Mae Dela Cruz (ID: 2023-00001)', '2025-04-07 03:38:16'),
(449, 'intel_pres', 'Add Member', 'Added member: Mae Dela Cruz (ID: 2023-00001)', '2025-04-07 03:45:09'),
(450, 'intel_pres', 'Update Member', 'Updated member: Marilyn Asebto (ID: 2023-55472)', '2025-04-07 03:48:22'),
(451, 'intel_pres', 'Import Member', 'Imported member: Adrian Lim (ID: 2023-11112)', '2025-04-07 04:01:11'),
(452, 'intel_pres', 'Delete Member', 'Deleted member: Adrian Lim (ID: 2023-11112)', '2025-04-07 04:08:02'),
(453, 'intel_pres', 'Import Member', 'Imported member: Adrian Lim (ID: 2023-11112)', '2025-04-07 04:08:10'),
(454, 'intel_pres', 'Delete Member', 'Deleted member: Adrian Lim (ID: 2023-11112)', '2025-04-07 04:11:45'),
(455, 'intel_pres', 'Delete Member', 'Deleted member: Marilyn Asebto (ID: 2023-55472)', '2025-04-07 04:11:48'),
(456, 'intel_pres', 'Import Member', 'Imported member: Marilyn Asebto (ID: 2023-55472)', '2025-04-07 04:12:04'),
(457, 'intel_pres', 'Import Member', 'Imported member: Adrian Lim (ID: 2023-11112)', '2025-04-07 04:12:04'),
(458, 'intel_pres', 'Login', 'User logged in successfully', '2025-04-07 05:12:53'),
(459, 'intel_pres', 'Add Payment', 'Payment of ₱100 added for Member: Leonice Narbonita (ID: 2023-11780), Semester: 1st Semester, SY: 2022-2023', '2025-04-07 05:13:31'),
(460, 'intel_pres', 'Delete Fee', 'Deleted fee for Member: Leonice Narbonita (ID: 2023-11780), Semester: 1st Semester, SY: 2022-2023', '2025-04-07 05:13:31'),
(461, 'intel_pres', 'Add Payment', 'Payment of ₱100 added for Member: Leonice Narbonita (ID: 2023-11780), Semester: 1st Semester, SY: 2024-2025', '2025-04-07 05:13:31'),
(462, 'intel_pres', 'Delete Fee', 'Deleted fee for Member: Leonice Narbonita (ID: 2023-11780), Semester: 1st Semester, SY: 2024-2025', '2025-04-07 05:13:31'),
(463, 'intel_pres', 'Add Fees', 'Added fee: INTEL FEE (₱100) for Semester: 2nd Semester, SY: 2025-2026', '2025-04-07 05:15:07'),
(464, 'intel_pres', 'Login', 'User logged in successfully', '2025-04-07 05:30:38'),
(465, 'intel_pres', 'Delete Member', 'Deleted member: Kent Coricor (ID: 2025-09457)', '2025-04-07 05:30:54'),
(466, 'intel_pres', 'Login', 'User logged in successfully', '2025-04-07 06:36:27'),
(467, 'intel_pres', 'Add Payment', 'Payment of ₱100 added for Member: David Lazarte (ID: 2023-62721), Semester: 2nd Semester, SY: 2022-2023', '2025-04-07 06:37:22'),
(468, 'intel_pres', 'Delete Fee', 'Deleted fee for Member: David Lazarte (ID: 2023-62721), Semester: 2nd Semester, SY: 2022-2023', '2025-04-07 06:37:22'),
(469, 'intel_pres', 'Update Member', 'Updated member: Marilyn Asebto (ID: 2023-55472)', '2025-04-07 06:41:30'),
(470, 'intel_pres', 'Update Member', 'Updated member: Marilyn Asebto (ID: 2023-55472)', '2025-04-07 06:52:02'),
(471, 'intel_pres', 'Add Payment', 'Payment of ₱100 added for Member: Quency Athena Gariando (ID: 2023-12578), Semester: 1st Semester, SY: 2023-2024', '2025-04-07 07:00:28'),
(472, 'intel_pres', 'Delete Fee', 'Deleted fee for Member: Quency Athena Gariando (ID: 2023-12578), Semester: 1st Semester, SY: 2023-2024', '2025-04-07 07:00:28'),
(473, 'intel_pres', 'Add Payment', 'Payment of ₱100 added for Member: Quency Athena Gariando (ID: 2023-12578), Semester: 2nd Semester, SY: 2022-2023', '2025-04-07 07:00:28'),
(474, 'intel_pres', 'Delete Fee', 'Deleted fee for Member: Quency Athena Gariando (ID: 2023-12578), Semester: 2nd Semester, SY: 2022-2023', '2025-04-07 07:00:28'),
(475, 'intel_pres', 'Update Member', 'Updated member: Marilyn Asebto (ID: 2023-55472)', '2025-04-07 07:02:24'),
(476, 'intel_vpres', 'Login', 'User logged in successfully', '2025-04-07 07:02:52'),
(477, 'intel_pres', 'Login', 'User logged in successfully', '2025-04-10 05:33:29'),
(478, 'intel_pres', 'Update Member', 'Updated member: Marilyn Asebto (ID: 2023-55472)', '2025-04-10 06:37:06'),
(479, 'intel_pres', 'Update Member', 'Updated member: Zhen Mae Hersan (ID: 2023-04321)', '2025-04-10 06:37:14'),
(480, 'intel_pres', 'Update Member', 'Updated member: Leonice Narbonita (ID: 2023-11780)', '2025-04-10 06:37:24'),
(481, 'intel_pres', 'Update Member', 'Updated member: Marianita Palagar (ID: 2021-09843)', '2025-04-10 06:37:35'),
(482, 'intel_pres', 'Add Fees', 'Added fee: INTEL FEE (₱100) for Semester: 1st Semester, SY: 2022-2023', '2025-04-10 06:37:50'),
(483, 'intel_pres', 'Add Fees', 'Added fee: INTEL FEE (₱100) for Semester: 2nd Semester, SY: 2022-2023', '2025-04-10 06:38:10'),
(484, 'intel_pres', 'Add Fees', 'Added fee: INTEL FEE (₱100) for Semester: 1st Semester, SY: 2023', '2025-04-10 06:38:30'),
(485, 'intel_pres', 'Add Fees', 'Added fee: INTEL FEE (₱100) for Semester: 1st Semester, SY: 2023-2024', '2025-04-10 06:39:11'),
(486, 'intel_pres', 'Status Update', 'Member Sean Oliver Lopez (ID: 2024-09234) marked as inactive due to having 4 unpaid fees', '2025-04-10 06:43:56'),
(487, 'intel_pres', 'Status Update', 'Member John Michael Lopez (ID: 2024-10742) marked as inactive due to having 4 unpaid fees', '2025-04-10 06:43:56'),
(488, 'intel_pres', 'Status Update', 'Member Tricia Edloy (ID: 2025-65423) marked as inactive due to having 4 unpaid fees', '2025-04-10 06:43:56'),
(489, 'intel_pres', 'Status Update', 'Member Andreia Beros (ID: 2025-77643) marked as inactive due to having 4 unpaid fees', '2025-04-10 06:43:56'),
(490, 'intel_pres', 'Batch Status Update', 'Updated 4 members to inactive status due to having 3 or more unpaid fees', '2025-04-10 06:43:56'),
(491, 'intel_pres', 'Add Payment', 'Payment of ₱100 added for Member: Adrian Lim (ID: 2023-11112), Semester: 1st Semester, SY: 2022-2023', '2025-04-10 06:49:12'),
(492, 'intel_pres', 'Update Fee Status', 'Updated fee status to &#039;Paid&#039; for Member: Adrian Lim (ID: 2023-11112), Semester: 1st Semester, SY: 2022-2023', '2025-04-10 06:49:12'),
(493, 'intel_pres', 'Add Payment', 'Payment of ₱100 added for Member: Andreia Beros (ID: 2025-77643), Semester: 1st Semester, SY: 2022-2023', '2025-04-10 06:51:11'),
(494, 'intel_pres', 'Update Fee Status', 'Updated fee status to &#039;Paid&#039; for Member: Andreia Beros (ID: 2025-77643), Semester: 1st Semester, SY: 2022-2023', '2025-04-10 06:51:11'),
(495, 'intel_pres', 'Status Update', 'Member Adrian Lim (ID: 2023-11112) marked as active due to having less than 3 unpaid fees', '2025-04-10 07:10:37'),
(496, 'intel_pres', 'Status Update', 'Member Andreia Beros (ID: 2025-77643) marked as active due to having less than 3 unpaid fees', '2025-04-10 07:10:37'),
(497, 'intel_pres', 'Batch Status Update', 'Updated 2 members to active status due to having less than 3 unpaid fees', '2025-04-10 07:10:37'),
(498, 'intel_pres', 'Add Payment', 'Payment of ₱100 added for Member: Mae Dela Cruz (ID: 2023-00001), Semester: 1st Semester, SY: 2022-2023', '2025-04-10 07:21:31'),
(499, 'intel_pres', 'Update Fee Status', 'Updated fee status to &#039;Paid&#039; for Member: Mae Dela Cruz (ID: 2023-00001), Semester: 1st Semester, SY: 2022-2023', '2025-04-10 07:21:31'),
(500, 'intel_pres', 'Status Update', 'Member Mae Dela Cruz (ID: 2023-00001) marked as active due to having less than 3 unpaid fees', '2025-04-10 07:21:36'),
(501, 'intel_pres', 'Batch Status Update', 'Updated 1 members to active status due to having less than 3 unpaid fees', '2025-04-10 07:21:36'),
(502, 'intel_pres', 'Add Payment', 'Payment of ₱100 added for Member: Marilyn Asebto (ID: 2023-55472), Semester: 2nd Semester, SY: 2022-2023', '2025-04-10 07:25:28'),
(503, 'intel_pres', 'Update Fee Status', 'Updated fee status to &#039;Paid&#039; for Member: Marilyn Asebto (ID: 2023-55472), Semester: 2nd Semester, SY: 2022-2023', '2025-04-10 07:25:28'),
(504, 'intel_pres', 'Status Update', 'Member Marilyn Asebto (ID: 2023-55472) marked as active due to having less than 3 unpaid fees', '2025-04-10 07:25:37'),
(505, 'intel_pres', 'Batch Status Update', 'Updated 1 members to active status due to having less than 3 unpaid fees', '2025-04-10 07:25:37'),
(506, 'intel_pres', 'Add Fees', 'Added fee: INTEL FEE (₱100) for Semester: 2nd Semester, SY: 2023-2024', '2025-04-10 08:03:11'),
(507, 'intel_pres', 'Status Update', 'Member Marilyn Asebto (ID: 2023-55472) marked as inactive due to having 3 unpaid fees', '2025-04-10 08:03:11'),
(508, 'intel_pres', 'Batch Status Update', 'Updated 1 members to inactive status due to having 3 or more unpaid fees', '2025-04-10 08:03:11'),
(509, 'intel_pres', 'Add Payment', 'Payment of ₱100 added for Member: Tricia Edloy (ID: 2025-65423), Semester: 1st Semester, SY: 2022-2023', '2025-04-10 08:24:30'),
(510, 'intel_pres', 'Update Fee Status', 'Updated fee status to &#039;Paid&#039; for Member: Tricia Edloy (ID: 2025-65423), Semester: 1st Semester, SY: 2022-2023', '2025-04-10 08:24:30'),
(511, 'intel_pres', 'Add Payment', 'Payment of ₱100 added for Member: Tricia Edloy (ID: 2025-65423), Semester: 2nd Semester, SY: 2022-2023', '2025-04-10 08:24:30'),
(512, 'intel_pres', 'Update Fee Status', 'Updated fee status to &#039;Paid&#039; for Member: Tricia Edloy (ID: 2025-65423), Semester: 2nd Semester, SY: 2022-2023', '2025-04-10 08:24:30'),
(513, 'intel_pres', 'Status Update', 'Member Tricia Edloy (ID: 2025-65423) marked as active due to having less than 3 unpaid fees', '2025-04-10 08:24:37'),
(514, 'intel_pres', 'Batch Status Update', 'Updated 1 members to active status due to having less than 3 unpaid fees', '2025-04-10 08:24:37'),
(515, 'intel_pres', 'Add Payment', 'Payment of ₱100 added for Member: Juan Dela Cruz (ID: 2023-00000), Semester: 1st Semester, SY: 2022-2023', '2025-04-10 08:26:58'),
(516, 'intel_pres', 'Update Fee Status', 'Updated fee status to &lt;span class=&#039;text-success&#039;&gt;Paid&lt;span&gt; for Member: Juan Dela Cruz (ID: 2023-00000), Semester: 1st Semester, SY: 2022-2023', '2025-04-10 08:26:58'),
(517, 'intel_pres', 'Add Payment', 'Payment of ₱100 added for Member: Juan Dela Cruz (ID: 2023-00000), Semester: 2nd Semester, SY: 2023-2024', '2025-04-10 08:28:41'),
(518, 'intel_pres', 'Update Fee Status', 'Updated fee status to &lt;span class=&#039;text-success&#039;&gt;Paid&lt;/span&gt; for Member: Juan Dela Cruz (ID: 2023-00000), Semester: 2nd Semester, SY: 2023-2024', '2025-04-10 08:28:41'),
(519, 'intel_pres', 'Status Update', 'Member Juan Dela Cruz (ID: 2023-00000) marked as active due to having less than 3 unpaid fees', '2025-04-10 08:28:43'),
(520, 'intel_pres', 'Batch Status Update', 'Updated 1 members to active status due to having less than 3 unpaid fees', '2025-04-10 08:28:43'),
(521, 'intel_pres', 'Add Payment', 'Payment of ₱100 added for Member: Quency Athena Gariando (ID: 2023-12578), Semester: 1st Semester, SY: 2023-2024', '2025-04-10 08:29:54'),
(522, 'intel_pres', 'Update Fee Status', 'Updated fee status to &lt;span class=&#039;text-success&#039;&gt;Paid&lt;/span&gt; for Member: Quency Athena Gariando (ID: 2023-12578), Semester: 1st Semester, SY: 2023-2024', '2025-04-10 08:29:54'),
(523, 'intel_pres', 'Add Payment', 'Payment of ₱100 added for Member: Quency Athena Gariando (ID: 2023-12578), Semester: 2nd Semester, SY: 2023-2024', '2025-04-10 08:29:54'),
(524, 'intel_pres', 'Update Fee Status', 'Updated fee status to &lt;span class=&#039;text-success&#039;&gt;Paid&lt;/span&gt; for Member: Quency Athena Gariando (ID: 2023-12578), Semester: 2nd Semester, SY: 2023-2024', '2025-04-10 08:29:54'),
(525, 'intel_pres', 'Status Update', 'Member Quency Athena Gariando (ID: 2023-12578) marked as active due to having less than 3 unpaid fees', '2025-04-10 08:29:56'),
(526, 'intel_pres', 'Batch Status Update', 'Updated 1 members to active status due to having less than 3 unpaid fees', '2025-04-10 08:29:56'),
(527, 'intel_pres', 'Delete Member', 'Deleted member: Mae Dela Cruz (ID: 2023-00001)', '2025-04-10 09:41:26'),
(528, 'intel_pres', 'Delete Member', 'Deleted member: Kent Coricor (ID: 2025-09457)', '2025-04-10 10:07:56'),
(529, 'intel_pres', 'Delete Member', 'Deleted member: Tricia Edloy (ID: 2025-65423)', '2025-04-10 10:13:01'),
(530, 'intel_pres', 'Import Member', 'Imported member: Tricia Edloy (ID: 2025-65423)', '2025-04-10 10:14:50'),
(531, 'intel_pres', 'Import Member', 'Imported member: Kent Coricor (ID: 2025-09457)', '2025-04-10 10:14:50'),
(532, 'intel_pres', 'Import Member', 'Imported member: Adrian Lim (ID: 2023-11112)', '2025-04-10 10:14:50'),
(533, 'intel_pres', 'Delete Member', 'Deleted member: Kent Coricor (ID: 2025-09457)', '2025-04-10 10:29:49'),
(534, 'intel_pres', 'Member Deletion', 'Deleted member: Andreia Beros (ID: 2025-77643)', '2025-04-10 10:37:39'),
(535, 'intel_pres', '', 'Deleted member: Adrian Lim', '2025-04-10 10:41:13'),
(536, 'intel_pres', 'Import Member', 'Imported member: Tricia Edloy (ID: 2025-65423)', '2025-04-10 10:43:42'),
(537, 'intel_pres', 'Import Member', 'Imported member: Kent Coricor (ID: 2025-09457)', '2025-04-10 10:43:42'),
(538, 'intel_pres', 'Import Member', 'Imported member: Andreia Beros (ID: 2025-77643)', '2025-04-10 10:43:42'),
(539, 'intel_pres', 'Import Member', 'Imported member: Adrian Lim (ID: 2023-11112)', '2025-04-10 10:43:42'),
(540, 'intel_pres', '', 'Deleted member: Andreia Beros (ID: 2025-77643)', '2025-04-10 10:43:50'),
(541, 'intel_pres', 'Member Deletion', 'Member Tricia Edloy (ID: 2025-65423) (Deleted by officer: intel_pres)', '2025-04-10 10:51:32'),
(542, 'intel_pres', 'Member Restoration', 'Member Tricia Edloy (ID: 2025-65423) was restored from deletion', '2025-04-10 10:59:40'),
(543, 'intel_pres', 'Member Deletion', 'Member Kent Coricor (ID: 2025-09457) (Deleted by officer: intel_pres)', '2025-04-10 10:59:55'),
(544, 'intel_pres', 'Member Restoration', 'Member Kent Coricor (ID: 2025-09457) was restored from deletion', '2025-04-10 11:00:01'),
(545, 'intel_pres', 'Member Deletion', 'Member Adrian Lim (ID: 2023-11112) (Deleted by officer: intel_pres)', '2025-04-10 11:00:49'),
(546, 'intel_pres', 'Member Deletion', 'Member Kent Coricor (ID: 2025-09457) (Deleted by officer: intel_pres)', '2025-04-10 11:05:12'),
(547, 'intel_pres', 'Member Deletion', 'Member Tricia Edloy (ID: 2025-65423) (Deleted by officer: intel_pres)', '2025-04-10 11:05:16'),
(548, 'intel_pres', 'Import Member', 'Imported member: Tricia Edloy (ID: 2025-65423)', '2025-04-10 11:05:23'),
(549, 'intel_pres', 'Import Member', 'Imported member: Kent Coricor (ID: 2025-09457)', '2025-04-10 11:05:23'),
(550, 'intel_pres', 'Import Member', 'Imported member: Andreia Beros (ID: 2025-77643)', '2025-04-10 11:05:23'),
(551, 'intel_pres', 'Import Member', 'Imported member: Adrian Lim (ID: 2023-11112)', '2025-04-10 11:05:23'),
(552, 'intel_pres', 'Member Deletion', 'Member Kent Coricor (ID: 2025-09457) (Deleted by officer: intel_pres)', '2025-04-10 11:05:30'),
(553, 'intel_pres', 'Member Restoration', 'Member Kent Coricor (ID: 2025-09457) was restored from deletion', '2025-04-10 11:05:36'),
(554, 'intel_pres', 'Member Deletion', 'Member Tricia Edloy (ID: 2025-65423) (Deleted by officer: intel_pres)', '2025-04-10 11:05:49'),
(555, 'intel_pres', 'Member Deletion', 'Member Adrian Lim (ID: 2023-11112) (Deleted by officer: intel_pres)', '2025-04-10 11:08:50'),
(556, 'intel_pres', 'Member Restoration', 'Member Adrian Lim (ID: 2023-11112) was restored from deletion', '2025-04-10 11:09:15'),
(557, 'intel_pres', 'Member Deletion', 'Member Adrian Lim (ID: 2023-11112) (Deleted by officer: intel_pres)', '2025-04-10 11:11:09'),
(558, 'intel_pres', 'Import Member', 'Imported member: Tricia Edloy (ID: 2025-65423)', '2025-04-10 11:11:18'),
(559, 'intel_pres', 'Import Member', 'Imported member: Adrian Lim (ID: 2023-11112)', '2025-04-10 11:11:18'),
(560, 'intel_pres', 'Member Deletion', 'Member Tricia Edloy (ID: 2025-65423) (Deleted by officer: intel_pres)', '2025-04-10 11:11:28'),
(561, 'intel_pres', 'Member Restoration', 'Member Tricia Edloy (ID: 2025-65423) was restored from deletion', '2025-04-10 11:12:03');
INSERT INTO `activity_logs` (`log_id`, `officer_id`, `action`, `description`, `date`) VALUES
(562, 'intel_pres', 'Member Deletion', 'Member Tricia Edloy (ID: 2025-65423) (Deleted by officer: intel_pres)', '2025-04-10 11:14:41'),
(563, 'intel_pres', 'Import Member', 'Imported member: Tricia Edloy (ID: 2025-65423)', '2025-04-10 11:14:49'),
(564, 'intel_pres', 'Member Deletion', 'Member Tricia Edloy (ID: 2025-65423) (Deleted by officer: intel_pres)', '2025-04-10 11:14:56'),
(565, 'intel_pres', 'Member Restoration', 'Member Tricia Edloy (ID: 2025-65423) was restored from deletion', '2025-04-10 11:15:58'),
(566, 'intel_pres', 'Member Deletion', 'Member Adrian Lim (ID: 2023-11112) (Deleted by officer: intel_pres)', '2025-04-10 11:16:38'),
(567, 'intel_pres', 'Member Deletion', 'Member Tricia Edloy (ID: 2025-65423) (Deleted by officer: intel_pres)', '2025-04-10 11:18:21'),
(568, 'intel_pres', 'Member Restoration', 'Member Tricia Edloy (ID: 2025-65423) was restored from deletion', '2025-04-10 11:18:26'),
(569, 'intel_pres', 'Member Deletion', 'Member Tricia Edloy (ID: 2025-65423) (Deleted by officer: intel_pres)', '2025-04-10 11:18:40'),
(570, 'intel_pres', 'Member Restoration', 'Member Tricia Edloy (ID: 2025-65423) was restored from deletion', '2025-04-10 11:19:00'),
(571, 'intel_pres', 'Member Deletion', 'Member Kent Coricor (ID: 2025-09457) (Deleted by officer: intel_pres)', '2025-04-10 11:19:08'),
(572, 'intel_pres', 'Import Member', 'Imported member: Kent Coricor (ID: 2025-09457)', '2025-04-10 11:19:21'),
(573, 'intel_pres', 'Import Member', 'Imported member: Adrian Lim (ID: 2023-11112)', '2025-04-10 11:19:21'),
(574, 'intel_pres', 'Member Deletion', 'Member Andreia Beros (ID: 2025-77643) (Deleted by officer: intel_pres)', '2025-04-10 11:53:42'),
(575, 'intel_pres', 'Member Deletion', 'Member Marilyn Asebto (ID: 2023-55472) (Deleted by officer: intel_pres)', '2025-04-10 11:53:44'),
(576, 'intel_pres', 'Member Deletion', 'Member Tricia Edloy (ID: 2025-65423) (Deleted by officer: intel_pres)', '2025-04-10 11:53:47'),
(577, 'intel_pres', 'Member Deletion', 'Member Kent Coricor (ID: 2025-09457) (Deleted by officer: intel_pres)', '2025-04-10 11:53:50'),
(578, 'intel_pres', 'Member Deletion', 'Member Adrian Lim (ID: 2023-11112) (Deleted by officer: intel_pres)', '2025-04-10 11:53:53'),
(579, 'intel_pres', 'Import Member', 'Imported member: Tricia Edloy (ID: 2025-65423)', '2025-04-10 11:54:00'),
(580, 'intel_pres', 'Import Member', 'Imported member: Kent Coricor (ID: 2025-09457)', '2025-04-10 11:54:00'),
(581, 'intel_pres', 'Import Member', 'Imported member: Andreia Beros (ID: 2025-77643)', '2025-04-10 11:54:00'),
(582, 'intel_pres', 'Import Member', 'Imported member: Marilyn Asebto (ID: 2023-55472)', '2025-04-10 11:54:00'),
(583, 'intel_pres', 'Import Member', 'Imported member: Adrian Lim (ID: 2023-11112)', '2025-04-10 11:54:00'),
(584, 'intel_pres', 'Status Update', 'Member Marilyn Asebto (ID: 2023-55472) marked as active due to having less than 3 unpaid fees', '2025-04-10 11:54:01'),
(585, 'intel_pres', 'Batch Status Update', 'Updated 1 members to active status due to having less than 3 unpaid fees', '2025-04-10 11:54:01'),
(586, 'intel_pres', 'Login', 'User logged in successfully', '2025-04-10 12:49:39'),
(587, 'intel_treasurer', 'Login', 'User logged in successfully', '2025-04-10 13:03:07'),
(588, 'intel_treasurer', 'Add Fees', 'Added fee: INTEL FEE (₱100) for Semester: 1st Semester, SY: 2026', '2025-04-10 13:25:42'),
(589, 'intel_treasurer', 'Member Deletion', 'Member Marilyn Asebto (ID: 2023-55472) (Deleted by officer: intel_treasurer)', '2025-04-10 13:34:31'),
(590, 'intel_treasurer', 'Member Deletion', 'Member Andreia Beros (ID: 2025-77643) (Deleted by officer: intel_treasurer)', '2025-04-10 13:34:34'),
(591, 'intel_treasurer', 'Member Deletion', 'Member Kent Coricor (ID: 2025-09457) (Deleted by officer: intel_treasurer)', '2025-04-10 13:34:36'),
(592, 'intel_treasurer', 'Member Deletion', 'Member Tricia Edloy (ID: 2025-65423) (Deleted by officer: intel_treasurer)', '2025-04-10 13:34:39'),
(593, 'intel_treasurer', 'Import Member', 'Imported member: Tricia Edloy (ID: 2025-65423)', '2025-04-10 13:34:47'),
(594, 'intel_treasurer', 'Import Member', 'Imported member: Kent Coricor (ID: 2025-09457)', '2025-04-10 13:34:47'),
(595, 'intel_treasurer', 'Import Member', 'Imported member: Andreia Beros (ID: 2025-77643)', '2025-04-10 13:34:47'),
(596, 'intel_treasurer', 'Import Member', 'Imported member: Marilyn Asebto (ID: 2023-55472)', '2025-04-10 13:34:47'),
(597, 'intel_treasurer', 'Status Update', 'Member Marilyn Asebto (ID: 2023-55472) marked as active due to having less than 3 unpaid fees', '2025-04-10 13:34:48'),
(598, 'intel_treasurer', 'Batch Status Update', 'Updated 1 members to active status due to having less than 3 unpaid fees', '2025-04-10 13:34:48'),
(599, 'intel_treasurer', 'Member Deletion', 'Member Adrian Lim (ID: 2023-11112) (Deleted by officer: intel_treasurer)', '2025-04-10 13:35:09'),
(600, 'intel_treasurer', 'Import Member', 'Imported member: Adrian Lim (ID: 2023-11112)', '2025-04-10 13:35:20'),
(601, 'intel_treasurer', 'Member Deletion', 'Member Marilyn Asebto (ID: 2023-55472) (Deleted by officer: intel_treasurer)', '2025-04-10 13:39:03'),
(602, 'intel_treasurer', 'Member Deletion', 'Member Andreia Beros (ID: 2025-77643) (Deleted by officer: intel_treasurer)', '2025-04-10 13:39:08'),
(603, 'intel_treasurer', 'Member Deletion', 'Member Kent Coricor (ID: 2025-09457) (Deleted by officer: intel_treasurer)', '2025-04-10 13:39:11'),
(604, 'intel_treasurer', 'Member Deletion', 'Member Tricia Edloy (ID: 2025-65423) (Deleted by officer: intel_treasurer)', '2025-04-10 13:39:14'),
(605, 'intel_treasurer', 'Member Deletion', 'Member Adrian Lim (ID: 2023-11112) (Deleted by officer: intel_treasurer)', '2025-04-10 13:39:18'),
(606, 'intel_treasurer', 'Import Member', 'Imported member: Tricia Edloy (ID: 2025-65423)', '2025-04-10 13:39:25'),
(607, 'intel_treasurer', 'Import Member', 'Imported member: Kent Coricor (ID: 2025-09457)', '2025-04-10 13:39:25'),
(608, 'intel_treasurer', 'Import Member', 'Imported member: Andreia Beros (ID: 2025-77643)', '2025-04-10 13:39:25'),
(609, 'intel_treasurer', 'Import Member', 'Imported member: Marilyn Asebto (ID: 2023-55472)', '2025-04-10 13:39:25'),
(610, 'intel_treasurer', 'Import Member', 'Imported member: Adrian Lim (ID: 2023-11112)', '2025-04-10 13:39:25'),
(611, 'intel_treasurer', 'Status Update', 'Member Marilyn Asebto (ID: 2023-55472) marked as active due to having less than 3 unpaid fees', '2025-04-10 13:39:29'),
(612, 'intel_treasurer', 'Batch Status Update', 'Updated 1 members to active status due to having less than 3 unpaid fees', '2025-04-10 13:39:29');

-- --------------------------------------------------------

--
-- Table structure for table `deleted_members`
--

CREATE TABLE `deleted_members` (
  `deletion_id` int(11) NOT NULL,
  `member_id` varchar(20) NOT NULL,
  `description` text NOT NULL,
  `member_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`member_data`)),
  `deleted_by` varchar(20) NOT NULL,
  `deletion_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `deleted_members`
--

INSERT INTO `deleted_members` (`deletion_id`, `member_id`, `description`, `member_data`, `deleted_by`, `deletion_date`) VALUES
(19, '2023-11112', 'Member Adrian Lim (ID: 2023-11112)', '{\"member_id\":\"2023-11112\",\"last_name\":\"Lim\",\"first_name\":\"Adrian\",\"middle_name\":\"Ty\",\"contact_num\":\"9216579012\",\"email\":\"adrian@gmail.com\",\"status\":\"Active\",\"membership_date\":\"2025-04-10 19:09:15\",\"fees\":[]}', 'intel_pres', '2025-04-10 11:11:09'),
(23, '2023-11112', 'Member Adrian Lim (ID: 2023-11112)', '{\"member_id\":\"2023-11112\",\"last_name\":\"Lim\",\"first_name\":\"Adrian\",\"middle_name\":\"Ty\",\"contact_num\":\"9216579012\",\"email\":\"adrian@gmail.com\",\"status\":\"Active\",\"membership_date\":\"2025-04-10 19:11:18\",\"fees\":[{\"fee_type\":\"0\",\"fee_amount\":100,\"semester\":\"1st semester\",\"school_year\":\"2025-2026\",\"status\":\"Unpaid\"}]}', 'intel_pres', '2025-04-10 11:16:38'),
(26, '2025-09457', 'Member Kent Coricor (ID: 2025-09457)', '{\"member_id\":\"2025-09457\",\"last_name\":\"Coricor\",\"first_name\":\"Kent\",\"middle_name\":\"Roberts\",\"contact_num\":\"9446889121\",\"email\":\"coricor.robert@evsu.edu.ph\",\"status\":\"Active\",\"membership_date\":\"2025-04-10 19:05:36\",\"fees\":[]}', 'intel_pres', '2025-04-10 11:19:08'),
(27, '2025-77643', 'Member Andreia Beros (ID: 2025-77643)', '{\"member_id\":\"2025-77643\",\"last_name\":\"Beros\",\"first_name\":\"Andreia\",\"middle_name\":\"Cainong\",\"contact_num\":\"9662349082\",\"email\":\"beros.andreia@evsu.edu.ph\",\"status\":\"Active\",\"membership_date\":\"2025-04-10 19:05:23\",\"fees\":[{\"fee_type\":\"0\",\"fee_amount\":100,\"semester\":\"1st semester\",\"school_year\":\"2025-2026\",\"status\":\"Unpaid\"}]}', 'intel_pres', '2025-04-10 11:53:42'),
(28, '2023-55472', 'Member Marilyn Asebto (ID: 2023-55472)', '{\"member_id\":\"2023-55472\",\"last_name\":\"Asebto\",\"first_name\":\"Marilyn\",\"middle_name\":\"Arpon\",\"contact_num\":\"9235678234\",\"email\":\"marilyn@evsu.edu.ph\",\"status\":\"Inactive\",\"membership_date\":\"2025-04-07 12:12:04\",\"fees\":[{\"fee_type\":\"INTEL FEE\",\"fee_amount\":100,\"semester\":\"1st Semester\",\"school_year\":\"2022-2023\",\"status\":\"Unpaid\"},{\"fee_type\":\"INTEL FEE\",\"fee_amount\":100,\"semester\":\"2nd Semester\",\"school_year\":\"2022-2023\",\"status\":\"Paid\"},{\"fee_type\":\"INTEL FEE\",\"fee_amount\":100,\"semester\":\"1st Semester\",\"school_year\":\"2023-2024\",\"status\":\"Unpaid\"},{\"fee_type\":\"INTEL FEE\",\"fee_amount\":100,\"semester\":\"2nd Semester\",\"school_year\":\"2023-2024\",\"status\":\"Unpaid\"}]}', 'intel_pres', '2025-04-10 11:53:44'),
(29, '2025-65423', 'Member Tricia Edloy (ID: 2025-65423)', '{\"member_id\":\"2025-65423\",\"last_name\":\"Edloy\",\"first_name\":\"Tricia\",\"middle_name\":\"\",\"contact_num\":\"9541256970\",\"email\":\"tricia@evsu.edu.ph\",\"status\":\"Active\",\"membership_date\":\"2025-04-10 19:18:59\",\"fees\":[{\"fee_type\":\"INTEL FEE\",\"fee_amount\":100,\"semester\":\"1st semester\",\"school_year\":\"2025-2026\",\"status\":\"Unpaid\"}]}', 'intel_pres', '2025-04-10 11:53:47'),
(30, '2025-09457', 'Member Kent Coricor (ID: 2025-09457)', '{\"member_id\":\"2025-09457\",\"last_name\":\"Coricor\",\"first_name\":\"Kent\",\"middle_name\":\"Roberts\",\"contact_num\":\"9446889121\",\"email\":\"coricor.robert@evsu.edu.ph\",\"status\":\"Active\",\"membership_date\":\"2025-04-10 19:19:21\",\"fees\":[{\"fee_type\":\"0\",\"fee_amount\":100,\"semester\":\"2nd semester\",\"school_year\":\"2025-2026\",\"status\":\"Unpaid\"}]}', 'intel_pres', '2025-04-10 11:53:50'),
(31, '2023-11112', 'Member Adrian Lim (ID: 2023-11112)', '{\"member_id\":\"2023-11112\",\"last_name\":\"Lim\",\"first_name\":\"Adrian\",\"middle_name\":\"Ty\",\"contact_num\":\"9216579012\",\"email\":\"adrian@gmail.com\",\"status\":\"Active\",\"membership_date\":\"2025-04-10 19:19:21\",\"fees\":[{\"fee_type\":\"0\",\"fee_amount\":100,\"semester\":\"1st semester\",\"school_year\":\"2025-2026\",\"status\":\"Unpaid\"}]}', 'intel_pres', '2025-04-10 11:53:53'),
(32, '2023-55472', 'Member Marilyn Asebto (ID: 2023-55472)', '{\"member_id\":\"2023-55472\",\"last_name\":\"Asebto\",\"first_name\":\"Marilyn\",\"middle_name\":\"Arpon\",\"contact_num\":\"9235678234\",\"email\":\"marilyn@evsu.edu.ph\",\"status\":\"Active\",\"membership_date\":\"2025-04-10 19:54:00\",\"fees\":[{\"fee_type\":\"0\",\"fee_amount\":100,\"semester\":\"1st semester\",\"school_year\":\"2025-2026\",\"status\":\"Unpaid\"}]}', 'intel_treasurer', '2025-04-10 13:34:31'),
(33, '2025-77643', 'Member Andreia Beros (ID: 2025-77643)', '{\"member_id\":\"2025-77643\",\"last_name\":\"Beros\",\"first_name\":\"Andreia\",\"middle_name\":\"Cainong\",\"contact_num\":\"9662349082\",\"email\":\"beros.andreia@evsu.edu.ph\",\"status\":\"Active\",\"membership_date\":\"2025-04-10 19:54:00\",\"fees\":[{\"fee_type\":\"0\",\"fee_amount\":100,\"semester\":\"1st semester\",\"school_year\":\"2025-2026\",\"status\":\"Unpaid\"}]}', 'intel_treasurer', '2025-04-10 13:34:34'),
(34, '2025-09457', 'Member Kent Coricor (ID: 2025-09457)', '{\"member_id\":\"2025-09457\",\"last_name\":\"Coricor\",\"first_name\":\"Kent\",\"middle_name\":\"Roberts\",\"contact_num\":\"9446889121\",\"email\":\"coricor.robert@evsu.edu.ph\",\"status\":\"Active\",\"membership_date\":\"2025-04-10 19:54:00\",\"fees\":[{\"fee_type\":\"0\",\"fee_amount\":100,\"semester\":\"2nd semester\",\"school_year\":\"2025-2026\",\"status\":\"Unpaid\"}]}', 'intel_treasurer', '2025-04-10 13:34:36'),
(35, '2025-65423', 'Member Tricia Edloy (ID: 2025-65423)', '{\"member_id\":\"2025-65423\",\"last_name\":\"Edloy\",\"first_name\":\"Tricia\",\"middle_name\":\"\",\"contact_num\":\"9541256970\",\"email\":\"tricia@evsu.edu.ph\",\"status\":\"Active\",\"membership_date\":\"2025-04-10 19:54:00\",\"fees\":[{\"fee_type\":\"0\",\"fee_amount\":100,\"semester\":\"1st semester\",\"school_year\":\"2025-2026\",\"status\":\"Unpaid\"}]}', 'intel_treasurer', '2025-04-10 13:34:39'),
(36, '2023-11112', 'Member Adrian Lim (ID: 2023-11112)', '{\"member_id\":\"2023-11112\",\"last_name\":\"Lim\",\"first_name\":\"Adrian\",\"middle_name\":\"Ty\",\"contact_num\":\"9216579012\",\"email\":\"adrian@gmail.com\",\"status\":\"Active\",\"membership_date\":\"2025-04-10 19:54:00\",\"fees\":[{\"fee_type\":\"0\",\"fee_amount\":100,\"semester\":\"1st semester\",\"school_year\":\"2025-2026\",\"status\":\"Unpaid\"}]}', 'intel_treasurer', '2025-04-10 13:35:09'),
(37, '2023-55472', 'Member Marilyn Asebto (ID: 2023-55472)', '{\"member_id\":\"2023-55472\",\"last_name\":\"Asebto\",\"first_name\":\"Marilyn\",\"middle_name\":\"Arpon\",\"contact_num\":\"9235678234\",\"email\":\"marilyn@evsu.edu.ph\",\"status\":\"Active\",\"membership_date\":\"2025-04-10 21:34:47\",\"fees\":[{\"fee_type\":\"INTEL FEE\",\"fee_amount\":100,\"semester\":\"1st semester\",\"school_year\":\"2025-2026\",\"status\":\"Unpaid\"}]}', 'intel_treasurer', '2025-04-10 13:39:03'),
(38, '2025-77643', 'Member Andreia Beros (ID: 2025-77643)', '{\"member_id\":\"2025-77643\",\"last_name\":\"Beros\",\"first_name\":\"Andreia\",\"middle_name\":\"Cainong\",\"contact_num\":\"9662349082\",\"email\":\"beros.andreia@evsu.edu.ph\",\"status\":\"Active\",\"membership_date\":\"2025-04-10 21:34:47\",\"fees\":[{\"fee_type\":\"INTEL FEE\",\"fee_amount\":100,\"semester\":\"1st semester\",\"school_year\":\"2025-2026\",\"status\":\"Unpaid\"}]}', 'intel_treasurer', '2025-04-10 13:39:08'),
(39, '2025-09457', 'Member Kent Coricor (ID: 2025-09457)', '{\"member_id\":\"2025-09457\",\"last_name\":\"Coricor\",\"first_name\":\"Kent\",\"middle_name\":\"Roberts\",\"contact_num\":\"9446889121\",\"email\":\"coricor.robert@evsu.edu.ph\",\"status\":\"Active\",\"membership_date\":\"2025-04-10 21:34:47\",\"fees\":[{\"fee_type\":\"INTEL FEE\",\"fee_amount\":100,\"semester\":\"2nd semester\",\"school_year\":\"2025-2026\",\"status\":\"Unpaid\"}]}', 'intel_treasurer', '2025-04-10 13:39:11'),
(40, '2025-65423', 'Member Tricia Edloy (ID: 2025-65423)', '{\"member_id\":\"2025-65423\",\"last_name\":\"Edloy\",\"first_name\":\"Tricia\",\"middle_name\":\"\",\"contact_num\":\"9541256970\",\"email\":\"tricia@evsu.edu.ph\",\"status\":\"Active\",\"membership_date\":\"2025-04-10 21:34:47\",\"fees\":[{\"fee_type\":\"INTEL FEE\",\"fee_amount\":100,\"semester\":\"1st semester\",\"school_year\":\"2025-2026\",\"status\":\"Unpaid\"}]}', 'intel_treasurer', '2025-04-10 13:39:14'),
(41, '2023-11112', 'Member Adrian Lim (ID: 2023-11112)', '{\"member_id\":\"2023-11112\",\"last_name\":\"Lim\",\"first_name\":\"Adrian\",\"middle_name\":\"Ty\",\"contact_num\":\"9216579012\",\"email\":\"adrian@gmail.com\",\"status\":\"Active\",\"membership_date\":\"2025-04-10 21:35:20\",\"fees\":[{\"fee_type\":\"INTEL FEE\",\"fee_amount\":100,\"semester\":\"1st semester\",\"school_year\":\"2025-2026\",\"status\":\"Unpaid\"}]}', 'intel_treasurer', '2025-04-10 13:39:18');

-- --------------------------------------------------------

--
-- Table structure for table `fees`
--

CREATE TABLE `fees` (
  `member_id` varchar(25) NOT NULL,
  `fee_amount` smallint(6) NOT NULL,
  `fee_type` varchar(50) NOT NULL,
  `semester` varchar(50) NOT NULL,
  `school_year` varchar(25) NOT NULL,
  `status` enum('Paid','Unpaid') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `fees`
--

INSERT INTO `fees` (`member_id`, `fee_amount`, `fee_type`, `semester`, `school_year`, `status`) VALUES
('2023-62721', 100, 'INTEL FEE', '1st Semester', '2022-2023', 'Unpaid'),
('2024-09234', 100, 'INTEL FEE', '1st Semester', '2022-2023', 'Unpaid'),
('2024-10742', 100, 'INTEL FEE', '1st Semester', '2022-2023', 'Unpaid'),
('2023-62721', 100, 'INTEL FEE', '2nd Semester', '2022-2023', 'Unpaid'),
('2024-09234', 100, 'INTEL FEE', '2nd Semester', '2022-2023', 'Unpaid'),
('2024-10742', 100, 'INTEL FEE', '2nd Semester', '2022-2023', 'Unpaid'),
('2023-62721', 100, 'INTEL FEE', '1st Semester', '2023-2024', 'Unpaid'),
('2024-09234', 100, 'INTEL FEE', '1st Semester', '2023-2024', 'Unpaid'),
('2024-10742', 100, 'INTEL FEE', '1st Semester', '2023-2024', 'Unpaid'),
('2023-62721', 100, 'INTEL FEE', '2nd Semester', '2023-2024', 'Unpaid'),
('2024-09234', 100, 'INTEL FEE', '2nd Semester', '2023-2024', 'Unpaid'),
('2024-10742', 100, 'INTEL FEE', '2nd Semester', '2023-2024', 'Unpaid'),
('2025-65423', 100, 'INTEL FEE', '1st semester', '2025-2026', 'Unpaid'),
('2025-09457', 100, 'INTEL FEE', '2nd semester', '2025-2026', 'Unpaid'),
('2025-77643', 100, 'INTEL FEE', '1st semester', '2025-2026', 'Unpaid'),
('2023-55472', 100, 'INTEL FEE', '1st semester', '2025-2026', 'Unpaid'),
('2023-11112', 100, 'INTEL FEE', '1st semester', '2025-2026', 'Unpaid');

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
('2023-04321', 'Hersan', 'Zhen Mae', '', '0912457689', 'zhenmae.hersan@evsu.edu.ph', 'Active', '2025-04-04 09:57:57'),
('2023-10982', 'Cainong', 'Phil Sebastian', '', '09662985421', 'philsebastian.cainong@evsu.edu.ph', 'Active', '2025-04-04 09:57:57'),
('2023-11112', 'Lim', 'Adrian', 'Ty', '9216579012', 'adrian@gmail.com', 'Active', '2025-04-10 13:39:25'),
('2023-11780', 'Narbonita', 'Leonice', 'Poblete', '09123456789', 'leonice.narbonita@evsu.edu.ph', 'Active', '2025-04-04 09:57:57'),
('2023-55472', 'Asebto', 'Marilyn', 'Arpon', '9235678234', 'marilyn@evsu.edu.ph', 'Active', '2025-04-10 13:39:25'),
('2023-62721', 'Lazarte', 'David', '', '09654367128', 'david.lazarte@evsu.ph', 'Inactive', '2025-04-04 13:42:53'),
('2024-09234', 'Lopez', 'Sean Oliver', '', '09542739182', 'seanoliver.lopez@evsu.edu.ph', 'Inactive', '2025-04-04 09:57:57'),
('2024-10742', 'Lopez', 'John Michael', 'Arias', '9830913481', 'jmlopez@gmail.com', 'Inactive', '2025-04-04 09:57:57'),
('2024-19243', 'Busante', 'Jonah May', 'Nalnalucab', '09452317865', 'jonahmay.busante@evsu.edu.ph', 'Active', '2025-04-04 13:57:22'),
('2025-09457', 'Coricor', 'Kent', 'Roberts', '9446889121', 'coricor.robert@evsu.edu.ph', 'Active', '2025-04-10 13:39:25'),
('2025-65423', 'Edloy', 'Tricia', '', '9541256970', 'tricia@evsu.edu.ph', 'Active', '2025-04-10 13:39:25'),
('2025-77643', 'Beros', 'Andreia', 'Cainong', '9662349082', 'beros.andreia@evsu.edu.ph', 'Active', '2025-04-10 13:39:25');

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
('intel_secretary', '2024-19243', 'intel_secretary', 'intel_sec', '$2y$10$frwqD3EDmq9uTC08IavkO.PtKP1n4.sdXFO5qFCpU3yp0smQN8.26'),
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
  `semester` varchar(50) NOT NULL,
  `school_year` varchar(20) NOT NULL,
  `payment_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`payment_id`, `member_id`, `amount`, `semester`, `school_year`, `payment_date`) VALUES
(33, '2023-10982', 100.00, '1st Semester', '2024-2025', '2025-04-07 02:18:31'),
(34, '2023-10982', 100.00, '2nd Semester', '2024-2025', '2025-04-07 02:33:11'),
(35, '2023-10982', 100.00, '1st Semester', '2023-2024', '2025-04-07 02:35:17'),
(36, '2023-04321', 100.00, '1st Semester', '2023-2024', '2025-04-07 02:49:36'),
(37, '2023-04321', 100.00, '1st Semester', '2024-2025', '2025-04-07 02:50:14'),
(38, '2023-04321', 100.00, '2nd Semester', '2024-2025', '2025-04-07 02:51:28'),
(39, '2023-04321', 100.00, '1st Semester', '2022-2023', '2025-04-07 02:54:59'),
(40, '2023-04321', 100.00, '2nd Semester', '2022-2023', '2025-04-07 02:55:50'),
(41, '2023-11780', 100.00, '1st Semester', '2023-2024', '2025-04-07 03:04:09'),
(42, '2023-11780', 100.00, '1st Semester', '2024-2025', '2025-04-07 03:23:31'),
(43, '2023-11780', 100.00, '2nd Semester', '2023-2024', '2025-04-07 03:23:32'),
(44, '2024-19243', 100.00, '1st Semester', '2024-2025', '2025-04-07 04:12:32'),
(45, '2024-19243', 100.00, '1st Semester', '2023-2024', '2025-04-07 04:12:32'),
(46, '2024-19243', 100.00, '2nd Semester', '2022-2023', '2025-04-07 04:12:32'),
(47, '2024-09234', 100.00, '1st Semester', '2024-2025', '2025-04-07 04:15:26'),
(48, '2024-09234', 100.00, '1st Semester', '2023-2024', '2025-04-07 04:15:26'),
(49, '2024-09234', 100.00, '1st Semester', '2022-2023', '2025-04-07 04:15:26'),
(51, '2023-11780', 100.00, '2nd Semester', '2022-2023', '2025-04-07 07:43:02'),
(52, '2023-11780', 100.00, '2nd Semester', '2024-2025', '2025-04-07 07:51:09'),
(53, '2023-10982', 100.00, '2nd Semester', '2022-2023', '2025-04-07 08:06:06'),
(54, '2023-10982', 100.00, '1st Semester', '2024-2025', '2025-04-07 08:06:06'),
(57, '2023-11780', 100.00, '1st Semester', '2022-2023', '2025-04-07 08:23:11'),
(60, '2023-11780', 100.00, '1st Semester', '2022-2023', '2025-04-07 13:13:31'),
(61, '2023-11780', 100.00, '1st Semester', '2024-2025', '2025-04-07 13:13:31'),
(62, '2023-62721', 100.00, '2nd Semester', '2022-2023', '2025-04-07 14:37:22');

-- --------------------------------------------------------

--
-- Table structure for table `receipts`
--

CREATE TABLE `receipts` (
  `receipt_id` varchar(20) NOT NULL,
  `payment_id` int(11) NOT NULL,
  `member_id` varchar(20) NOT NULL,
  `officer_id` varchar(20) NOT NULL,
  `receipt_date` datetime NOT NULL DEFAULT current_timestamp(),
  `total_amount` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `receipts`
--

INSERT INTO `receipts` (`receipt_id`, `payment_id`, `member_id`, `officer_id`, `receipt_date`, `total_amount`) VALUES
('RCPT67f2df9f816f3', 43, '2023-11780', 'intel_pres', '2025-04-07 04:10:07', 100.00),
('RCPT67f2e03f7282a', 44, '2024-19243', 'intel_pres', '2025-04-07 04:12:47', 100.00),
('RCPT67f2e052bd0cf', 45, '2024-19243', 'intel_pres', '2025-04-07 04:13:06', 100.00),
('RCPT67f2e0f27f638', 47, '2024-09234', 'intel_pres', '2025-04-07 04:15:46', 100.00),
('RCPT67f311aac320a', 51, '2023-11780', 'intel_pres', '2025-04-07 07:43:38', 100.00),
('RCPT67f3165fd977e', 52, '2023-11780', 'intel_pres', '2025-04-07 08:03:43', 100.00),
('RCPT67f35faabe3ff', 53, '2023-10982', 'intel_pres', '2025-04-07 13:16:26', 100.00);

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
-- Indexes for table `deleted_members`
--
ALTER TABLE `deleted_members`
  ADD PRIMARY KEY (`deletion_id`),
  ADD KEY `idx_deleted_member_id` (`member_id`),
  ADD KEY `idx_deleted_description` (`description`(255));

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
-- Indexes for table `receipts`
--
ALTER TABLE `receipts`
  ADD PRIMARY KEY (`receipt_id`),
  ADD KEY `receipts_ibfk_1` (`payment_id`),
  ADD KEY `receipts_ibfk_2` (`member_id`),
  ADD KEY `receipts_ibfk_3` (`officer_id`);

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
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=613;

--
-- AUTO_INCREMENT for table `deleted_members`
--
ALTER TABLE `deleted_members`
  MODIFY `deletion_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `payment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=75;

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

--
-- Constraints for table `receipts`
--
ALTER TABLE `receipts`
  ADD CONSTRAINT `receipts_ibfk_1` FOREIGN KEY (`payment_id`) REFERENCES `payments` (`payment_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `receipts_ibfk_2` FOREIGN KEY (`member_id`) REFERENCES `members` (`member_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `receipts_ibfk_3` FOREIGN KEY (`officer_id`) REFERENCES `officers` (`officer_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
