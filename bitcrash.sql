/*
Navicat MySQL Data Transfer

Source Server         : 127.0.0.1_3306
Source Server Version : 50611
Source Host           : 127.0.0.1:3306
Source Database       : bitcrash

Target Server Type    : MYSQL
Target Server Version : 50611
File Encoding         : 65001

Date: 2019-12-06 14:55:24
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for action_history
-- ----------------------------
DROP TABLE IF EXISTS `action_history`;
CREATE TABLE `action_history` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `IPADDRESS` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `USERID` bigint(20) DEFAULT NULL,
  `ACTION_TYPE` varchar(30) COLLATE utf8_unicode_ci DEFAULT 'general',
  `ACTION` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `CREATE_TIME` int(11) DEFAULT NULL,
  `UPDATE_TIME` int(11) DEFAULT NULL,
  `DEL_YN` char(1) COLLATE utf8_unicode_ci DEFAULT 'N',
  `USER_TYPE` tinyint(2) NOT NULL DEFAULT '1' COMMENT '1: user\r\n	2: admin',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of action_history
-- ----------------------------

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `LEVEL` tinyint(2) DEFAULT '2' COMMENT '1: admin\r\n	2: web-master\r\n	',
  `CREATE_TIME` int(11) DEFAULT NULL,
  `UPDATE_TIME` int(11) DEFAULT NULL,
  `USERNAME` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `PASSWORD` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `DEL_YN` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `EMAIL` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `GOOGLE_2FA_KEY` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `GOOGLE_2FA_STATUS` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `IPADDRESS` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `WALLET` decimal(20,2) DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('1', '1', '1362860081', '1362860081', 'admin', '912ec803b2ce49e4a541068d495ab570', 'N', null, null, null, '0.0.0.0', '208860.00');

-- ----------------------------
-- Table structure for chats
-- ----------------------------
DROP TABLE IF EXISTS `chats`;
CREATE TABLE `chats` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `CHAT_TYPE` varchar(25) COLLATE utf8_unicode_ci NOT NULL,
  `CREATE_TIME` datetime DEFAULT NULL,
  `UPDATE_TIME` datetime DEFAULT NULL,
  `MSG` text COLLATE utf8_unicode_ci,
  `IPADDRESS` varchar(24) COLLATE utf8_unicode_ci DEFAULT '0.0.0.0',
  `DEL_YN` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `USERID` bigint(20) DEFAULT NULL,
  `CHANNEL` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'ENG',
  PRIMARY KEY (`ID`) USING BTREE,
  KEY `FK_USERS_TO_CHATS` (`USERID`) USING BTREE,
  CONSTRAINT `FK_USERS_TO_CHATS` FOREIGN KEY (`USERID`) REFERENCES `users` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of chats
-- ----------------------------

-- ----------------------------
-- Table structure for crash_game_bot
-- ----------------------------
DROP TABLE IF EXISTS `crash_game_bot`;
CREATE TABLE `crash_game_bot` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ENABLE` enum('0','1') COLLATE utf8_bin DEFAULT '0',
  `F_ID` varchar(128) COLLATE utf8_bin DEFAULT NULL,
  `BASE_VALUE` double(20,4) DEFAULT NULL,
  `BUST_FROM` double DEFAULT NULL,
  `BUST_TO` double DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_bin ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of crash_game_bot
-- ----------------------------
INSERT INTO `crash_game_bot` VALUES ('1', '1', 'Kevin De Bruyner', '1000.0000', '1.2', '3.22');
INSERT INTO `crash_game_bot` VALUES ('2', '0', 'Andrey Cock', '1000.0000', '1.23', '3.44');
INSERT INTO `crash_game_bot` VALUES ('3', '1', 'Lehmann', '2000.0000', '2.32', '100');
INSERT INTO `crash_game_bot` VALUES ('4', '0', 'Willian Babbule', '200.0000', '1.11', '1.11');

-- ----------------------------
-- Table structure for crash_game_log
-- ----------------------------
DROP TABLE IF EXISTS `crash_game_log`;
CREATE TABLE `crash_game_log` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `CREATE_TIME` int(11) DEFAULT NULL,
  `UPDATE_TIME` int(11) DEFAULT NULL,
  `BET_AMOUNT` decimal(20,2) DEFAULT NULL,
  `GAMENO` bigint(20) DEFAULT NULL,
  `USERID` bigint(20) DEFAULT NULL,
  `IS_BOT` enum('0','1') COLLATE utf8_unicode_ci DEFAULT NULL,
  `BET` double DEFAULT NULL,
  `CASHOUTRATE` double DEFAULT NULL,
  `CASHOUT` double DEFAULT NULL,
  `PROFIT` double DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE,
  KEY `FK_ROULETTE_GAME_TO_ROULETTE_GAME_LOG` (`GAMENO`) USING BTREE,
  KEY `FK_USERS_TO_ROULETTE_GAME_LOG` (`USERID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of crash_game_log
-- ----------------------------

-- ----------------------------
-- Table structure for crash_game_profit
-- ----------------------------
DROP TABLE IF EXISTS `crash_game_profit`;
CREATE TABLE `crash_game_profit` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `REGTIME` datetime DEFAULT NULL,
  `UPDATETIME` datetime DEFAULT NULL,
  `ISDELETE` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `FROM` double(20,2) DEFAULT NULL,
  `TO` double(20,2) DEFAULT NULL,
  `PERCENT` double(20,4) unsigned DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of crash_game_profit
-- ----------------------------

-- ----------------------------
-- Table structure for crash_game_setting
-- ----------------------------
DROP TABLE IF EXISTS `crash_game_setting`;
CREATE TABLE `crash_game_setting` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `REGTIME` datetime DEFAULT NULL,
  `UPDATETIME` datetime DEFAULT NULL,
  `ISDELETE` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `PROFIT_RATE` int(10) unsigned DEFAULT NULL,
  `MIN_BET` double(20,0) unsigned DEFAULT NULL,
  `MAX_BET` double(20,0) DEFAULT NULL,
  `SERVER_ADDR` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `API_KEY` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `SERVER_IP_ADDR` varchar(64) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of crash_game_setting
-- ----------------------------
INSERT INTO `crash_game_setting` VALUES ('1', '2018-06-09 07:50:31', '2018-06-12 03:19:57', '0', '5', '1000', '5000', '127.0.0.1', 'JUX6G37E5T0C4OTOE8Z03C6ZQYXFKDCWYGMI7DN7', '127.0.0.1');

-- ----------------------------
-- Table structure for crash_game_total
-- ----------------------------
DROP TABLE IF EXISTS `crash_game_total`;
CREATE TABLE `crash_game_total` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `REGTIME` datetime DEFAULT NULL,
  `UPDATETIME` datetime DEFAULT NULL,
  `GAMENO` int(10) unsigned DEFAULT NULL,
  `STARTTIME` datetime DEFAULT NULL,
  `BUSTEDTIME` datetime DEFAULT NULL,
  `BUST` double(20,2) unsigned DEFAULT '0.00',
  `TOTAL` double(20,4) unsigned DEFAULT '0.0000',
  `PROFIT` double(20,4) DEFAULT '0.0000',
  `USERS` int(10) unsigned DEFAULT '0',
  `BOTS` int(10) unsigned DEFAULT '0',
  `HASH` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `ISDELETE` enum('0','1') COLLATE utf8_unicode_ci DEFAULT '0',
  `STATE` enum('WAITING','STARTED','BUSTED') COLLATE utf8_unicode_ci DEFAULT 'WAITING',
  `CREATE_TIME` int(12) DEFAULT NULL,
  `UPDATE_TIME` int(12) DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of crash_game_total
-- ----------------------------

-- ----------------------------
-- Table structure for cron
-- ----------------------------
DROP TABLE IF EXISTS `cron`;
CREATE TABLE `cron` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `CREATE_TIME` int(12) DEFAULT NULL,
  `DATE` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cron
-- ----------------------------

-- ----------------------------
-- Table structure for queue
-- ----------------------------
DROP TABLE IF EXISTS `queue`;
CREATE TABLE `queue` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `CREATE_TIME` int(12) DEFAULT NULL,
  `UPDATE_TIME` int(12) DEFAULT NULL,
  `TYPE` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'roulette\r\n	crash\r\n	jackpot\r\n	ladder\r\n	',
  `ACTION` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `PARAM` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `USERID` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE,
  KEY `FK_USERS_TO_QUEUE` (`USERID`) USING BTREE,
  CONSTRAINT `FK_USERS_TO_QUEUE` FOREIGN KEY (`USERID`) REFERENCES `users` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of queue
-- ----------------------------

-- ----------------------------
-- Table structure for queue_backup
-- ----------------------------
DROP TABLE IF EXISTS `queue_backup`;
CREATE TABLE `queue_backup` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `CREATE_TIME` int(12) DEFAULT NULL,
  `UPDATE_TIME` int(12) DEFAULT NULL,
  `TYPE` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ACTION` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `PARAM` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `USERID` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE,
  KEY `FK_USERS_TO_QUEUE_BACKUP` (`USERID`) USING BTREE,
  CONSTRAINT `FK_USERS_TO_QUEUE_BACKUP` FOREIGN KEY (`USERID`) REFERENCES `users` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of queue_backup
-- ----------------------------

-- ----------------------------
-- Table structure for sns_user
-- ----------------------------
DROP TABLE IF EXISTS `sns_user`;
CREATE TABLE `sns_user` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `SNS_TYPE` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `SNS_USERID` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `SNS_USERNAME` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `SNS_EMAIL` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `USERID` bigint(20) DEFAULT NULL,
  `AVATAR` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `PROVIDER_USERID` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'This is unique id that sns provides platform.\r\n	',
  `CREATE_TIME` int(11) DEFAULT NULL,
  `UPDATE_TIME` int(11) DEFAULT NULL,
  `DEL_YN` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  PRIMARY KEY (`ID`) USING BTREE,
  UNIQUE KEY `UIX_SNS_USER` (`SNS_TYPE`,`USERID`,`PROVIDER_USERID`) USING BTREE,
  KEY `FK_USERS_TO_SNS_USER` (`USERID`) USING BTREE,
  CONSTRAINT `FK_USERS_TO_SNS_USER` FOREIGN KEY (`USERID`) REFERENCES `users` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of sns_user
-- ----------------------------

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `USERNAME` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `PASSWORD` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `EMAIL` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `CREATE_TIME` int(11) DEFAULT NULL,
  `UPDATE_TIME` int(11) DEFAULT NULL,
  `DEL_YN` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `IPADDRESS` varchar(50) COLLATE utf8_unicode_ci DEFAULT '0.0.0.0',
  `EMAIL_VERIFIED_YN` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `STATE` int(3) NOT NULL DEFAULT '0' COMMENT '0: active\r\n	1: stop\r\n	2: block\r\n	',
  `COUNTRY` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `AVATAR` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `AVATAR_SMALL` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `AVATAR_MEDIUM` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `SNS_USER_YN` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `M_TOKEN` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `USER_LEVEL` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `LAST_IPADDRESS` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `WALLET` decimal(20,2) DEFAULT '0.00',
  `API_TOKEN` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `WALLET_BLOCK` decimal(20,2) DEFAULT '0.00',
  `WALLET_AVAILABLE` decimal(20,2) DEFAULT '0.00',
  PRIMARY KEY (`ID`) USING BTREE,
  UNIQUE KEY `UIX_USERS` (`USERNAME`,`EMAIL`,`ID`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('1', 'Test Account', 'b59c67bf196a4758191e42f76670ceba', 'test@test.com', null, '1558829905', 'N', '0.0.0.0', 'Y', '0', null, '', 'http://localhost:7900/assets/user/images/avatar/profile.png', 'http://localhost:7900/assets/user/images/avatar/profile1.png', 'N', null, 'LEVEL1', '::1', '2237740.00', 'tB3A2H0NA1hpcNKpsJJeu44S', '183515.00', '2054225.00');
INSERT INTO `users` VALUES ('2', 'Michale Jackson', 'b59c67bf196a4758191e42f76670ceba', 'Michale@test.com', null, null, 'N', '0.0.0.0', 'N', '0', null, null, 'http://localhost:7900/assets/user/images/avatar/img6.jpg', 'http://localhost:7900/assets/user/images/avatar/img6.jpg', 'N', null, 'LEVEL1', '::1', '1099440.00', 'EIG1dndwHsw7bbsMgglY2V1E', '-74024.00', '1173464.00');
SET FOREIGN_KEY_CHECKS=1;
