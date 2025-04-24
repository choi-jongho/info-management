-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 24, 2025 at 06:26 PM
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
(612, 'intel_treasurer', 'Batch Status Update', 'Updated 1 members to active status due to having less than 3 unpaid fees', '2025-04-10 13:39:29'),
(613, 'intel_pres', 'Login', 'User logged in successfully', '2025-04-11 08:21:10'),
(614, 'intel_pres', 'Add Member', 'Added member: Raymart Molboco (ID: 2023-00002)', '2025-04-11 08:24:09'),
(615, 'intel_pres', 'Status Update', 'Member Raymart Molboco (ID: 2023-00002) marked as active due to having less than 3 unpaid fees', '2025-04-11 08:24:09'),
(616, 'intel_pres', 'Batch Status Update', 'Updated 1 members to active status due to having less than 3 unpaid fees', '2025-04-11 08:24:09'),
(617, 'intel_pres', 'Add Fees', 'Added fee: INTEL FEE (₱100) for Semester: 1st Semester, SY: 2025-2026', '2025-04-11 08:43:05'),
(618, 'intel_pres', 'Login', 'User logged in successfully', '2025-04-12 01:27:48'),
(619, 'intel_pres', 'Add Payment', 'Payment of ₱100 added for Member: Andreia Beros (ID: 2025-77643), Semester: 1st Semester, SY: 2025-2026', '2025-04-12 01:44:32'),
(620, 'intel_pres', 'Update Fee Status', 'Updated fee status to Paid for Member: Andreia Beros (ID: 2025-77643), Semester: 1st Semester, SY: 2025-2026', '2025-04-12 01:44:32'),
(621, 'intel_pres', 'Add Payment', 'Payment of ₱100 added for Member: Kent Coricor (ID: 2025-09457), Semester: 1st Semester, SY: 2025-2026', '2025-04-12 02:09:28'),
(622, 'intel_pres', 'Update Fee Status', 'Updated fee status to Paid for Member: Kent Coricor (ID: 2025-09457), Semester: 1st Semester, SY: 2025-2026', '2025-04-12 02:09:28'),
(623, 'intel_pres', 'Login', 'User logged in successfully', '2025-04-12 02:11:35'),
(624, 'intel_pres', 'Login', 'User logged in successfully', '2025-04-12 02:27:31'),
(625, 'intel_pres', 'Login', 'User logged in successfully', '2025-04-12 02:29:19'),
(626, 'intel_pres', 'Login', 'User logged in successfully', '2025-04-12 02:29:32'),
(627, 'intel_pres', 'Login', 'User logged in successfully', '2025-04-12 03:03:33'),
(628, 'intel_pres', 'Add Payment', 'Payment of ₱100 added for Member: David Lazarte (ID: 2023-62721), Semester: 1st Semester, SY: 2022-2023', '2025-04-12 03:28:06'),
(629, 'intel_pres', 'Update Fee Status', 'Updated fee status to Paid for Member: David Lazarte (ID: 2023-62721), Semester: 1st Semester, SY: 2022-2023', '2025-04-12 03:28:06'),
(630, 'intel_pres', 'Add Payment', 'Payment of ₱100 added for Member: David Lazarte (ID: 2023-62721), Semester: 2nd Semester, SY: 2022-2023', '2025-04-12 03:28:06'),
(631, 'intel_pres', 'Update Fee Status', 'Updated fee status to Paid for Member: David Lazarte (ID: 2023-62721), Semester: 2nd Semester, SY: 2022-2023', '2025-04-12 03:28:06'),
(632, 'intel_pres', 'Add Payment', 'Payment of ₱100 added for Member: David Lazarte (ID: 2023-62721), Semester: 1st Semester, SY: 2023-2024', '2025-04-12 03:28:06'),
(633, 'intel_pres', 'Update Fee Status', 'Updated fee status to Paid for Member: David Lazarte (ID: 2023-62721), Semester: 1st Semester, SY: 2023-2024', '2025-04-12 03:28:06'),
(634, 'intel_pres', 'Status Update', 'Member David Lazarte (ID: 2023-62721) marked as active due to having less than 3 unpaid fees', '2025-04-12 03:28:11'),
(635, 'intel_pres', 'Batch Status Update', 'Updated 1 members to active status due to having less than 3 unpaid fees', '2025-04-12 03:28:11'),
(636, 'intel_pres', 'Add Payment', 'Payment of ₱100 added for Member: Sean Oliver Lopez (ID: 2024-09234), Semester: 1st Semester, SY: 2023-2024', '2025-04-12 03:33:38'),
(637, 'intel_pres', 'Update Fee Status', 'Updated fee status to Paid for Member: Sean Oliver Lopez (ID: 2024-09234), Semester: 1st Semester, SY: 2023-2024', '2025-04-12 03:33:38'),
(638, 'intel_pres', 'Add Payment', 'Payment of ₱100 added for Member: Sean Oliver Lopez (ID: 2024-09234), Semester: 1st Semester, SY: 2025-2026', '2025-04-12 03:37:01'),
(639, 'intel_pres', 'Update Fee Status', 'Updated fee status to Paid for Member: Sean Oliver Lopez (ID: 2024-09234), Semester: 1st Semester, SY: 2025-2026', '2025-04-12 03:37:01'),
(640, 'intel_pres', 'Add Payment', 'Payment of ₱100 added for Member: Sean Oliver Lopez (ID: 2024-09234), Semester: 2nd Semester, SY: 2023-2024', '2025-04-12 04:22:45'),
(641, 'intel_pres', 'Update Fee Status', 'Updated fee status to Paid for Member: Sean Oliver Lopez (ID: 2024-09234), Semester: 2nd Semester, SY: 2023-2024', '2025-04-12 04:22:45'),
(642, 'intel_pres', 'Status Update', 'Member Sean Oliver Lopez (ID: 2024-09234) marked as active due to having less than 3 unpaid fees', '2025-04-12 04:22:49'),
(643, 'intel_pres', 'Batch Status Update', 'Updated 1 members to active status due to having less than 3 unpaid fees', '2025-04-12 04:22:49'),
(644, 'intel_pres', 'Add Payment', 'Payment of ₱100 added for Member: John Michael Lopez (ID: 2024-10742), Semester: 1st Semester, SY: 2022-2023', '2025-04-12 04:46:53'),
(645, 'intel_pres', 'Update Fee Status', 'Updated fee status to Paid for Member: John Michael Lopez (ID: 2024-10742), Semester: 1st Semester, SY: 2022-2023', '2025-04-12 04:46:53'),
(646, 'intel_pres', 'Add Payment', 'Payment of ₱100 added for Member: John Michael Lopez (ID: 2024-10742), Semester: 2nd Semester, SY: 2022-2023', '2025-04-12 04:46:53'),
(647, 'intel_pres', 'Update Fee Status', 'Updated fee status to Paid for Member: John Michael Lopez (ID: 2024-10742), Semester: 2nd Semester, SY: 2022-2023', '2025-04-12 04:46:53'),
(648, 'intel_pres', 'Add Fees', 'Added fee: INTEL FEE (₱100) for Semester: 1st Semester, SY: 2023-2024', '2025-04-12 04:47:42'),
(649, 'intel_pres', 'Add Fees', 'Added fee: INTEL FEE (₱100) for Semester: 2nd Semester, SY: 2023-2024', '2025-04-12 04:47:50'),
(650, 'intel_pres', 'Status Update', 'Member Raymart Molboco (ID: 2023-00002) marked as inactive due to having 3 unpaid fees', '2025-04-12 04:47:50'),
(651, 'intel_pres', 'Status Update', 'Member Adrian Lim (ID: 2023-11112) marked as inactive due to having 3 unpaid fees', '2025-04-12 04:47:50'),
(652, 'intel_pres', 'Status Update', 'Member Marilyn Asebto (ID: 2023-55472) marked as inactive due to having 3 unpaid fees', '2025-04-12 04:47:50'),
(653, 'intel_pres', 'Status Update', 'Member Kent Coricor (ID: 2025-09457) marked as inactive due to having 3 unpaid fees', '2025-04-12 04:47:50'),
(654, 'intel_pres', 'Status Update', 'Member Tricia Edloy (ID: 2025-65423) marked as inactive due to having 3 unpaid fees', '2025-04-12 04:47:50'),
(655, 'intel_pres', 'Batch Status Update', 'Updated 5 members to inactive status due to having 3 or more unpaid fees', '2025-04-12 04:47:50'),
(656, 'intel_pres', 'Add Fees', 'Added fee: INTEL FEE (₱100) for Semester: 1st Semester, SY: 2022-2023', '2025-04-12 04:47:59'),
(657, 'intel_pres', 'Status Update', 'Member Andreia Beros (ID: 2025-77643) marked as inactive due to having 3 unpaid fees', '2025-04-12 04:47:59'),
(658, 'intel_pres', 'Batch Status Update', 'Updated 1 members to inactive status due to having 3 or more unpaid fees', '2025-04-12 04:47:59'),
(659, 'intel_pres', 'Add Fees', 'Added fee: INTEL FEE (₱100) for Semester: 2nd Semester, SY: 2022-2023', '2025-04-12 04:48:05'),
(660, 'intel_pres', 'Login', 'User logged in successfully', '2025-04-12 13:49:23'),
(661, 'intel_pres', 'Add Payment', 'Payment of ₱100 added for Member: Andreia Beros (ID: 2025-77643), Semester: 1st Semester, SY: 2023-2024', '2025-04-12 13:50:01'),
(662, 'intel_pres', 'Update Fee Status', 'Updated fee status to Paid for Member: Andreia Beros (ID: 2025-77643), Semester: 1st Semester, SY: 2023-2024', '2025-04-12 13:50:01'),
(663, 'intel_pres', 'Add Payment', 'Payment of ₱100 added for Member: Andreia Beros (ID: 2025-77643), Semester: 2nd Semester, SY: 2023-2024', '2025-04-12 13:50:01'),
(664, 'intel_pres', 'Update Fee Status', 'Updated fee status to Paid for Member: Andreia Beros (ID: 2025-77643), Semester: 2nd Semester, SY: 2023-2024', '2025-04-12 13:50:01'),
(665, 'intel_pres', 'Status Update', 'Member Andreia Beros (ID: 2025-77643) marked as active due to having less than 3 unpaid fees', '2025-04-12 13:50:30'),
(666, 'intel_pres', 'Batch Status Update', 'Updated 1 members to active status due to having less than 3 unpaid fees', '2025-04-12 13:50:30'),
(667, 'intel_pres', 'Member Deletion', 'Member Marilyn Asebto (ID: 2023-55472) (Deleted by officer: intel_pres)', '2025-04-12 13:51:02'),
(668, 'intel_pres', 'Member Deletion', 'Member Tricia Edloy (ID: 2025-65423) (Deleted by officer: intel_pres)', '2025-04-12 13:52:54'),
(669, 'intel_pres', 'Member Deletion', 'Member Andreia Beros (ID: 2025-77643) (Deleted by officer: intel_pres)', '2025-04-12 14:00:52'),
(670, 'intel_pres', 'Member Deletion', 'Member Adrian Lim (ID: 2023-11112) (Deleted by officer: intel_pres)', '2025-04-12 14:21:05'),
(671, 'intel_pres', 'Member Deletion', 'Member Kent Coricor (ID: 2025-09457) (Deleted by officer: intel_pres)', '2025-04-12 14:22:25'),
(672, 'intel_pres', 'Import Member', 'Imported member: Tricia Edloy (ID: 2025-65423)', '2025-04-12 14:23:35'),
(673, 'intel_pres', 'Import Member', 'Imported member: Kent Coricor (ID: 2025-09457)', '2025-04-12 14:23:35'),
(674, 'intel_pres', 'Import Member', 'Imported member: Andreia Beros (ID: 2025-77643)', '2025-04-12 14:23:35'),
(675, 'intel_pres', 'Import Member', 'Imported member: Marilyn Asebto (ID: 2023-55472)', '2025-04-12 14:23:35'),
(676, 'intel_pres', 'Import Member', 'Imported member: Adrian Lim (ID: 2023-11112)', '2025-04-12 14:23:35'),
(677, 'intel_pres', 'Status Update', 'Member Marilyn Asebto (ID: 2023-55472) marked as active due to having less than 3 unpaid fees', '2025-04-12 14:23:35'),
(678, 'intel_pres', 'Batch Status Update', 'Updated 1 members to active status due to having less than 3 unpaid fees', '2025-04-12 14:23:35'),
(679, 'intel_pres', 'Member Deletion', 'Member Marilyn Asebto (ID: 2023-55472) (Deleted by officer: intel_pres)', '2025-04-12 14:23:49'),
(680, 'intel_pres', 'Member Deletion', 'Member Tricia Edloy (ID: 2025-65423) (Deleted by officer: intel_pres)', '2025-04-12 14:26:17'),
(681, 'intel_pres', 'Member Deletion', 'Member Andreia Beros (ID: 2025-77643) (Deleted by officer: intel_pres)', '2025-04-12 14:32:40'),
(682, 'intel_pres', 'Add Fees', 'Added fee: INTEL FEE (₱100) for Semester: 1st Semester, SY: 2024-2025', '2025-04-12 14:36:00'),
(683, 'intel_pres', 'Status Update', 'Member David Lazarte (ID: 2023-62721) marked as inactive due to having 3 unpaid fees', '2025-04-12 14:36:00'),
(684, 'intel_pres', 'Status Update', 'Member Sean Oliver Lopez (ID: 2024-09234) marked as inactive due to having 3 unpaid fees', '2025-04-12 14:36:00'),
(685, 'intel_pres', 'Batch Status Update', 'Updated 2 members to inactive status due to having 3 or more unpaid fees', '2025-04-12 14:36:00'),
(686, 'intel_pres', 'Member Deletion', 'Member Kent Coricor (ID: 2025-09457) (Deleted by officer: intel_pres)', '2025-04-12 14:38:18'),
(687, 'intel_pres', 'Member Deletion', 'Member Adrian Lim (ID: 2023-11112)', '2025-04-12 14:41:27'),
(688, 'intel_pres', 'Import Member', 'Imported member: Tricia Edloy (ID: 2025-65423)', '2025-04-12 14:49:45'),
(689, 'intel_pres', 'Import Member', 'Imported member: Kent Coricor (ID: 2025-09457)', '2025-04-12 14:49:45'),
(690, 'intel_pres', 'Import Member', 'Imported member: Andreia Beros (ID: 2025-77643)', '2025-04-12 14:49:45'),
(691, 'intel_pres', 'Import Member', 'Imported member: Marilyn Asebto (ID: 2023-55472)', '2025-04-12 14:49:45'),
(692, 'intel_pres', 'Import Member', 'Imported member: Adrian Lim (ID: 2023-11112)', '2025-04-12 14:49:45'),
(693, 'intel_pres', 'Status Update', 'Member Marilyn Asebto (ID: 2023-55472) marked as active due to having less than 3 unpaid fees', '2025-04-12 14:49:45'),
(694, 'intel_pres', 'Batch Status Update', 'Updated 1 members to active status due to having less than 3 unpaid fees', '2025-04-12 14:49:45'),
(695, 'intel_pres', 'Member Deletion', 'Member Marilyn Asebto (ID: 2023-55472)', '2025-04-12 14:49:49'),
(696, 'intel_pres', 'Member Deletion', 'Member Kent Coricor (ID: 2025-09457)', '2025-04-12 14:52:29'),
(697, 'intel_pres', 'Member Deletion', 'Member Andreia Beros (ID: 2025-77643)', '2025-04-12 14:57:28'),
(698, 'intel_pres', 'Member Deletion', 'Member Adrian Lim (ID: 2023-11112) (Deleted by officer: intel_pres)', '2025-04-12 15:06:55'),
(699, 'intel_pres', 'Import Member', 'Imported member: Kent Coricor (ID: 2025-09457)', '2025-04-12 15:08:39'),
(700, 'intel_pres', 'Import Member', 'Imported member: Andreia Beros (ID: 2025-77643)', '2025-04-12 15:08:39'),
(701, 'intel_pres', 'Import Member', 'Imported member: Marilyn Asebto (ID: 2023-55472)', '2025-04-12 15:08:39'),
(702, 'intel_pres', 'Import Member', 'Imported member: Adrian Lim (ID: 2023-11112)', '2025-04-12 15:08:39'),
(703, 'intel_pres', 'Status Update', 'Member Marilyn Asebto (ID: 2023-55472) marked as active due to having less than 3 unpaid fees', '2025-04-12 15:08:39'),
(704, 'intel_pres', 'Batch Status Update', 'Updated 1 members to active status due to having less than 3 unpaid fees', '2025-04-12 15:08:39'),
(705, 'intel_pres', 'Member Deletion', 'Member Marilyn Asebto (ID: 2023-55472) (Deleted by officer: intel_pres)', '2025-04-12 15:08:43'),
(706, 'intel_pres', 'Import Member', 'Imported member: Marilyn Asebto (ID: 2023-55472)', '2025-04-12 15:23:08'),
(707, 'intel_pres', 'Status Update', 'Member Marilyn Asebto (ID: 2023-55472) marked as active due to having less than 3 unpaid fees', '2025-04-12 15:23:08'),
(708, 'intel_pres', 'Batch Status Update', 'Updated 1 members to active status due to having less than 3 unpaid fees', '2025-04-12 15:23:08'),
(709, 'intel_pres', 'Member Deletion', 'Member Marilyn Asebto (ID: 2023-55472) (Deleted by officer: intel_pres)', '2025-04-12 15:24:37'),
(710, 'intel_pres', 'Member Deletion', 'Member Adrian Lim (ID: 2023-11112) (Deleted by officer: intel_pres)', '2025-04-12 15:31:08'),
(711, 'intel_pres', 'Member Deletion', 'Member Andreia Beros (ID: 2025-77643) (Deleted by officer: intel_pres)', '2025-04-12 15:41:17'),
(712, 'intel_pres', 'Member Deletion', 'Member Kent Coricor (ID: 2025-09457) (Deleted by officer: intel_pres)', '2025-04-12 15:46:41'),
(713, 'intel_pres', 'Add Fees', 'Added fee: INTEL FEE (₱100) for Semester: 1st Semester, SY: 2025-2026', '2025-04-12 15:52:05'),
(714, 'intel_pres', 'Member Deletion', 'Member Tricia Edloy (ID: 2025-65423) (Deleted by officer: intel_pres)', '2025-04-12 16:11:45'),
(715, 'intel_pres', 'Import Member', 'Imported member: Tricia Edloy (ID: 2025-65423)', '2025-04-12 16:21:21'),
(716, 'intel_pres', 'Import Member', 'Imported member: Kent Coricor (ID: 2025-09457)', '2025-04-12 16:21:21'),
(717, 'intel_pres', 'Import Member', 'Imported member: Andreia Beros (ID: 2025-77643)', '2025-04-12 16:21:22'),
(718, 'intel_pres', 'Import Member', 'Imported member: Marilyn Asebto (ID: 2023-55472)', '2025-04-12 16:21:22'),
(719, 'intel_pres', 'Import Member', 'Imported member: Adrian Lim (ID: 2023-11112)', '2025-04-12 16:21:22'),
(720, 'intel_pres', 'Status Update', 'Member Marilyn Asebto (ID: 2023-55472) marked as active due to having less than 3 unpaid fees', '2025-04-12 16:21:22'),
(721, 'intel_pres', 'Batch Status Update', 'Updated 1 members to active status due to having less than 3 unpaid fees', '2025-04-12 16:21:22'),
(722, 'intel_pres', 'Member Deletion', 'Member Marilyn Asebto (ID: 2023-55472) (Deleted by officer: intel_pres)', '2025-04-12 16:21:27'),
(723, 'intel_pres', 'Member Deletion', 'Member Andreia Beros (ID: 2025-77643) (Deleted by officer: intel_pres)', '2025-04-12 16:23:29'),
(724, 'intel_pres', 'Member Deletion', 'Member Kent Coricor (ID: 2025-09457) (Deleted by officer: intel_pres)', '2025-04-12 16:26:49'),
(725, 'intel_pres', 'Member Deletion', 'Member Tricia Edloy (ID: 2025-65423) (Deleted by officer: intel_pres)', '2025-04-12 16:35:50'),
(726, 'intel_pres', 'Member Deletion', 'Member Adrian Lim (ID: 2023-11112) (Deleted by officer: intel_pres)', '2025-04-12 16:47:56'),
(727, 'intel_pres', 'Import Member', 'Imported member: Tricia Edloy (ID: 2025-65423)', '2025-04-12 16:50:32'),
(728, 'intel_pres', 'Import Member', 'Imported member: Kent Coricor (ID: 2025-09457)', '2025-04-12 16:50:32'),
(729, 'intel_pres', 'Import Member', 'Imported member: Andreia Beros (ID: 2025-77643)', '2025-04-12 16:50:32'),
(730, 'intel_pres', 'Import Member', 'Imported member: Marilyn Asebto (ID: 2023-55472)', '2025-04-12 16:50:32'),
(731, 'intel_pres', 'Import Member', 'Imported member: Adrian Lim (ID: 2023-11112)', '2025-04-12 16:50:32'),
(732, 'intel_pres', 'Status Update', 'Member Marilyn Asebto (ID: 2023-55472) marked as active due to having less than 3 unpaid fees', '2025-04-12 16:50:32'),
(733, 'intel_pres', 'Batch Status Update', 'Updated 1 members to active status due to having less than 3 unpaid fees', '2025-04-12 16:50:32'),
(734, 'intel_pres', 'Member Deletion', 'Member Marilyn Asebto (ID: 2023-55472) (Deleted by officer: intel_pres)', '2025-04-12 16:50:39'),
(735, 'intel_pres', 'Member Deletion', 'Member Andreia Beros (ID: 2025-77643) (Deleted by officer: intel_pres)', '2025-04-12 16:54:06'),
(736, 'intel_pres', 'Member Deletion', 'Member Kent Coricor (ID: 2025-09457) (Deleted by officer: intel_pres)', '2025-04-12 16:58:16'),
(737, 'intel_pres', 'Member Deletion', 'Member Tricia Edloy (ID: 2025-65423) (Deleted by officer: intel_pres)', '2025-04-12 17:02:06'),
(738, 'intel_pres', 'Member Deletion', 'Member Adrian Lim (ID: 2023-11112) (Deleted by officer: intel_pres)', '2025-04-12 17:08:55'),
(739, 'intel_pres', 'Import Member', 'Imported member: Tricia Edloy (ID: 2025-65423)', '2025-04-12 17:09:52'),
(740, 'intel_pres', 'Import Member', 'Imported member: Kent Coricor (ID: 2025-09457)', '2025-04-12 17:09:52'),
(741, 'intel_pres', 'Import Member', 'Imported member: Andreia Beros (ID: 2025-77643)', '2025-04-12 17:09:52'),
(742, 'intel_pres', 'Import Member', 'Imported member: Marilyn Asebto (ID: 2023-55472)', '2025-04-12 17:09:52'),
(743, 'intel_pres', 'Import Member', 'Imported member: Adrian Lim (ID: 2023-11112)', '2025-04-12 17:09:52'),
(744, 'intel_pres', 'Status Update', 'Member Marilyn Asebto (ID: 2023-55472) marked as active due to having less than 3 unpaid fees', '2025-04-12 17:09:52'),
(745, 'intel_pres', 'Batch Status Update', 'Updated 1 members to active status due to having less than 3 unpaid fees', '2025-04-12 17:09:52'),
(746, 'intel_pres', 'Member Deletion', 'Member Marilyn Asebto (ID: 2023-55472) (Deleted by officer: intel_pres)', '2025-04-12 17:09:56'),
(747, 'intel_pres', 'Member Deletion', 'Member Andreia Beros (ID: 2025-77643) (Deleted by officer: intel_pres)', '2025-04-12 17:13:45'),
(748, 'intel_pres', 'Member Deletion', 'Member Kent Coricor (ID: 2025-09457) (Deleted by officer: intel_pres)', '2025-04-12 17:15:32'),
(749, 'intel_pres', 'Member Deletion', 'Member Tricia Edloy (ID: 2025-65423) (Deleted by officer: intel_pres)', '2025-04-12 17:23:00'),
(750, 'intel_pres', 'Member Deletion', 'Member Adrian Lim (ID: 2023-11112) (Deleted by officer: intel_pres)', '2025-04-12 17:26:20'),
(751, 'intel_pres', 'Import Member', 'Imported member: Tricia Edloy (ID: 2025-65423)', '2025-04-12 17:27:12'),
(752, 'intel_pres', 'Import Member', 'Imported member: Kent Coricor (ID: 2025-09457)', '2025-04-12 17:27:12'),
(753, 'intel_pres', 'Import Member', 'Imported member: Andreia Beros (ID: 2025-77643)', '2025-04-12 17:27:12'),
(754, 'intel_pres', 'Import Member', 'Imported member: Marilyn Asebto (ID: 2023-55472)', '2025-04-12 17:27:12'),
(755, 'intel_pres', 'Import Member', 'Imported member: Adrian Lim (ID: 2023-11112)', '2025-04-12 17:27:12'),
(756, 'intel_pres', 'Status Update', 'Member Marilyn Asebto (ID: 2023-55472) marked as active due to having less than 3 unpaid fees', '2025-04-12 17:27:12'),
(757, 'intel_pres', 'Batch Status Update', 'Updated 1 members to active status due to having less than 3 unpaid fees', '2025-04-12 17:27:12'),
(758, 'intel_pres', 'Member Deletion', 'Member Marilyn Asebto (ID: 2023-55472) (Deleted by officer: intel_pres)', '2025-04-12 17:27:16'),
(759, 'intel_pres', 'Member Deletion', 'Member Andreia Beros (ID: 2025-77643) (Deleted by officer: intel_pres)', '2025-04-12 17:36:27'),
(760, 'intel_pres', 'Login', 'User logged in successfully', '2025-04-12 17:43:56'),
(761, 'intel_pres', 'Member Deletion', 'Member Kent Coricor (ID: 2025-09457) (Deleted by officer: intel_pres)', '2025-04-12 17:44:06'),
(762, 'intel_pres', 'Member Deletion', 'Member Tricia Edloy (ID: 2025-65423) (Deleted by officer: intel_pres)', '2025-04-12 17:46:11'),
(763, 'intel_pres', 'Member Deletion', 'Member Adrian Lim (ID: 2023-11112) (Deleted by officer: intel_pres)', '2025-04-12 17:47:56'),
(764, 'intel_pres', 'Import Member', 'Imported member: Tricia Edloy (ID: 2025-65423)', '2025-04-12 17:53:41'),
(765, 'intel_pres', 'Import Member', 'Imported member: Kent Coricor (ID: 2025-09457)', '2025-04-12 17:53:41'),
(766, 'intel_pres', 'Import Member', 'Imported member: Andreia Beros (ID: 2025-77643)', '2025-04-12 17:53:41'),
(767, 'intel_pres', 'Import Member', 'Imported member: Marilyn Asebto (ID: 2023-55472)', '2025-04-12 17:53:41'),
(768, 'intel_pres', 'Import Member', 'Imported member: Adrian Lim (ID: 2023-11112)', '2025-04-12 17:53:41'),
(769, 'intel_pres', 'Status Update', 'Member Marilyn Asebto (ID: 2023-55472) marked as active due to having less than 3 unpaid fees', '2025-04-12 17:53:41'),
(770, 'intel_pres', 'Batch Status Update', 'Updated 1 members to active status due to having less than 3 unpaid fees', '2025-04-12 17:53:41'),
(771, 'intel_pres', 'Member Deletion', 'Member Adrian Lim (ID: 2023-11112) (Deleted by officer: intel_pres)', '2025-04-12 17:54:34'),
(772, 'intel_pres', 'Member Deletion', 'Member Andreia Beros (ID: 2025-77643) (Deleted by officer: intel_pres)', '2025-04-12 18:04:44'),
(773, 'intel_pres', 'Member Deletion', 'Member Kent Coricor (ID: 2025-09457) (Deleted by officer: intel_pres)', '2025-04-12 18:15:44'),
(774, 'intel_pres', 'Member Deletion', 'Member Marilyn Asebto (ID: 2023-55472) (Deleted by officer: intel_pres)', '2025-04-12 18:27:28'),
(775, 'intel_pres', 'Member Deletion', 'Member Tricia Edloy (ID: 2025-65423) (Deleted by officer: intel_pres)', '2025-04-12 18:32:03'),
(776, 'intel_pres', 'Import Member', 'Imported member: Tricia Edloy (ID: 2025-65423)', '2025-04-12 18:35:30'),
(777, 'intel_pres', 'Import Member', 'Imported member: Kent Coricor (ID: 2025-09457)', '2025-04-12 18:35:30'),
(778, 'intel_pres', 'Import Member', 'Imported member: Andreia Beros (ID: 2025-77643)', '2025-04-12 18:35:30'),
(779, 'intel_pres', 'Import Member', 'Imported member: Marilyn Asebto (ID: 2023-55472)', '2025-04-12 18:35:30'),
(780, 'intel_pres', 'Import Member', 'Imported member: Adrian Lim (ID: 2023-11112)', '2025-04-12 18:35:30'),
(781, 'intel_pres', 'Status Update', 'Member Marilyn Asebto (ID: 2023-55472) marked as active due to having less than 3 unpaid fees', '2025-04-12 18:35:30'),
(782, 'intel_pres', 'Batch Status Update', 'Updated 1 members to active status due to having less than 3 unpaid fees', '2025-04-12 18:35:30'),
(783, 'intel_pres', 'Member Deletion', 'Member Kent Coricor (ID: 2025-09457) (Deleted by officer: intel_pres)', '2025-04-12 18:35:35'),
(784, 'intel_pres', 'Member Deletion', 'Member Marilyn Asebto (ID: 2023-55472) (Deleted by officer: intel_pres)', '2025-04-12 18:41:54'),
(785, 'intel_pres', 'Member Deletion', 'Member Andreia Beros (ID: 2025-77643) (Deleted by officer: intel_pres)', '2025-04-12 18:43:22'),
(786, 'intel_pres', 'Member Restoration', 'Member Andreia Beros (ID: 2025-77643) was restored from deletion', '2025-04-12 18:47:08'),
(787, 'intel_pres', 'Error', 'Failed to delete member 2025-77643: Unknown column &#039;fees_data&#039; in &#039;field list&#039;', '2025-04-12 18:54:49'),
(788, 'intel_pres', 'Error', 'Failed to delete member 2025-65423: Unknown column &#039;fees_data&#039; in &#039;field list&#039;', '2025-04-12 18:54:52'),
(789, 'intel_pres', 'Member Deletion', 'Member Andreia Beros (ID: 2025-77643) (Deleted by officer: intel_pres)', '2025-04-12 18:56:52'),
(790, 'intel_pres', 'Member Deletion', 'Member Adrian Lim (ID: 2023-11112) (Deleted by officer: intel_pres)', '2025-04-12 18:57:03'),
(791, 'intel_pres', 'Member Restoration', 'Member Adrian Lim (ID: 2023-11112) was restored from deletion', '2025-04-12 18:57:08'),
(792, 'intel_pres', 'Member Deletion', 'Member Adrian Lim (ID: 2023-11112) (Deleted by officer: intel_pres)', '2025-04-12 19:03:55'),
(793, 'intel_pres', 'Member Deletion', 'Member Tricia Edloy (ID: 2025-65423) (Deleted by officer: intel_pres)', '2025-04-12 19:04:02'),
(794, 'intel_pres', 'Member Restoration', 'Member Tricia Edloy (ID: 2025-65423) was restored from deletion', '2025-04-12 19:04:38'),
(795, 'intel_pres', 'Member Deletion', 'Member Sean Oliver Lopez (ID: 2024-09234) (Deleted by officer: intel_pres)', '2025-04-12 19:04:54'),
(796, 'intel_pres', 'Member Restoration', 'Member Sean Oliver Lopez (ID: 2024-09234) was restored from deletion', '2025-04-12 19:04:59'),
(797, 'intel_pres', 'Import Member', 'Imported member: Kent Coricor (ID: 2025-09457)', '2025-04-12 19:05:25'),
(798, 'intel_pres', 'Import Member', 'Imported member: Andreia Beros (ID: 2025-77643)', '2025-04-12 19:05:25'),
(799, 'intel_pres', 'Import Member', 'Imported member: Marilyn Asebto (ID: 2023-55472)', '2025-04-12 19:05:25'),
(800, 'intel_pres', 'Import Member', 'Imported member: Adrian Lim (ID: 2023-11112)', '2025-04-12 19:05:25'),
(801, 'intel_pres', 'Status Update', 'Member Marilyn Asebto (ID: 2023-55472) marked as active due to having less than 3 unpaid fees', '2025-04-12 19:05:25'),
(802, 'intel_pres', 'Batch Status Update', 'Updated 1 members to active status due to having less than 3 unpaid fees', '2025-04-12 19:05:25'),
(803, 'intel_pres', 'Member Deletion', 'Member Marilyn Asebto (ID: 2023-55472) (Deleted by officer: intel_pres)', '2025-04-12 19:05:30'),
(804, 'intel_pres', 'Member Restoration', 'Member Marilyn Asebto (ID: 2023-55472) was restored from deletion', '2025-04-12 19:05:33'),
(805, 'intel_pres', 'Member Deletion', 'Member Marilyn Asebto (ID: 2023-55472) (Deleted by officer: intel_pres)', '2025-04-12 19:09:48'),
(806, 'intel_pres', 'Member Restoration', 'Member Marilyn Asebto (ID: 2023-55472) was restored from deletion', '2025-04-12 19:09:57'),
(807, 'intel_pres', 'Add Payment', 'Payment of ₱100 added for Member: Tricia Edloy (ID: 2025-65423), Semester: 1st Semester, SY: 2025-2026', '2025-04-12 19:37:25'),
(808, 'intel_pres', 'Update Fee Status', 'Updated fee status to Paid for Member: Tricia Edloy (ID: 2025-65423), Semester: 1st Semester, SY: 2025-2026', '2025-04-12 19:37:25'),
(809, 'intel_pres', 'Member Deletion', 'Member Tricia Edloy (ID: 2025-65423) (Deleted by officer: intel_pres)', '2025-04-12 19:37:34'),
(810, 'intel_pres', 'Member Restoration', 'Member Tricia Edloy (ID: 2025-65423) was restored.', '2025-04-12 19:42:51'),
(811, 'intel_pres', 'Member Deletion', 'Member John Michael Lopez (ID: 2024-10742) (Deleted by officer: intel_pres)', '2025-04-12 19:43:26'),
(812, 'intel_pres', 'Member Deletion', 'Member Tricia Edloy (ID: 2025-65423) (Deleted by officer: intel_pres)', '2025-04-12 19:48:54'),
(813, 'intel_pres', 'Member Restoration', 'Member Tricia Edloy (ID: 2025-65423) was restored.', '2025-04-12 19:52:14'),
(814, 'intel_pres', 'Member Restoration', 'Member John Michael Lopez (ID: 2024-10742) was restored.', '2025-04-12 19:52:20'),
(815, 'intel_pres', 'Member Deletion', 'Member Tricia Edloy (ID: 2025-65423) (Deleted by officer: intel_pres)', '2025-04-12 19:52:50'),
(816, 'intel_pres', 'Member Restoration', 'Member Tricia Edloy (ID: 2025-65423) was restored.', '2025-04-12 19:52:56'),
(817, 'intel_pres', 'Member Deletion', 'Member Tricia Edloy (ID: 2025-65423) (Deleted by officer: intel_pres)', '2025-04-12 19:53:06'),
(818, 'intel_pres', 'Member Restoration', 'Member Tricia Edloy (ID: 2025-65423) was restored.', '2025-04-12 19:53:14'),
(819, 'intel_pres', 'Add Fees', 'Added fee: INTEL FEE (₱100) for Semester: 1st Semester, SY: 2023-2024', '2025-04-12 19:54:50'),
(820, 'intel_pres', 'Add Fees', 'Added fee: INTEL FEE (₱100) for Semester: 2nd Semester, SY: 2023-2024', '2025-04-12 19:54:57'),
(821, 'intel_pres', 'Status Update', 'Member Adrian Lim (ID: 2023-11112) marked as inactive due to having 3 unpaid fees', '2025-04-12 19:54:57'),
(822, 'intel_pres', 'Status Update', 'Member Marilyn Asebto (ID: 2023-55472) marked as inactive due to having 3 unpaid fees', '2025-04-12 19:54:57'),
(823, 'intel_pres', 'Status Update', 'Member Kent Coricor (ID: 2025-09457) marked as inactive due to having 3 unpaid fees', '2025-04-12 19:54:57'),
(824, 'intel_pres', 'Status Update', 'Member Andreia Beros (ID: 2025-77643) marked as inactive due to having 3 unpaid fees', '2025-04-12 19:54:57'),
(825, 'intel_pres', 'Batch Status Update', 'Updated 4 members to inactive status due to having 3 or more unpaid fees', '2025-04-12 19:54:57'),
(826, 'intel_pres', 'Add Payment', 'Payment of ₱100 added for Member: Kent Coricor (ID: 2025-09457), Semester: 1st Semester, SY: 2023-2024', '2025-04-12 19:56:24'),
(827, 'intel_pres', 'Update Fee Status', 'Updated fee status to Paid for Member: Kent Coricor (ID: 2025-09457), Semester: 1st Semester, SY: 2023-2024', '2025-04-12 19:56:24'),
(828, 'intel_pres', 'Status Update', 'Member Kent Coricor (ID: 2025-09457) marked as active due to having less than 3 unpaid fees', '2025-04-12 19:56:29'),
(829, 'intel_pres', 'Batch Status Update', 'Updated 1 members to active status due to having less than 3 unpaid fees', '2025-04-12 19:56:29'),
(830, 'intel_pres', 'Member Deletion', 'Member Kent Coricor (ID: 2025-09457) (Deleted by officer: intel_pres)', '2025-04-12 19:58:16'),
(831, 'intel_pres', 'Import Member', 'Imported member: Kent Coricor (ID: 2025-09457)', '2025-04-12 19:58:26'),
(832, 'intel_pres', 'Add Payment', 'Payment of ₱100 added for Member: Kent Coricor (ID: 2025-09457), Semester: 2nd Semester, SY: 2025-2026', '2025-04-12 20:10:42'),
(833, 'intel_pres', 'Update Fee Status', 'Updated fee status to Paid for Member: Kent Coricor (ID: 2025-09457), Semester: 2nd Semester, SY: 2025-2026', '2025-04-12 20:10:42'),
(834, 'intel_pres', 'Add Payment', 'Payment of ₱100 added for Member: Marilyn Asebto (ID: 2023-55472), Semester: 1st Semester, SY: 2025-2026', '2025-04-12 20:11:09'),
(835, 'intel_pres', 'Update Fee Status', 'Updated fee status to Paid for Member: Marilyn Asebto (ID: 2023-55472), Semester: 1st Semester, SY: 2025-2026', '2025-04-12 20:11:09'),
(836, 'intel_pres', 'Add Payment', 'Payment of ₱100 added for Member: Marilyn Asebto (ID: 2023-55472), Semester: 1st Semester, SY: 2023-2024', '2025-04-12 20:11:09'),
(837, 'intel_pres', 'Update Fee Status', 'Updated fee status to Paid for Member: Marilyn Asebto (ID: 2023-55472), Semester: 1st Semester, SY: 2023-2024', '2025-04-12 20:11:09'),
(838, 'intel_pres', 'Add Payment', 'Payment of ₱100 added for Member: Marilyn Asebto (ID: 2023-55472), Semester: 2nd Semester, SY: 2023-2024', '2025-04-12 20:11:09'),
(839, 'intel_pres', 'Update Fee Status', 'Updated fee status to Paid for Member: Marilyn Asebto (ID: 2023-55472), Semester: 2nd Semester, SY: 2023-2024', '2025-04-12 20:11:09'),
(840, 'intel_pres', 'Status Update', 'Member Marilyn Asebto (ID: 2023-55472) marked as active due to having less than 3 unpaid fees', '2025-04-12 20:11:22'),
(841, 'intel_pres', 'Batch Status Update', 'Updated 1 members to active status due to having less than 3 unpaid fees', '2025-04-12 20:11:22'),
(842, 'intel_pres', 'Add Payment', 'Payment of ₱100 added for Member: Andreia Beros (ID: 2025-77643), Semester: 2nd Semester, SY: 2023-2024', '2025-04-12 20:11:46'),
(843, 'intel_pres', 'Update Fee Status', 'Updated fee status to Paid for Member: Andreia Beros (ID: 2025-77643), Semester: 2nd Semester, SY: 2023-2024', '2025-04-12 20:11:46'),
(844, 'intel_pres', 'Add Payment', 'Payment of ₱100 added for Member: Andreia Beros (ID: 2025-77643), Semester: 1st Semester, SY: 2023-2024', '2025-04-12 20:11:58'),
(845, 'intel_pres', 'Update Fee Status', 'Updated fee status to Paid for Member: Andreia Beros (ID: 2025-77643), Semester: 1st Semester, SY: 2023-2024', '2025-04-12 20:11:58'),
(846, 'intel_pres', 'Status Update', 'Member Andreia Beros (ID: 2025-77643) marked as active due to having less than 3 unpaid fees', '2025-04-12 20:12:00'),
(847, 'intel_pres', 'Batch Status Update', 'Updated 1 members to active status due to having less than 3 unpaid fees', '2025-04-12 20:12:00'),
(848, 'intel_pres', 'Member Deletion', 'Member Marilyn Asebto (ID: 2023-55472) (Deleted by officer: intel_pres)', '2025-04-12 20:12:24'),
(849, 'intel_pres', 'Member Restoration', 'Member Marilyn Asebto (ID: 2023-55472) was restored.', '2025-04-12 20:12:29'),
(850, 'intel_pres', 'Member Deletion', 'Member Marilyn Asebto (ID: 2023-55472) (Deleted by officer: intel_pres)', '2025-04-12 20:12:37'),
(851, 'intel_pres', 'Member Restoration', 'Member Marilyn Asebto (ID: 2023-55472) was restored.', '2025-04-12 20:12:50'),
(852, 'intel_pres', 'Member Deletion', 'Member Marilyn Asebto (ID: 2023-55472) (Deleted by officer: intel_pres)', '2025-04-12 20:14:44'),
(853, 'intel_pres', 'Member Restoration', 'Member Marilyn Asebto (ID: 2023-55472) was restored.', '2025-04-12 20:14:49'),
(854, 'intel_pres', 'Member Deletion', 'Member Marilyn Asebto (ID: 2023-55472) (Deleted by officer: intel_pres)', '2025-04-12 20:21:31'),
(855, 'intel_pres', 'Member Restoration', 'Member Marilyn Asebto (ID: 2023-55472) was restored.', '2025-04-12 20:21:38'),
(856, 'intel_pres', 'Add Fees', 'Added fee: INTEL FEE (₱100) for Semester: 2nd Semester, SY: 2022-2023', '2025-04-12 20:23:19'),
(857, 'intel_pres', 'Status Update', 'Member Tricia Edloy (ID: 2025-65423) marked as inactive due to having 3 unpaid fees', '2025-04-12 20:23:19'),
(858, 'intel_pres', 'Batch Status Update', 'Updated 1 members to inactive status due to having 3 or more unpaid fees', '2025-04-12 20:23:19'),
(859, 'intel_pres', 'Add Payment', 'Payment of ₱100 added for Member: Marilyn Asebto (ID: 2023-55472), Semester: 2nd Semester, SY: 2022-2023', '2025-04-12 20:23:39'),
(860, 'intel_pres', 'Update Fee Status', 'Updated fee status to Paid for Member: Marilyn Asebto (ID: 2023-55472), Semester: 2nd Semester, SY: 2022-2023', '2025-04-12 20:23:39'),
(861, 'intel_pres', 'Member Deletion', 'Member Marilyn Asebto (ID: 2023-55472) (Deleted by officer: intel_pres)', '2025-04-12 20:23:51'),
(862, 'intel_pres', 'Member Restoration', 'Member Marilyn Asebto (ID: 2023-55472) was restored.', '2025-04-12 20:23:59'),
(863, 'intel_pres', 'Login', 'User logged in successfully', '2025-04-17 12:25:29'),
(866, 'intel_pres', 'Add Payment', 'Payment of ₱100 added for Member: Tricia Edloy (ID: 2025-65423), Semester: 2nd Semester, SY: 2023-2024', '2025-04-17 12:27:13'),
(867, 'intel_pres', 'Update Fee Status', 'Updated fee status to Paid for Member: Tricia Edloy (ID: 2025-65423), Semester: 2nd Semester, SY: 2023-2024', '2025-04-17 12:27:13'),
(868, 'intel_pres', 'Add Payment', 'Payment of ₱100 added for Member: Tricia Edloy (ID: 2025-65423), Semester: 1st Semester, SY: 2023-2024', '2025-04-17 12:27:13'),
(869, 'intel_pres', 'Update Fee Status', 'Updated fee status to Paid for Member: Tricia Edloy (ID: 2025-65423), Semester: 1st Semester, SY: 2023-2024', '2025-04-17 12:27:13'),
(870, 'intel_pres', 'Status Update', 'Member Tricia Edloy (ID: 2025-65423) marked as active due to having less than 3 unpaid fees', '2025-04-17 12:27:32'),
(871, 'intel_pres', 'Batch Status Update', 'Updated 1 members to active status due to having less than 3 unpaid fees', '2025-04-17 12:27:32'),
(872, 'intel_pres', 'Member Deletion', 'Member Tricia Edloy (ID: 2025-65423) (Deleted by officer: intel_pres)', '2025-04-17 12:28:03'),
(873, 'intel_pres', 'Member Restoration', 'Member Tricia Edloy (ID: 2025-65423) was restored.', '2025-04-17 12:28:10'),
(874, 'intel_pres', 'Member Deletion', 'Member Adrian Lim (ID: 2023-11112) (Deleted by officer: intel_pres)', '2025-04-17 12:30:50'),
(875, 'intel_pres', 'Import Member', 'Imported member: Adrian Lim (ID: 2023-11112)', '2025-04-17 12:31:19'),
(876, 'intel_pres', 'Add Fees', 'Added fee: INTEL FEE (₱100) for Semester: 1st Semester, SY: 2023-2024', '2025-04-17 12:31:37'),
(877, 'intel_pres', 'Add Member', 'Added member: Arneil Lopez (ID: 2023-01234)', '2025-04-17 12:35:05'),
(878, 'intel_vpres', 'Login', 'User logged in successfully', '2025-04-17 13:20:21'),
(879, 'intel_pres', 'Login', 'User logged in successfully', '2025-04-17 13:22:56'),
(880, 'intel_pres', 'Login', 'User logged in successfully', '2025-04-22 04:37:05'),
(881, 'intel_pres', 'Add Payment', 'Payment of ₱100 added for Member: Adrian Lim (ID: 2023-11112), Semester: 1st Semester, SY: 2025-2026', '2025-04-22 04:54:26'),
(882, 'intel_pres', 'Update Fee Status', 'Updated fee status to Paid for Member: Adrian Lim (ID: 2023-11112), Semester: 1st Semester, SY: 2025-2026', '2025-04-22 04:54:26'),
(883, 'intel_pres', 'Add Payment', 'Payment of ₱100 added for Member: Adrian Lim (ID: 2023-11112), Semester: 1st Semester, SY: 2023-2024', '2025-04-22 04:54:26'),
(884, 'intel_pres', 'Update Fee Status', 'Updated fee status to Paid for Member: Adrian Lim (ID: 2023-11112), Semester: 1st Semester, SY: 2023-2024', '2025-04-22 04:54:26'),
(885, 'intel_pres', 'Add Payment', 'Payment of ₱100 added for Member: Sean Oliver Lopez (ID: 2024-09234), Semester: 1st Semester, SY: 2022-2023', '2025-04-22 04:55:31'),
(886, 'intel_pres', 'Update Fee Status', 'Updated fee status to Paid for Member: Sean Oliver Lopez (ID: 2024-09234), Semester: 1st Semester, SY: 2022-2023', '2025-04-22 04:55:31'),
(887, 'intel_pres', 'Add Payment', 'Payment of ₱100 added for Member: Sean Oliver Lopez (ID: 2024-09234), Semester: 2nd Semester, SY: 2022-2023', '2025-04-22 04:55:31'),
(888, 'intel_pres', 'Update Fee Status', 'Updated fee status to Paid for Member: Sean Oliver Lopez (ID: 2024-09234), Semester: 2nd Semester, SY: 2022-2023', '2025-04-22 04:55:31'),
(889, 'intel_pres', 'Add Payment', 'Payment of ₱100 added for Member: Sean Oliver Lopez (ID: 2024-09234), Semester: 1st Semester, SY: 2024-2025', '2025-04-22 04:55:31'),
(890, 'intel_pres', 'Update Fee Status', 'Updated fee status to Paid for Member: Sean Oliver Lopez (ID: 2024-09234), Semester: 1st Semester, SY: 2024-2025', '2025-04-22 04:55:31'),
(891, 'intel_pres', 'Status Update', 'Member Sean Oliver Lopez (ID: 2024-09234) marked as active due to having less than 3 unpaid fees', '2025-04-22 04:55:39'),
(892, 'intel_pres', 'Batch Status Update', 'Updated 1 members to active status due to having less than 3 unpaid fees', '2025-04-22 04:55:39'),
(893, 'intel_vpres', 'Login', 'User logged in successfully', '2025-04-22 07:03:17'),
(894, 'intel_pres', 'Login', 'User logged in successfully', '2025-04-22 07:52:25'),
(895, 'intel_pres', 'Login', 'User logged in successfully', '2025-04-22 09:17:41'),
(896, 'intel_pres', 'Login', 'User logged in successfully', '2025-04-22 09:30:59'),
(897, 'intel_vpres', 'Login', 'User logged in successfully', '2025-04-22 11:21:26'),
(898, 'intel_pres', 'Login', 'User logged in successfully', '2025-04-22 11:24:12'),
(899, 'intel_vpres', 'Login', 'User logged in successfully', '2025-04-22 11:45:22'),
(900, 'intel_pres', 'Login', 'User logged in successfully', '2025-04-22 12:31:59'),
(901, 'intel_pres', 'Member Deletion', 'Member Adrian Lim (ID: 2023-11112) (Deleted by officer: intel_pres)', '2025-04-22 12:32:34'),
(902, 'intel_pres', 'Member Restoration', 'Member Adrian Lim (ID: 2023-11112) was restored.', '2025-04-22 12:32:44'),
(903, 'intel_pres', 'Add Member', 'Added member: Coveia zayne Gariando (ID: 2023-10101)', '2025-04-22 12:41:44'),
(904, 'intel_pres', 'Update Member', 'Updated member: Coveia Zayne Gariando (ID: 2023-10101)', '2025-04-22 12:47:33'),
(905, 'intel_pres', 'Add Member', 'Added member: Ernesto Cainong (ID: 2023-01012)', '2025-04-22 12:48:21'),
(906, 'intel_pres', 'Add Member', 'Added member: Quency Athena Gariando (ID: 2023-01521)', '2025-04-22 12:49:40'),
(907, 'intel_pres', 'Login', 'User logged in successfully', '2025-04-23 07:49:06'),
(908, 'intel_pres', 'Login', 'User logged in successfully', '2025-04-24 02:15:14'),
(909, 'intel_treasurer', 'Login', 'User logged in successfully', '2025-04-24 02:59:33'),
(910, 'intel_pres', 'Login', 'User logged in successfully', '2025-04-24 03:12:01'),
(911, 'intel_pres', 'Login', 'User logged in successfully', '2025-04-24 03:19:15'),
(912, 'intel_pres', 'Login', 'User logged in successfully', '2025-04-24 03:23:16'),
(913, 'intel_pres', 'Update Member', 'Updated member: Marilyn Asebto (ID: 2023-55472)', '2025-04-24 03:32:35'),
(914, 'intel_pres', 'Member Deletion', 'Deleted member: Marilyn Asebto (ID: 2023-55472)', '2025-04-24 03:33:05'),
(915, 'intel_pres', 'Member Deletion', 'Deleted member: Quency Athena Gariando (ID: 2023-01521)', '2025-04-24 03:37:12'),
(916, 'intel_pres', 'Member Deletion', 'Deleted member: Arneil Lopez (ID: 2023-01234)', '2025-04-24 03:53:30'),
(917, 'intel_pres', 'Member Deletion', 'Member Adrian Lim (ID: 2023-11112) (Deleted by officer: intel_pres)', '2025-04-24 03:56:03'),
(918, 'intel_pres', 'Member Deletion', 'Member Andreia Beros (ID: 2025-77643) (Deleted by officer: intel_pres)', '2025-04-24 04:00:01'),
(919, 'intel_pres', 'Import Member', 'Imported member: Andreia Beros (ID: 2025-77643)', '2025-04-24 04:11:43'),
(920, 'intel_pres', 'Import Member', 'Imported member: Marilyn Asebto (ID: 2023-55472)', '2025-04-24 04:11:43'),
(921, 'intel_pres', 'Import Member', 'Imported member: Adrian Lim (ID: 2023-11112)', '2025-04-24 04:11:43'),
(922, 'intel_pres', 'Status Update', 'Member Marilyn Asebto (ID: 2023-55472) marked as active due to having less than 3 unpaid fees', '2025-04-24 04:11:43'),
(923, 'intel_pres', 'Batch Status Update', 'Updated 1 members to active status due to having less than 3 unpaid fees', '2025-04-24 04:11:43'),
(924, 'intel_pres', 'Member Deletion', 'Member Andreia Beros (ID: 2025-77643) (Deleted by officer: intel_pres)', '2025-04-24 04:14:55'),
(925, 'intel_pres', 'Member Deletion', 'Member Tricia Edloy (ID: 2025-65423) (Deleted by officer: intel_pres)', '2025-04-24 04:29:02'),
(926, 'intel_pres', 'Member Deletion', 'Member Kent Coricor (ID: 2025-09457) (Deleted by officer: intel_pres)', '2025-04-24 04:32:21'),
(927, 'intel_pres', 'Import Member', 'Imported member: Tricia Edloy (ID: 2025-65423)', '2025-04-24 04:33:40'),
(928, 'intel_pres', 'Import Member', 'Imported member: Kent Coricor (ID: 2025-09457)', '2025-04-24 04:33:40'),
(929, 'intel_pres', 'Import Member', 'Imported member: Andreia Beros (ID: 2025-77643)', '2025-04-24 04:33:40'),
(930, 'intel_pres', 'Import Member', 'Imported member: Marilyn Asebto (ID: 2023-55472)', '2025-04-24 04:33:40'),
(931, 'intel_pres', 'Status Update', 'Member Marilyn Asebto (ID: 2023-55472) marked as active due to having less than 3 unpaid fees', '2025-04-24 04:33:40'),
(932, 'intel_pres', 'Batch Status Update', 'Updated 1 members to active status due to having less than 3 unpaid fees', '2025-04-24 04:33:40'),
(933, 'intel_pres', 'Member Deletion', 'Member Marilyn Asebto (ID: 2023-55472) (Deleted by officer: intel_pres)', '2025-04-24 04:33:44'),
(934, 'intel_pres', 'Member Deletion', 'Member Andreia Beros (ID: 2025-77643) (Deleted by officer: intel_pres)', '2025-04-24 04:37:58'),
(935, 'intel_pres', 'Member Deletion', 'Member Kent Coricor (ID: 2025-09457) (Deleted by officer: intel_pres)', '2025-04-24 04:40:23'),
(936, 'intel_pres', 'Member Deletion', 'Member Tricia Edloy (ID: 2025-65423) (Deleted by officer: intel_pres)', '2025-04-24 04:41:49'),
(937, 'intel_pres', 'Member Deletion', 'Member Adrian Lim (ID: 2023-11112) was successfully deleted by officer: intel_pres', '2025-04-24 04:44:44'),
(938, 'intel_pres', 'Login', 'User logged in successfully', '2025-04-24 14:36:26'),
(939, 'intel_pres', 'Import Member', 'Imported member: Tricia Edloy (ID: 2025-65423)', '2025-04-24 14:36:43'),
(940, 'intel_pres', 'Import Member', 'Imported member: Kent Coricor (ID: 2025-09457)', '2025-04-24 14:36:43'),
(941, 'intel_pres', 'Import Member', 'Imported member: Andreia Beros (ID: 2025-77643)', '2025-04-24 14:36:43'),
(942, 'intel_pres', 'Import Member', 'Imported member: Marilyn Asebto (ID: 2023-55472)', '2025-04-24 14:36:43');
INSERT INTO `activity_logs` (`log_id`, `officer_id`, `action`, `description`, `date`) VALUES
(943, 'intel_pres', 'Import Member', 'Imported member: Adrian Lim (ID: 2023-11112)', '2025-04-24 14:36:43'),
(944, 'intel_pres', 'Status Update', 'Member Marilyn Asebto (ID: 2023-55472) marked as active due to having less than 3 unpaid fees', '2025-04-24 14:36:43'),
(945, 'intel_pres', 'Batch Status Update', 'Updated 1 members to active status due to having less than 3 unpaid fees', '2025-04-24 14:36:43'),
(946, 'intel_pres', 'Member Deletion', 'Member Andreia Beros (ID: 2025-77643) (Deleted by officer: intel_pres)', '2025-04-24 14:36:48'),
(947, 'intel_pres', 'Member Deletion', 'Member Marilyn Asebto (ID: 2023-55472) (Deleted by officer: intel_pres)', '2025-04-24 14:37:59'),
(948, 'intel_pres', 'Member Deletion', 'Member Tricia Edloy (ID: 2025-65423) (Deleted by officer: intel_pres)', '2025-04-24 14:40:40'),
(949, 'intel_pres', 'Member Deletion', 'Member Kent Coricor (ID: 2025-09457) (Deleted by officer: intel_pres)', '2025-04-24 14:44:24'),
(950, 'intel_pres', 'Member Deletion', 'Member Adrian Lim (ID: 2023-11112) (Deleted by officer: intel_pres)', '2025-04-24 14:45:05'),
(951, 'intel_pres', 'Import Member', 'Imported member: Tricia Edloy (ID: 2025-65423)', '2025-04-24 14:49:09'),
(952, 'intel_pres', 'Import Member', 'Imported member: Kent Coricor (ID: 2025-09457)', '2025-04-24 14:49:09'),
(953, 'intel_pres', 'Import Member', 'Imported member: Andreia Beros (ID: 2025-77643)', '2025-04-24 14:49:09'),
(954, 'intel_pres', 'Import Member', 'Imported member: Marilyn Asebto (ID: 2023-55472)', '2025-04-24 14:49:09'),
(955, 'intel_pres', 'Import Member', 'Imported member: Adrian Lim (ID: 2023-11112)', '2025-04-24 14:49:09'),
(956, 'intel_pres', 'Status Update', 'Member Marilyn Asebto (ID: 2023-55472) marked as active due to having less than 3 unpaid fees', '2025-04-24 14:49:09'),
(957, 'intel_pres', 'Batch Status Update', 'Updated 1 members to active status due to having less than 3 unpaid fees', '2025-04-24 14:49:09'),
(958, 'intel_pres', 'Member Deletion', 'Member Marilyn Asebto (ID: 2023-55472) (Deleted by officer: intel_pres)', '2025-04-24 14:49:14'),
(959, 'intel_pres', 'Member Deletion', 'Member Andreia Beros (ID: 2025-77643) (Deleted by officer: intel_pres)', '2025-04-24 14:51:05'),
(960, 'intel_pres', 'Member Deletion', 'Member Kent Coricor (ID: 2025-09457) (Deleted by officer: intel_pres)', '2025-04-24 14:53:03'),
(961, 'intel_pres', 'Member Deletion', 'Member Tricia Edloy (ID: 2025-65423) (Deleted by officer: intel_pres)', '2025-04-24 14:54:40'),
(962, 'intel_pres', 'Member Deletion', 'Member Adrian Lim (ID: 2023-11112) (Deleted by officer: intel_pres)', '2025-04-24 14:56:13'),
(963, 'intel_pres', 'Member Deletion', 'Member Coveia Zayne Gariando (ID: 2023-10101) (Deleted by officer: intel_pres)', '2025-04-24 15:07:40'),
(964, 'intel_pres', 'Import Member', 'Imported member: Tricia Edloy (ID: 2025-65423)', '2025-04-24 15:08:43'),
(965, 'intel_pres', 'Import Member', 'Imported member: Kent Coricor (ID: 2025-09457)', '2025-04-24 15:08:43'),
(966, 'intel_pres', 'Import Member', 'Imported member: Andreia Beros (ID: 2025-77643)', '2025-04-24 15:08:43'),
(967, 'intel_pres', 'Import Member', 'Imported member: Marilyn Asebto (ID: 2023-55472)', '2025-04-24 15:08:43'),
(968, 'intel_pres', 'Import Member', 'Imported member: Adrian Lim (ID: 2023-11112)', '2025-04-24 15:08:43'),
(969, 'intel_pres', 'Status Update', 'Member Marilyn Asebto (ID: 2023-55472) marked as active due to having less than 3 unpaid fees', '2025-04-24 15:08:43'),
(970, 'intel_pres', 'Batch Status Update', 'Updated 1 members to active status due to having less than 3 unpaid fees', '2025-04-24 15:08:43'),
(971, 'intel_pres', 'Member Deletion', 'Member David Lazarte (ID: 2023-62721) (Deleted by officer: intel_pres)', '2025-04-24 15:09:34'),
(972, 'intel_pres', 'Error', 'Failed to delete member 2024-10742: Unknown column &#039;deleted_at&#039; in &#039;field list&#039;', '2025-04-24 15:17:41'),
(973, 'intel_pres', 'Member Deletion', 'Member John Michael Lopez (ID: 2024-10742) (Deleted by officer: intel_pres)', '2025-04-24 15:19:31'),
(974, 'intel_pres', 'Member Deletion', 'Member Raymart Molboco (ID: 2023-00002) (Deleted by officer: intel_pres)', '2025-04-24 15:26:10'),
(975, 'intel_pres', 'Add Fees', 'Added fee: INTEL FEE (₱100) for Semester: 1st Semester, SY: 2024-2025', '2025-04-24 15:32:08'),
(976, 'intel_pres', 'Add Fees', 'Added fee: INTEL FEE (₱100) for Semester: 1st Semester, SY: 2023-2024', '2025-04-24 15:32:16'),
(977, 'intel_pres', 'Status Update', 'Member Adrian Lim (ID: 2023-11112) marked as inactive due to having 3 unpaid fees', '2025-04-24 15:32:16'),
(978, 'intel_pres', 'Status Update', 'Member Marilyn Asebto (ID: 2023-55472) marked as inactive due to having 3 unpaid fees', '2025-04-24 15:32:16'),
(979, 'intel_pres', 'Status Update', 'Member Kent Coricor (ID: 2025-09457) marked as inactive due to having 3 unpaid fees', '2025-04-24 15:32:16'),
(980, 'intel_pres', 'Status Update', 'Member Tricia Edloy (ID: 2025-65423) marked as inactive due to having 3 unpaid fees', '2025-04-24 15:32:16'),
(981, 'intel_pres', 'Status Update', 'Member Andreia Beros (ID: 2025-77643) marked as inactive due to having 3 unpaid fees', '2025-04-24 15:32:16'),
(982, 'intel_pres', 'Batch Status Update', 'Updated 5 members to inactive status due to having 3 or more unpaid fees', '2025-04-24 15:32:16'),
(983, 'intel_pres', 'Add Fees', 'Added fee: INTEL FEE (₱100) for Semester: 1st Semester, SY: 2025-2026', '2025-04-24 15:32:21'),
(984, 'intel_pres', 'Add Fees', 'Added fee: INTEL FEE (₱100) for Semester: 1st Semester, SY: 2022-2023', '2025-04-24 15:32:25'),
(985, 'intel_pres', 'Error', 'Failed to delete member 2025-77643: Unknown column &#039;deleted_at&#039; in &#039;field list&#039;', '2025-04-24 15:32:28'),
(986, 'intel_pres', 'Member Deletion', 'Member Marilyn Asebto (ID: 2023-55472) (Deleted by officer: intel_pres)', '2025-04-24 15:33:13'),
(987, 'intel_pres', 'Member Deletion', 'Member Kent Coricor (ID: 2025-09457) (Deleted by officer: intel_pres)', '2025-04-24 15:35:16'),
(988, 'intel_pres', 'Member Deletion', 'Member Tricia Edloy (ID: 2025-65423) (Deleted by officer: intel_pres)', '2025-04-24 15:37:36'),
(989, 'intel_pres', 'Member Deletion', 'Member Andreia Beros (ID: 2025-77643) (Deleted by officer: intel_pres)', '2025-04-24 15:42:03'),
(990, 'intel_pres', 'Member Deletion', 'Member Adrian Lim (ID: 2023-11112) (Deleted by officer: intel_pres)', '2025-04-24 15:59:50'),
(991, 'intel_pres', 'Import Member', 'Imported member: Tricia Edloy (ID: 2025-65423)', '2025-04-24 16:00:01'),
(992, 'intel_pres', 'Import Member', 'Imported member: Kent Coricor (ID: 2025-09457)', '2025-04-24 16:00:01'),
(993, 'intel_pres', 'Import Member', 'Imported member: Andreia Beros (ID: 2025-77643)', '2025-04-24 16:00:01'),
(994, 'intel_pres', 'Import Member', 'Imported member: Marilyn Asebto (ID: 2023-55472)', '2025-04-24 16:00:01'),
(995, 'intel_pres', 'Import Member', 'Imported member: Adrian Lim (ID: 2023-11112)', '2025-04-24 16:00:01'),
(996, 'intel_pres', 'Status Update', 'Member Marilyn Asebto (ID: 2023-55472) marked as active due to having less than 3 unpaid fees', '2025-04-24 16:00:01'),
(997, 'intel_pres', 'Batch Status Update', 'Updated 1 members to active status due to having less than 3 unpaid fees', '2025-04-24 16:00:01'),
(998, 'intel_pres', 'Add Fees', 'Added fee: INTEL FEE (₱100) for Semester: 1st Semester, SY: 2024-2025', '2025-04-24 16:06:17'),
(999, 'intel_pres', 'Add Fees', 'Added fee: INTEL FEE (₱100) for Semester: 1st Semester, SY: 2025-2026', '2025-04-24 16:06:22'),
(1000, 'intel_pres', 'Status Update', 'Member Kent Coricor (ID: 2025-09457) marked as inactive due to having 3 unpaid fees', '2025-04-24 16:06:22'),
(1001, 'intel_pres', 'Batch Status Update', 'Updated 1 members to inactive status due to having 3 or more unpaid fees', '2025-04-24 16:06:22'),
(1002, 'intel_pres', 'Add Fees', 'Added fee: INTEL FEE (₱100) for Semester: 1st Semester, SY: 2023-2024', '2025-04-24 16:06:26'),
(1003, 'intel_pres', 'Status Update', 'Member Adrian Lim (ID: 2023-11112) marked as inactive due to having 3 unpaid fees', '2025-04-24 16:06:26'),
(1004, 'intel_pres', 'Status Update', 'Member Marilyn Asebto (ID: 2023-55472) marked as inactive due to having 3 unpaid fees', '2025-04-24 16:06:27'),
(1005, 'intel_pres', 'Status Update', 'Member Tricia Edloy (ID: 2025-65423) marked as inactive due to having 3 unpaid fees', '2025-04-24 16:06:27'),
(1006, 'intel_pres', 'Status Update', 'Member Andreia Beros (ID: 2025-77643) marked as inactive due to having 3 unpaid fees', '2025-04-24 16:06:27'),
(1007, 'intel_pres', 'Batch Status Update', 'Updated 4 members to inactive status due to having 3 or more unpaid fees', '2025-04-24 16:06:27'),
(1008, 'intel_pres', 'Error', 'Failed to delete member 2023-55472: Cannot delete or update a parent row: a foreign key constraint fails (`intel_records`.`deleted_members`, CONSTRAINT `deleted_members_ibfk_1` FOREIGN KEY (`member_id`) REFERENCES `members` (`member_id`))', '2025-04-24 16:06:30'),
(1009, 'intel_pres', 'Member Deletion', 'Member Marilyn Asebto (ID: 2023-55472) (Deleted by officer: intel_pres)', '2025-04-24 16:07:09'),
(1010, 'intel_pres', 'Member Deletion', 'Member Andreia Beros (ID: 2025-77643) (Deleted by officer: intel_pres)', '2025-04-24 16:09:16'),
(1011, 'intel_pres', 'Member Restoration', 'Member Andreia Beros (ID: 2025-77643) was restored.', '2025-04-24 16:20:15'),
(1012, 'intel_pres', 'Member Deletion', 'Member Andreia Beros (ID: 2025-77643) (Deleted by officer: intel_pres)', '2025-04-24 16:20:24'),
(1013, 'intel_pres', 'Member Restoration', 'Member Andreia Beros (ID: 2025-77643) was restored.', '2025-04-24 16:20:36');

