-- phpMyAdmin SQL Dump
-- version 4.5.4.1deb2ubuntu2.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Dec 21, 2019 at 11:41 AM
-- Server version: 5.7.25-0ubuntu0.16.04.2
-- PHP Version: 7.0.33-0ubuntu0.16.04.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bitcrash`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `ID` bigint(20) NOT NULL,
  `CREATE_TIME` int(11) DEFAULT NULL,
  `UPDATE_TIME` int(11) DEFAULT NULL,
  `USERNAME` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `PASSWORD` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `DEL_YN` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `EMAIL` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `IPADDRESS` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `WALLET` decimal(20,2) DEFAULT NULL,
  `TOKEN` varchar(255) CHARACTER SET utf8 DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`ID`, `CREATE_TIME`, `UPDATE_TIME`, `USERNAME`, `PASSWORD`, `DEL_YN`, `EMAIL`, `IPADDRESS`, `WALLET`, `TOKEN`) VALUES
(1, NULL, NULL, 'admin', 'b59c67bf196a4758191e42f76670ceba', 'N', 'admin@support.com', '0.0.0.0', '208860.00', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `chats`
--

CREATE TABLE `chats` (
  `ID` bigint(20) NOT NULL,
  `CHAT_TYPE` varchar(25) COLLATE utf8_unicode_ci NOT NULL,
  `CREATE_TIME` int(11) DEFAULT NULL,
  `UPDATE_TIME` int(11) DEFAULT NULL,
  `MSG` text COLLATE utf8_unicode_ci,
  `IPADDRESS` varchar(24) COLLATE utf8_unicode_ci DEFAULT '0.0.0.0',
  `DEL_YN` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `USERID` bigint(20) DEFAULT NULL,
  `CHANNEL` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'ENG'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT;

--
-- Dumping data for table `chats`
--

INSERT INTO `chats` (`ID`, `CHAT_TYPE`, `CREATE_TIME`, `UPDATE_TIME`, `MSG`, `IPADDRESS`, `DEL_YN`, `USERID`, `CHANNEL`) VALUES
(54, 'crash_chat', 1576911329, 1576911329, 'Hi  , every one. this is chat test.', '0.0.0.0', 'N', 1, 'ENG'),
(55, 'crash_chat', 1576911354, 1576911354, 'Please check chat feature. Can you check now?', '0.0.0.0', 'N', 1, 'ENG'),
(56, 'crash_chat', 1576926711, 1576926711, 'I am a new user', '0.0.0.0', 'N', 19, 'ENG'),
(57, 'crash_chat', 1576926726, 1576926726, 'Please play crash game with me. Thanks', '0.0.0.0', 'N', 19, 'ENG'),
(58, 'crash_chat', 1576926814, 1576926814, 'How can I play this game???', '0.0.0.0', 'N', 19, 'ENG');

-- --------------------------------------------------------

--
-- Table structure for table `crash_game_bot`
--

CREATE TABLE `crash_game_bot` (
  `ID` int(11) NOT NULL,
  `ENABLE` enum('0','1') COLLATE utf8_bin DEFAULT '0',
  `F_ID` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `BASE_VALUE` double(20,4) DEFAULT NULL,
  `BUST_FROM` double DEFAULT NULL,
  `BUST_TO` double DEFAULT NULL,
  `deleted` tinyint(4) DEFAULT '0' COMMENT '1: Deleted'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=COMPACT;

--
-- Dumping data for table `crash_game_bot`
--

INSERT INTO `crash_game_bot` (`ID`, `ENABLE`, `F_ID`, `BASE_VALUE`, `BUST_FROM`, `BUST_TO`, `deleted`) VALUES
(1, '1', 'Kevin De Bruyner', 1000.0000, 1.2, 3.22, 0),
(2, '1', 'Andrey Cock', 1000.0000, 1.23, 3.44, 0),
(3, '1', 'Lehmann', 2000.0000, 2.32, 100, 0),
(4, '0', 'Willian Babbule', 200.0000, 1.11, 1.11, 0),
(5, '1', 'Kingston', 1200.0000, 1.5, 9.99, 0),
(6, '1', 'Nickon', 2200.0000, 3.9, 11.5, 0),
(7, '1', 'Garry Tayler', 600.0000, 2.6, 5.8, 0),
(8, '1', 'Telecom Sam', 2800.0000, 1.5, 5.6, 0),
(9, '1', 'Sales Force', 1500.0000, 4.3, 7.9, 0),
(10, '1', 'Kiash', 1700.0000, 1.5, 3.8, 0),
(11, '1', 'Sanele', 2000.0000, 1.3, 5.4, 0);

-- --------------------------------------------------------

--
-- Table structure for table `crash_game_hashes`
--

CREATE TABLE `crash_game_hashes` (
  `ID` bigint(20) DEFAULT NULL,
  `GAME_ID` bigint(20) DEFAULT NULL,
  `HASH` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `crash_game_log`
--

CREATE TABLE `crash_game_log` (
  `ID` bigint(20) NOT NULL,
  `CREATE_TIME` int(11) DEFAULT NULL,
  `UPDATE_TIME` int(11) DEFAULT NULL,
  `BET_AMOUNT` decimal(20,2) DEFAULT NULL,
  `GAMENO` bigint(20) DEFAULT NULL,
  `USERID` bigint(20) DEFAULT NULL,
  `IS_BOT` tinyint(4) DEFAULT '1',
  `BET` int(12) DEFAULT NULL,
  `CASHOUTRATE` double DEFAULT NULL,
  `CASHOUT` int(11) DEFAULT NULL,
  `PROFIT` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `crash_game_total`
--

CREATE TABLE `crash_game_total` (
  `ID` bigint(20) UNSIGNED NOT NULL,
  `REGTIME` timestamp NULL DEFAULT NULL,
  `UPDATETIME` timestamp NULL DEFAULT NULL,
  `GAMENO` int(10) UNSIGNED DEFAULT NULL,
  `STARTTIME` int(11) DEFAULT NULL,
  `BUSTEDTIME` int(11) DEFAULT NULL,
  `BUST` double(20,2) UNSIGNED DEFAULT '0.00',
  `TOTAL` int(12) UNSIGNED DEFAULT '0',
  `PROFIT` int(12) DEFAULT '0',
  `USERS` int(10) UNSIGNED DEFAULT '0',
  `BOTS` int(10) UNSIGNED DEFAULT '0',
  `HASH` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `ISDELETE` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `STATE` enum('WAITING','STARTED','BUSTED') COLLATE utf8_unicode_ci DEFAULT 'WAITING',
  `CREATE_TIME` int(11) DEFAULT NULL,
  `UPDATE_TIME` int(11) DEFAULT NULL,
  `TOTAL_REAL` int(12) DEFAULT NULL COMMENT '//except bot amount'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `cron`
--

CREATE TABLE `cron` (
  `ID` bigint(20) UNSIGNED NOT NULL,
  `CREATE_TIME` int(12) DEFAULT NULL,
  `DATE` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `faq`
--

CREATE TABLE `faq` (
  `id` int(10) UNSIGNED NOT NULL,
  `create_time` int(12) DEFAULT NULL,
  `type` tinyint(4) DEFAULT '0' COMMENT '0: GettingStarted, 1: Payment',
  `answer` varchar(255) DEFAULT NULL,
  `question` varchar(255) DEFAULT NULL,
  `deleted` tinyint(4) DEFAULT '0' COMMENT '1: Deleted',
  `update_time` int(12) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `ID` bigint(20) NOT NULL,
  `USERNAME` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `PASSWORD` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `EMAIL` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `CREATE_TIME` timestamp NULL DEFAULT NULL,
  `UPDATE_TIME` timestamp NULL DEFAULT NULL,
  `DEL_YN` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `IPADDRESS` varchar(50) COLLATE utf8_unicode_ci DEFAULT '0.0.0.0',
  `EMAIL_VERIFIED_YN` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `STATE` int(3) NOT NULL DEFAULT '0' COMMENT '0: active\r\n	1: stop\r\n	2: block\r\n	',
  `AVATAR` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `LAST_IPADDRESS` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `WALLET` int(12) DEFAULT '0',
  `API_TOKEN` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `WALLET_BLOCK` int(12) DEFAULT '0',
  `WALLET_AVAILABLE` int(12) DEFAULT '0',
  `LAST_VISIT` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`ID`, `USERNAME`, `PASSWORD`, `EMAIL`, `CREATE_TIME`, `UPDATE_TIME`, `DEL_YN`, `IPADDRESS`, `EMAIL_VERIFIED_YN`, `STATE`, `AVATAR`, `LAST_IPADDRESS`, `WALLET`, `API_TOKEN`, `WALLET_BLOCK`, `WALLET_AVAILABLE`, `LAST_VISIT`) VALUES
(1, 'Test Account', '912ec803b2ce49e4a541068d495ab570', 'test@test.com', '2019-12-12 11:28:38', NULL, 'N', '0.0.0.0', 'Y', 0, 'http://45.76.180.140:7801/img/uploads/avatar/avatar-medium.png', '::1', 100000, 'tB3A2H0NA1hpcNKpsJJeu44S', 0, 100000, NULL),
(19, 'bituser', '912ec803b2ce49e4a541068d495ab570', 'bituser@gmail.com', '2019-12-21 11:10:36', NULL, 'N', '0.0.0.0', 'N', 0, 'http://45.76.180.140:7801/img/uploads/avatar/general_profile.png', NULL, 0, 'oNwwO1kGn78eAT0qpYRXXbioY', 0, 0, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`ID`) USING BTREE;

--
-- Indexes for table `chats`
--
ALTER TABLE `chats`
  ADD PRIMARY KEY (`ID`) USING BTREE,
  ADD KEY `FK_USERS_TO_CHATS` (`USERID`) USING BTREE;

--
-- Indexes for table `crash_game_bot`
--
ALTER TABLE `crash_game_bot`
  ADD PRIMARY KEY (`ID`) USING BTREE;

--
-- Indexes for table `crash_game_log`
--
ALTER TABLE `crash_game_log`
  ADD PRIMARY KEY (`ID`) USING BTREE,
  ADD KEY `FK_ROULETTE_GAME_TO_ROULETTE_GAME_LOG` (`GAMENO`) USING BTREE,
  ADD KEY `FK_USERS_TO_ROULETTE_GAME_LOG` (`USERID`) USING BTREE;

--
-- Indexes for table `crash_game_total`
--
ALTER TABLE `crash_game_total`
  ADD PRIMARY KEY (`ID`) USING BTREE;

--
-- Indexes for table `cron`
--
ALTER TABLE `cron`
  ADD PRIMARY KEY (`ID`) USING BTREE;

--
-- Indexes for table `faq`
--
ALTER TABLE `faq`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`ID`) USING BTREE,
  ADD UNIQUE KEY `UIX_USERS` (`USERNAME`,`EMAIL`,`ID`) USING BTREE;

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `ID` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `chats`
--
ALTER TABLE `chats`
  MODIFY `ID` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;
--
-- AUTO_INCREMENT for table `crash_game_bot`
--
ALTER TABLE `crash_game_bot`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
--
-- AUTO_INCREMENT for table `crash_game_log`
--
ALTER TABLE `crash_game_log`
  MODIFY `ID` bigint(20) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `crash_game_total`
--
ALTER TABLE `crash_game_total`
  MODIFY `ID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `cron`
--
ALTER TABLE `cron`
  MODIFY `ID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `faq`
--
ALTER TABLE `faq`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `ID` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `chats`
--
ALTER TABLE `chats`
  ADD CONSTRAINT `FK_USERS_TO_CHATS` FOREIGN KEY (`USERID`) REFERENCES `users` (`ID`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