-- --------------------------------------------------------

--
-- Table structure for table `deleted_members`
--

CREATE TABLE `deleted_members` (
  `deletion_id` int(11) NOT NULL,
  `member_id` varchar(20) NOT NULL,
  `description` text NOT NULL,
  `member_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`member_data`)),
  `fees_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`fees_data`)),
  `payments_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`payments_data`)),
  `receipts_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`receipts_data`)),
  `deleted_by` varchar(20) NOT NULL,
  `deletion_date` timestamp NOT NULL DEFAULT current_timestamp()
) ;

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
('2024-09234', 100, 'INTEL FEE', '1st Semester', '2022-2023', 'Paid'),
('2024-09234', 100, 'INTEL FEE', '2nd Semester', '2022-2023', 'Paid'),
('2024-09234', 100, 'INTEL FEE', '1st Semester', '2023-2024', 'Paid'),
('2024-09234', 100, 'INTEL FEE', '2nd Semester', '2023-2024', 'Paid'),
('2024-09234', 100, 'INTEL FEE', '1st Semester', '2025-2026', 'Paid'),
('2024-09234', 100, 'INTEL FEE', '1st Semester', '2024-2025', 'Paid'),
('2025-65423', 100, 'INTEL FEE', '1st semester', '2025-2026', 'Unpaid'),
('2025-09457', 100, 'INTEL FEE', '2nd semester', '2025-2026', 'Unpaid'),
('2023-11112', 100, 'INTEL FEE', '1st semester', '2025-2026', 'Unpaid'),
('2023-11112', 100, 'INTEL FEE', '1st Semester', '2024-2025', 'Unpaid'),
('2025-09457', 100, 'INTEL FEE', '1st Semester', '2024-2025', 'Unpaid'),
('2025-65423', 100, 'INTEL FEE', '1st Semester', '2024-2025', 'Unpaid'),
('2025-09457', 100, 'INTEL FEE', '1st Semester', '2025-2026', 'Unpaid'),
('2023-11112', 100, 'INTEL FEE', '1st Semester', '2023-2024', 'Unpaid'),
('2025-09457', 100, 'INTEL FEE', '1st Semester', '2023-2024', 'Unpaid'),
('2025-65423', 100, 'INTEL FEE', '1st Semester', '2023-2024', 'Unpaid'),
('2025-77643', 100, 'INTEL FEE', '1st semester', '2025-2026', 'Unpaid'),
('2025-77643', 100, 'INTEL FEE', '1st Semester', '2024-2025', 'Unpaid'),
('2025-77643', 100, 'INTEL FEE', '1st Semester', '2023-2024', 'Unpaid');

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
('2023-11112', 'Lim', 'Adrian', 'Ty', '9216579012', 'adrian@gmail.com', 'Inactive', '2025-04-24 16:00:01'),
('2023-11780', 'Narbonita', 'Leonice', 'Poblete', '09123456789', 'leonice.narbonita@evsu.edu.ph', 'Active', '2025-04-04 09:57:57'),
('2024-09234', 'Lopez', 'Sean Oliver', '', '09542739182', 'seanoliver.lopez@evsu.edu.ph', 'Active', '2025-04-12 19:04:59'),
('2024-19243', 'Busante', 'Jonah May', 'Nalnalucab', '09452317865', 'jonahmay.busante@evsu.edu.ph', 'Active', '2025-04-04 13:57:22'),
('2025-09457', 'Coricor', 'Kent', 'Roberts', '9446889121', 'coricor.robert@evsu.edu.ph', 'Inactive', '2025-04-24 16:00:01'),
('2025-65423', 'Edloy', 'Tricia', '', '9541256970', 'tricia@evsu.edu.ph', 'Inactive', '2025-04-24 16:00:01'),
('2025-77643', 'Beros', 'Andreia', 'Cainong', '9662349082', 'beros.andreia@evsu.edu.ph', 'Inactive', '2025-04-24 16:00:01');

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
  `fee_type` varchar(20) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `semester` varchar(50) NOT NULL,
  `school_year` varchar(20) NOT NULL,
  `payment_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`payment_id`, `member_id`, `fee_type`, `amount`, `semester`, `school_year`, `payment_date`) VALUES
(33, '2023-10982', 'INTEL FEE', 100.00, '1st Semester', '2024-2025', '2025-04-07 02:18:31'),
(34, '2023-10982', 'INTEL FEE', 100.00, '2nd Semester', '2024-2025', '2025-04-07 02:33:11'),
(35, '2023-10982', 'INTEL FEE', 100.00, '1st Semester', '2023-2024', '2025-04-07 02:35:17'),
(36, '2023-04321', 'INTEL FEE', 100.00, '1st Semester', '2023-2024', '2025-04-07 02:49:36'),
(37, '2023-04321', 'INTEL FEE', 100.00, '1st Semester', '2024-2025', '2025-04-07 02:50:14'),
(38, '2023-04321', 'INTEL FEE', 100.00, '2nd Semester', '2024-2025', '2025-04-07 02:51:28'),
(39, '2023-04321', 'INTEL FEE', 100.00, '1st Semester', '2022-2023', '2025-04-07 02:54:59'),
(40, '2023-04321', 'INTEL FEE', 100.00, '2nd Semester', '2022-2023', '2025-04-07 02:55:50'),
(41, '2023-11780', 'INTEL FEE', 100.00, '1st Semester', '2023-2024', '2025-04-07 03:04:09'),
(42, '2023-11780', 'INTEL FEE', 100.00, '1st Semester', '2024-2025', '2025-04-07 03:23:31'),
(43, '2023-11780', 'INTEL FEE', 100.00, '2nd Semester', '2023-2024', '2025-04-07 03:23:32'),
(44, '2024-19243', 'INTEL FEE', 100.00, '1st Semester', '2024-2025', '2025-04-07 04:12:32'),
(45, '2024-19243', 'INTEL FEE', 100.00, '1st Semester', '2023-2024', '2025-04-07 04:12:32'),
(46, '2024-19243', 'INTEL FEE', 100.00, '2nd Semester', '2022-2023', '2025-04-07 04:12:32'),
(51, '2023-11780', 'INTEL FEE', 100.00, '2nd Semester', '2022-2023', '2025-04-07 07:43:02'),
(52, '2023-11780', 'INTEL FEE', 100.00, '2nd Semester', '2024-2025', '2025-04-07 07:51:09'),
(53, '2023-10982', 'INTEL FEE', 100.00, '2nd Semester', '2022-2023', '2025-04-07 08:06:06'),
(54, '2023-10982', 'INTEL FEE', 100.00, '1st Semester', '2024-2025', '2025-04-07 08:06:06'),
(57, '2023-11780', 'INTEL FEE', 100.00, '1st Semester', '2022-2023', '2025-04-07 08:23:11'),
(60, '2023-11780', 'INTEL FEE', 100.00, '1st Semester', '2022-2023', '2025-04-07 13:13:31'),
(61, '2023-11780', 'INTEL FEE', 100.00, '1st Semester', '2024-2025', '2025-04-07 13:13:31'),
(114, '2024-09234', 'INTEL FEE', 100.00, '1st Semester', '2022-2023', '2025-04-22 12:55:31'),
(115, '2024-09234', 'INTEL FEE', 100.00, '2nd Semester', '2022-2023', '2025-04-22 12:55:31');

-- --------------------------------------------------------

--
-- Table structure for table `receipts`
--

CREATE TABLE `receipts` (
  `receipt_id` varchar(20) NOT NULL,
  `payment_id` int(11) NOT NULL,
  `member_id` varchar(20) NOT NULL,
  `officer_id` varchar(20) NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `receipt_date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `receipts`
--

INSERT INTO `receipts` (`receipt_id`, `payment_id`, `member_id`, `officer_id`, `total_amount`, `receipt_date`) VALUES
('RCPT67f2df9f816f3', 43, '2023-11780', 'intel_pres', 100.00, '2025-04-07 04:10:07'),
('RCPT67f2e03f7282a', 44, '2024-19243', 'intel_pres', 100.00, '2025-04-07 04:12:47'),
('RCPT67f2e052bd0cf', 45, '2024-19243', 'intel_pres', 100.00, '2025-04-07 04:13:06'),
('RCPT67f311aac320a', 51, '2023-11780', 'intel_pres', 100.00, '2025-04-07 07:43:38'),
('RCPT67f3165fd977e', 52, '2023-11780', 'intel_pres', 100.00, '2025-04-07 08:03:43'),
('RCPT67f35faabe3ff', 53, '2023-10982', 'intel_pres', 100.00, '2025-04-07 13:16:26');

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
  MODIFY `log_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1014;

--
-- AUTO_INCREMENT for table `deleted_members`
--
ALTER TABLE `deleted_members`
  MODIFY `deletion_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `payment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=117;

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
