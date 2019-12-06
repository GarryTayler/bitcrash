/*
Navicat MySQL Data Transfer

Source Server         : 127.0.0.1_3306
Source Server Version : 50611
Source Host           : 127.0.0.1:3306
Source Database       : bitcrash

Target Server Type    : MYSQL
Target Server Version : 50611
File Encoding         : 65001

Date: 2019-12-04 19:38:29
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
  `CREATE_TIME` int(12) NOT NULL,
  `UPDATE_TIME` int(12) NOT NULL,
  `MSG` text COLLATE utf8_unicode_ci,
  `IPADDRESS` varchar(24) COLLATE utf8_unicode_ci DEFAULT '0.0.0.0',
  `DEL_YN` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `USERID` bigint(20) DEFAULT NULL,
  `CHANNEL` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'ENG',
  PRIMARY KEY (`ID`) USING BTREE,
  KEY `FK_USERS_TO_CHATS` (`USERID`) USING BTREE,
  CONSTRAINT `FK_USERS_TO_CHATS` FOREIGN KEY (`USERID`) REFERENCES `users` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of chats
-- ----------------------------
INSERT INTO `chats` VALUES ('1', 'crash', '1575343393', '1575343393', 'qweqwe\n', '::1', 'N', '1', 'ENG');

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
) ENGINE=InnoDB AUTO_INCREMENT=883 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of crash_game_log
-- ----------------------------
INSERT INTO `crash_game_log` VALUES ('1', '2019', null, '1000.00', '1', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('2', '2019', null, '2000.00', '1', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('3', '2019', null, '1000.00', '2', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('4', '2019', null, '2000.00', '2', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('5', '2019', null, '1000.00', '3', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('6', '2019', null, '2000.00', '3', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('7', '2019', null, '1000.00', '4', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('8', '2019', null, '2000.00', '4', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('9', '2019', null, '1000.00', '5', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('10', '2019', null, '2000.00', '5', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('11', '2019', null, '1000.00', '6', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('12', '2019', null, '2000.00', '6', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('13', '2019', null, '1000.00', '7', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('14', '2019', null, '2000.00', '7', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('15', '2019', null, '1000.00', '8', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('16', '2019', null, '2000.00', '8', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('17', '2019', null, '1000.00', '9', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('18', '2019', null, '2000.00', '9', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('19', '2019', null, '1000.00', '10', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('20', '2019', null, '2000.00', '10', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('21', '2019', null, '1000.00', '11', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('22', '2019', null, '2000.00', '11', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('23', '2019', null, '1000.00', '12', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('24', '2019', null, '2000.00', '12', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('25', '2019', null, '1000.00', '13', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('26', '2019', null, '2000.00', '13', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('27', '2019', null, '1000.00', '14', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('28', '2019', null, '2000.00', '14', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('29', '2019', null, '1000.00', '15', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('30', '2019', null, '2000.00', '15', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('31', '2019', null, '1000.00', '16', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('32', '2019', null, '2000.00', '16', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('33', '2019', null, '1000.00', '17', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('34', '2019', null, '2000.00', '17', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('35', '2019', null, '1000.00', '18', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('36', '2019', null, '2000.00', '18', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('37', '2019', null, '1000.00', '19', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('38', '2019', null, '2000.00', '19', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('39', '2019', null, '1000.00', '20', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('40', '2019', null, '2000.00', '20', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('41', '2019', null, '1000.00', '21', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('42', '2019', null, '2000.00', '21', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('43', '2019', null, '1000.00', '22', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('44', '2019', null, '2000.00', '22', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('45', '2019', null, '1000.00', '23', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('46', '2019', null, '2000.00', '23', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('47', '2019', null, '1000.00', '24', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('48', '2019', null, '2000.00', '24', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('49', '2019', null, '1000.00', '25', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('50', '2019', null, '2000.00', '25', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('51', '2019', null, '1000.00', '26', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('52', '2019', null, '2000.00', '26', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('53', '2019', null, '1000.00', '27', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('54', '2019', null, '2000.00', '27', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('55', '2019', null, '1000.00', '28', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('56', '2019', null, '2000.00', '28', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('57', '2019', null, '1000.00', '29', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('58', '2019', null, '2000.00', '29', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('59', '2019', null, '1000.00', '30', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('60', '2019', null, '2000.00', '30', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('61', '2019', null, '1000.00', '31', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('62', '2019', null, '2000.00', '31', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('63', '2019', null, '1000.00', '32', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('64', '2019', null, '2000.00', '32', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('65', '2019', null, '1000.00', '33', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('66', '2019', null, '2000.00', '33', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('67', '2019', null, '1000.00', '34', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('68', '2019', null, '2000.00', '34', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('69', '2019', null, '1000.00', '35', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('70', '2019', null, '2000.00', '35', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('71', '2019', null, '1000.00', '36', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('72', '2019', null, '2000.00', '36', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('73', '2019', null, '1000.00', '37', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('74', '2019', null, '2000.00', '37', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('75', '2019', null, '1000.00', '38', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('76', '2019', null, '2000.00', '38', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('77', '2019', null, '1000.00', '39', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('78', '2019', null, '2000.00', '39', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('79', '2019', null, '1000.00', '40', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('80', '2019', null, '2000.00', '40', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('81', '2019', null, '1000.00', '41', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('82', '2019', null, '2000.00', '41', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('83', '2019', null, '1000.00', '42', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('84', '2019', null, '2000.00', '42', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('85', '2019', null, '1000.00', '43', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('86', '2019', null, '2000.00', '43', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('87', '2019', null, '1000.00', '44', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('88', '2019', null, '2000.00', '44', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('89', '2019', null, '1000.00', '45', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('90', '2019', null, '2000.00', '45', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('91', '2019', null, '1000.00', '46', '1', '1', null, '0', null, null);
INSERT INTO `crash_game_log` VALUES ('92', '2019', null, '2000.00', '46', '3', '1', null, '0', null, null);
INSERT INTO `crash_game_log` VALUES ('93', '2019', null, '1000.00', '48', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('94', '2019', null, '2000.00', '48', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('95', '2019', null, '1000.00', '49', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('96', '2019', null, '2000.00', '49', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('97', '2019', null, '1000.00', '50', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('98', '2019', null, '2000.00', '50', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('99', '2019', null, '1000.00', '51', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('100', '2019', null, '2000.00', '51', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('101', '2019', null, '1000.00', '52', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('102', '2019', null, '2000.00', '52', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('103', '2019', null, '1000.00', '53', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('104', '2019', null, '2000.00', '53', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('105', '2019', null, '1000.00', '54', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('106', '2019', null, '2000.00', '54', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('107', '2019', null, '1000.00', '55', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('108', '2019', null, '2000.00', '55', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('109', '2019', null, '1000.00', '56', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('110', '2019', null, '2000.00', '56', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('111', '2019', null, '1000.00', '57', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('112', '2019', null, '2000.00', '57', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('113', '2019', null, '1000.00', '58', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('114', '2019', null, '2000.00', '58', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('115', '2019', null, '1000.00', '59', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('116', '2019', null, '2000.00', '59', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('117', '2019', null, '1000.00', '60', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('118', '2019', null, '2000.00', '60', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('119', '2019', null, '1000.00', '61', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('120', '2019', null, '2000.00', '61', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('121', '2019', null, '1000.00', '62', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('122', '2019', null, '2000.00', '62', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('123', '2019', null, '1000.00', '63', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('124', '2019', null, '2000.00', '63', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('125', '2019', null, '1000.00', '64', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('126', '2019', null, '2000.00', '64', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('127', '2019', null, '1000.00', '65', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('128', '2019', null, '2000.00', '65', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('129', '2019', null, '1000.00', '66', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('130', '2019', null, '2000.00', '66', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('131', '2019', null, '1000.00', '67', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('132', '2019', null, '2000.00', '67', '3', '1', null, '0', '0', '-2000');
INSERT INTO `crash_game_log` VALUES ('133', '2019', null, '1000.00', '68', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('134', '2019', null, '2000.00', '68', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('135', '2019', null, '1000.00', '69', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('136', '2019', null, '2000.00', '69', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('137', '2019', null, '1000.00', '70', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('138', '2019', null, '2000.00', '70', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('139', '2019', null, '1000.00', '72', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('140', '2019', null, '2000.00', '72', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('141', '2019', null, '1000.00', '73', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('142', '2019', null, '2000.00', '73', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('143', '2019', null, '1000.00', '74', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('144', '2019', null, '2000.00', '74', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('145', '2019', null, '1000.00', '75', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('146', '2019', null, '2000.00', '75', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('147', '2019', null, '1000.00', '76', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('148', '2019', null, '2000.00', '76', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('149', '2019', null, '1000.00', '77', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('150', '2019', null, '2000.00', '77', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('151', '2019', null, '1000.00', '78', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('152', '2019', null, '2000.00', '78', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('153', '2019', null, '1000.00', '79', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('154', '2019', null, '2000.00', '79', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('155', '2019', null, '1000.00', '80', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('156', '2019', null, '2000.00', '80', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('157', '2019', null, '1000.00', '81', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('158', '2019', null, '2000.00', '81', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('159', '2019', null, '1000.00', '82', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('160', '2019', null, '2000.00', '82', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('161', '2019', null, '1000.00', '83', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('162', '2019', null, '2000.00', '83', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('163', '2019', null, '1000.00', '84', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('164', '2019', null, '2000.00', '84', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('165', '2019', null, '1000.00', '85', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('166', '2019', null, '2000.00', '85', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('167', '2019', null, '1000.00', '86', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('168', '2019', null, '2000.00', '86', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('169', '2019', null, '1000.00', '87', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('170', '2019', null, '2000.00', '87', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('171', '2019', null, '1000.00', '88', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('172', '2019', null, '2000.00', '88', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('173', '2019', null, '1000.00', '89', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('174', '2019', null, '2000.00', '89', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('175', '2019', null, '1000.00', '90', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('176', '2019', null, '2000.00', '90', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('177', '2019', null, '1000.00', '91', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('178', '2019', null, '2000.00', '91', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('179', '2019', null, '1000.00', '92', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('180', '2019', null, '2000.00', '92', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('181', '2019', null, '1000.00', '93', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('182', '2019', null, '2000.00', '93', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('183', '2019', null, '1000.00', '94', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('184', '2019', null, '2000.00', '94', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('185', '2019', null, '1000.00', '95', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('186', '2019', null, '2000.00', '95', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('187', '2019', null, '1000.00', '96', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('188', '2019', null, '2000.00', '96', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('189', '2019', null, '1000.00', '97', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('190', '2019', null, '2000.00', '97', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('191', '2019', null, '1000.00', '98', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('192', '2019', null, '2000.00', '98', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('193', '2019', null, '1000.00', '99', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('194', '2019', null, '2000.00', '99', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('195', '2019', null, '1000.00', '100', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('196', '2019', null, '2000.00', '100', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('197', '2019', null, '1000.00', '101', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('198', '2019', null, '2000.00', '101', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('199', '2019', null, '1000.00', '102', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('200', '2019', null, '2000.00', '102', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('201', '2019', null, '1000.00', '103', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('202', '2019', null, '2000.00', '103', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('203', '2019', null, '1000.00', '104', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('204', '2019', null, '2000.00', '104', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('205', '2019', null, '1000.00', '105', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('206', '2019', null, '2000.00', '105', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('207', '2019', null, '1000.00', '106', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('208', '2019', null, '2000.00', '106', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('209', '2019', null, '2000.00', '107', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('210', '2019', null, '1000.00', '107', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('211', '2019', null, '1000.00', '108', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('212', '2019', null, '2000.00', '108', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('213', '2019', null, '1000.00', '109', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('214', '2019', null, '2000.00', '109', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('215', '2019', null, '1000.00', '110', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('216', '2019', null, '2000.00', '110', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('217', '2019', null, '1000.00', '111', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('218', '2019', null, '2000.00', '111', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('219', '2019', null, '1000.00', '112', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('220', '2019', null, '2000.00', '112', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('221', '2019', null, '1000.00', '113', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('222', '2019', null, '2000.00', '113', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('223', '2019', null, '1000.00', '114', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('224', '2019', null, '2000.00', '114', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('225', '2019', null, '1000.00', '115', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('226', '2019', null, '2000.00', '115', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('227', '2019', null, '1000.00', '116', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('228', '2019', null, '2000.00', '116', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('229', '2019', null, '1000.00', '117', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('230', '2019', null, '2000.00', '117', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('231', '2019', null, '1000.00', '118', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('232', '2019', null, '2000.00', '118', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('233', '2019', null, '1000.00', '119', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('234', '2019', null, '2000.00', '119', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('235', '2019', null, '1000.00', '120', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('236', '2019', null, '2000.00', '120', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('237', '2019', null, '1000.00', '121', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('238', '2019', null, '2000.00', '121', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('239', '2019', null, '1000.00', '122', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('240', '2019', null, '2000.00', '122', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('241', '2019', null, '1000.00', '123', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('242', '2019', null, '2000.00', '123', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('243', '2019', null, '11111.00', '124', '1', '0', null, '1.19', '13222.09', '2111.09');
INSERT INTO `crash_game_log` VALUES ('244', '2019', null, '1000.00', '124', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('245', '2019', null, '2000.00', '124', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('246', '2019', null, '11111.00', '125', '1', '0', null, '3.27', '36332.97', '25221.97');
INSERT INTO `crash_game_log` VALUES ('247', '2019', null, '1000.00', '125', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('248', '2019', null, '2000.00', '125', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('249', '2019', null, '1000.00', '126', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('250', '2019', null, '2000.00', '126', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('251', '2019', null, '1000.00', '127', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('252', '2019', null, '2000.00', '127', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('253', '2019', null, '1000.00', '128', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('254', '2019', null, '2000.00', '128', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('255', '2019', null, '1000.00', '129', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('256', '2019', null, '2000.00', '129', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('257', '2019', null, '1000.00', '130', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('258', '2019', null, '2000.00', '130', '3', '1', null, '0', '0', '-2000');
INSERT INTO `crash_game_log` VALUES ('259', '2019', null, '1000.00', '131', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('260', '2019', null, '2000.00', '131', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('261', '2019', null, '1000.00', '132', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('262', '2019', null, '2000.00', '132', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('263', '2019', null, '1000.00', '133', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('264', '2019', null, '2000.00', '133', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('265', '2019', null, '1000.00', '134', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('266', '2019', null, '2000.00', '134', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('267', '2019', null, '1000.00', '135', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('268', '2019', null, '2000.00', '135', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('269', '2019', null, '1000.00', '136', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('270', '2019', null, '2000.00', '136', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('271', '2019', null, '1000.00', '137', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('272', '2019', null, '2000.00', '137', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('273', '2019', null, '1000.00', '138', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('274', '2019', null, '2000.00', '138', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('275', '2019', null, '1000.00', '139', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('276', '2019', null, '2000.00', '139', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('277', '2019', null, '1000.00', '140', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('278', '2019', null, '2000.00', '140', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('279', '2019', null, '1000.00', '141', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('280', '2019', null, '2000.00', '141', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('281', '2019', null, '1000.00', '142', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('282', '2019', null, '2000.00', '142', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('283', '2019', null, '1000.00', '143', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('284', '2019', null, '2000.00', '143', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('285', '2019', null, '1000.00', '144', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('286', '2019', null, '2000.00', '144', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('287', '2019', null, '1000.00', '145', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('288', '2019', null, '2000.00', '145', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('289', '2019', null, '1000.00', '146', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('290', '2019', null, '2000.00', '146', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('291', '2019', null, '1000.00', '147', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('292', '2019', null, '2000.00', '147', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('293', '2019', null, '1000.00', '148', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('294', '2019', null, '2000.00', '148', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('295', '2019', null, '1000.00', '149', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('296', '2019', null, '2000.00', '149', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('297', '2019', null, '1000.00', '150', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('298', '2019', null, '2000.00', '150', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('299', '2019', null, '1000.00', '151', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('300', '2019', null, '2000.00', '151', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('301', '2019', null, '1000.00', '152', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('302', '2019', null, '2000.00', '152', '3', '1', null, '0', '0', '-2000');
INSERT INTO `crash_game_log` VALUES ('303', '2019', null, '1000.00', '153', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('304', '2019', null, '2000.00', '153', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('305', '2019', null, '1000.00', '154', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('306', '2019', null, '2000.00', '154', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('307', '2019', null, '1000.00', '155', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('308', '2019', null, '2000.00', '155', '3', '1', null, '0', '0', '-2000');
INSERT INTO `crash_game_log` VALUES ('309', '2019', null, '1000.00', '156', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('310', '2019', null, '2000.00', '156', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('311', '2019', null, '1000.00', '156', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('312', '2019', null, '2000.00', '156', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('313', '2019', null, '1000.00', '157', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('314', '2019', null, '2000.00', '157', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('315', '2019', null, '1000.00', '158', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('316', '2019', null, '2000.00', '158', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('317', '2019', null, '1000.00', '159', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('318', '2019', null, '2000.00', '159', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('319', '2019', null, '1000.00', '160', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('320', '2019', null, '2000.00', '160', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('321', '2019', null, '1000.00', '161', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('322', '2019', null, '2000.00', '161', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('323', '2019', null, '1000.00', '162', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('324', '2019', null, '2000.00', '162', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('325', '2019', null, '1000.00', '163', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('326', '2019', null, '2000.00', '163', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('327', '2019', null, '1000.00', '164', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('328', '2019', null, '2000.00', '164', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('329', '2019', null, '1000.00', '165', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('330', '2019', null, '2000.00', '165', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('331', '2019', null, '1000.00', '166', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('332', '2019', null, '2000.00', '166', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('333', '2019', null, '1000.00', '167', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('334', '2019', null, '2000.00', '167', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('335', '2019', null, '1000.00', '168', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('336', '2019', null, '2000.00', '168', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('337', '2019', null, '1000.00', '169', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('338', '2019', null, '2000.00', '169', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('339', '2019', null, '1000.00', '170', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('340', '2019', null, '2000.00', '170', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('341', '2019', null, '1000.00', '171', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('342', '2019', null, '2000.00', '171', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('343', '2019', null, '1000.00', '172', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('344', '2019', null, '2000.00', '172', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('345', '2019', null, '1000.00', '173', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('346', '2019', null, '2000.00', '173', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('347', '2019', null, '1000.00', '174', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('348', '2019', null, '2000.00', '174', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('349', '2019', null, '1000.00', '175', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('350', '2019', null, '2000.00', '175', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('351', '2019', null, '1000.00', '176', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('352', '2019', null, '2000.00', '176', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('353', '2019', null, '1000.00', '177', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('354', '2019', null, '2000.00', '177', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('355', '2019', null, '1000.00', '178', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('356', '2019', null, '2000.00', '178', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('357', '2019', null, '1000.00', '179', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('358', '2019', null, '2000.00', '179', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('359', '2019', null, '1000.00', '180', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('360', '2019', null, '2000.00', '180', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('361', '2019', null, '1000.00', '181', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('362', '2019', null, '2000.00', '181', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('363', '2019', null, '1000.00', '182', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('364', '2019', null, '2000.00', '182', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('365', '2019', null, '1000.00', '183', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('366', '2019', null, '2000.00', '183', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('367', '2019', null, '1000.00', '184', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('368', '2019', null, '2000.00', '184', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('369', '2019', null, '1000.00', '185', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('370', '2019', null, '2000.00', '185', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('371', '2019', null, '1000.00', '186', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('372', '2019', null, '2000.00', '186', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('373', '2019', null, '1000.00', '187', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('374', '2019', null, '2000.00', '187', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('375', '2019', null, '1000.00', '188', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('376', '2019', null, '2000.00', '188', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('377', '2019', null, '1000.00', '189', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('378', '2019', null, '2000.00', '189', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('379', '2019', null, '1000.00', '190', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('380', '2019', null, '2000.00', '190', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('381', '2019', null, '1000.00', '191', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('382', '2019', null, '2000.00', '191', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('383', '2019', null, '1000.00', '192', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('384', '2019', null, '2000.00', '192', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('385', '2019', null, '1000.00', '193', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('386', '2019', null, '2000.00', '193', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('387', '2019', null, '1000.00', '194', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('388', '2019', null, '2000.00', '194', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('389', '2019', null, '1000.00', '195', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('390', '2019', null, '2000.00', '195', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('391', '2019', null, '1000.00', '196', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('392', '2019', null, '2000.00', '196', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('393', '2019', null, '1000.00', '197', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('394', '2019', null, '2000.00', '197', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('395', '2019', null, '1000.00', '198', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('396', '2019', null, '2000.00', '198', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('397', '2019', null, '1000.00', '199', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('398', '2019', null, '2000.00', '199', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('399', '2019', null, '1000.00', '200', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('400', '2019', null, '2000.00', '200', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('401', '2019', null, '1000.00', '201', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('402', '2019', null, '2000.00', '201', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('403', '2019', null, '1000.00', '202', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('404', '2019', null, '2000.00', '202', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('405', '2019', null, '1000.00', '203', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('406', '2019', null, '2000.00', '203', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('407', '2019', null, '1000.00', '204', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('408', '2019', null, '2000.00', '204', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('409', '2019', null, '1000.00', '205', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('410', '2019', null, '2000.00', '205', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('411', '2019', null, '2000.00', '206', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('412', '2019', null, '1000.00', '206', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('413', '2019', null, '1000.00', '207', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('414', '2019', null, '2000.00', '207', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('415', '2019', null, '1000.00', '209', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('416', '2019', null, '2000.00', '209', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('417', '2019', null, '1000.00', '210', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('418', '2019', null, '2000.00', '210', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('419', '2019', null, '1000.00', '211', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('420', '2019', null, '2000.00', '211', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('421', '2019', null, '1000.00', '212', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('422', '2019', null, '2000.00', '212', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('423', '2019', null, '1000.00', '213', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('424', '2019', null, '2000.00', '213', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('425', '2019', null, '1000.00', '214', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('426', '2019', null, '2000.00', '214', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('427', '2019', null, '1000.00', '215', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('428', '2019', null, '2000.00', '215', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('429', '2019', null, '1000.00', '216', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('430', '2019', null, '2000.00', '216', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('431', '2019', null, '1000.00', '217', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('432', '2019', null, '2000.00', '217', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('433', '2019', null, '1000.00', '218', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('434', '2019', null, '2000.00', '218', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('435', '2019', null, '1000.00', '219', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('436', '2019', null, '2000.00', '219', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('437', '2019', null, '1000.00', '220', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('438', '2019', null, '2000.00', '220', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('439', '2019', null, '1000.00', '221', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('440', '2019', null, '2000.00', '221', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('441', '2019', null, '1000.00', '222', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('442', '2019', null, '2000.00', '222', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('443', '2019', null, '1000.00', '223', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('444', '2019', null, '2000.00', '223', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('445', '2019', null, '1000.00', '224', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('446', '2019', null, '2000.00', '224', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('447', '2019', null, '1000.00', '225', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('448', '2019', null, '2000.00', '225', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('449', '2019', null, '1000.00', '226', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('450', '2019', null, '2000.00', '226', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('451', '2019', null, '1000.00', '227', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('452', '2019', null, '2000.00', '227', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('453', '2019', null, '1000.00', '228', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('454', '2019', null, '2000.00', '228', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('455', '2019', null, '1000.00', '229', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('456', '2019', null, '2000.00', '229', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('457', '2019', null, '1000.00', '230', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('458', '2019', null, '2000.00', '230', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('459', '2019', null, '1000.00', '231', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('460', '2019', null, '2000.00', '231', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('461', '2019', null, '1000.00', '232', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('462', '2019', null, '2000.00', '232', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('463', '2019', null, '1000.00', '233', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('464', '2019', null, '2000.00', '233', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('465', '2019', null, '1000.00', '234', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('466', '2019', null, '2000.00', '234', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('467', '2019', null, '1000.00', '235', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('468', '2019', null, '2000.00', '235', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('469', '2019', null, '1000.00', '236', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('470', '2019', null, '2000.00', '236', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('471', '2019', null, '1000.00', '237', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('472', '2019', null, '2000.00', '237', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('473', '2019', null, '1000.00', '238', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('474', '2019', null, '2000.00', '238', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('475', '2019', null, '1000.00', '239', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('476', '2019', null, '2000.00', '239', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('477', '2019', null, '1000.00', '240', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('478', '2019', null, '2000.00', '240', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('479', '2019', null, '1000.00', '241', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('480', '2019', null, '2000.00', '241', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('481', '2019', null, '1000.00', '242', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('482', '2019', null, '2000.00', '242', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('483', '2019', null, '1000.00', '243', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('484', '2019', null, '2000.00', '243', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('485', '2019', null, '1000.00', '244', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('486', '2019', null, '2000.00', '244', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('487', '2019', null, '1000.00', '245', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('488', '2019', null, '2000.00', '245', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('489', '2019', null, '1000.00', '246', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('490', '2019', null, '2000.00', '246', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('491', '2019', null, '1000.00', '247', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('492', '2019', null, '2000.00', '247', '3', '1', null, '0', null, null);
INSERT INTO `crash_game_log` VALUES ('493', '2019', null, '1000.00', '248', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('494', '2019', null, '2000.00', '248', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('495', '2019', null, '1000.00', '249', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('496', '2019', null, '2000.00', '249', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('497', '2019', null, '1000.00', '250', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('498', '2019', null, '2000.00', '250', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('499', '2019', null, '1000.00', '251', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('500', '2019', null, '2000.00', '251', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('501', '2019', null, '1000.00', '252', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('502', '2019', null, '2000.00', '252', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('503', '2019', null, '1000.00', '253', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('504', '2019', null, '2000.00', '253', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('505', '2019', null, '1000.00', '254', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('506', '2019', null, '2000.00', '254', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('507', '2019', null, '1000.00', '255', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('508', '2019', null, '2000.00', '255', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('509', '2019', null, '1000.00', '256', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('510', '2019', null, '2000.00', '256', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('511', '2019', null, '1000.00', '257', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('512', '2019', null, '2000.00', '257', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('513', '2019', null, '1000.00', '258', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('514', '2019', null, '2000.00', '258', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('515', '2019', null, '1000.00', '259', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('516', '2019', null, '2000.00', '259', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('517', '2019', null, '1000.00', '260', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('518', '2019', null, '2000.00', '260', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('519', '2019', null, '1000.00', '261', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('520', '2019', null, '2000.00', '261', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('521', '2019', null, '1000.00', '262', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('522', '2019', null, '2000.00', '262', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('523', '2019', null, '2000.00', '263', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('524', '2019', null, '1000.00', '263', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('525', '2019', null, '1000.00', '264', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('526', '2019', null, '2000.00', '264', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('527', '2019', null, '1000.00', '265', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('528', '2019', null, '2000.00', '265', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('529', '2019', null, '1000.00', '266', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('530', '2019', null, '2000.00', '266', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('531', '2019', null, '1000.00', '267', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('532', '2019', null, '2000.00', '267', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('533', '2019', null, '1000.00', '268', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('534', '2019', null, '2000.00', '268', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('535', '2019', null, '1000.00', '269', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('536', '2019', null, '2000.00', '269', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('537', '2019', null, '1000.00', '270', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('538', '2019', null, '2000.00', '270', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('539', '2019', null, '1000.00', '271', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('540', '2019', null, '2000.00', '271', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('541', '2019', null, '1000.00', '272', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('542', '2019', null, '2000.00', '272', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('543', '2019', null, '1000.00', '273', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('544', '2019', null, '2000.00', '273', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('545', '2019', null, '1000.00', '274', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('546', '2019', null, '2000.00', '274', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('547', '2019', null, '1000.00', '275', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('548', '2019', null, '2000.00', '275', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('549', '2019', null, '1000.00', '276', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('550', '2019', null, '2000.00', '276', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('551', '2019', null, '1000.00', '277', '1', '1', null, '0', null, null);
INSERT INTO `crash_game_log` VALUES ('552', '2019', null, '2000.00', '277', '3', '1', null, '0', null, null);
INSERT INTO `crash_game_log` VALUES ('553', '2019', null, '1000.00', '279', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('554', '2019', null, '2000.00', '279', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('555', '2019', null, '1000.00', '280', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('556', '2019', null, '2000.00', '280', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('557', '2019', null, '1000.00', '281', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('558', '2019', null, '2000.00', '281', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('559', '2019', null, '1000.00', '282', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('560', '2019', null, '2000.00', '282', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('561', '2019', null, '1000.00', '283', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('562', '2019', null, '2000.00', '283', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('563', '2019', null, '1000.00', '284', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('564', '2019', null, '2000.00', '284', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('565', '2019', null, '1000.00', '285', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('566', '2019', null, '2000.00', '285', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('567', '2019', null, '1000.00', '286', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('568', '2019', null, '2000.00', '286', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('569', '2019', null, '1000.00', '287', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('570', '2019', null, '2000.00', '287', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('571', '2019', null, '1000.00', '288', '1', '1', null, '0', null, null);
INSERT INTO `crash_game_log` VALUES ('572', '2019', null, '2000.00', '288', '3', '1', null, '0', null, null);
INSERT INTO `crash_game_log` VALUES ('573', '2019', null, '1000.00', '290', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('574', '2019', null, '2000.00', '290', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('575', '2019', null, '1000.00', '291', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('576', '2019', null, '2000.00', '291', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('577', '2019', null, '1000.00', '292', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('578', '2019', null, '2000.00', '292', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('579', '2019', null, '1000.00', '293', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('580', '2019', null, '2000.00', '293', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('581', '2019', null, '1000.00', '294', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('582', '2019', null, '2000.00', '294', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('583', '2019', null, '1000.00', '295', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('584', '2019', null, '2000.00', '295', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('585', '2019', null, '1000.00', '296', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('586', '2019', null, '2000.00', '296', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('587', '2019', null, '1000.00', '297', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('588', '2019', null, '2000.00', '297', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('589', '2019', null, '1000.00', '298', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('590', '2019', null, '2000.00', '298', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('591', '2019', null, '1000.00', '299', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('592', '2019', null, '2000.00', '299', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('593', '2019', null, '1000.00', '300', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('594', '2019', null, '2000.00', '300', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('595', '2019', null, '1000.00', '301', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('596', '2019', null, '2000.00', '301', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('597', '2019', null, '1000.00', '302', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('598', '2019', null, '2000.00', '302', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('599', '2019', null, '1000.00', '303', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('600', '2019', null, '2000.00', '303', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('601', '2019', null, '1000.00', '304', '1', '1', null, '0', null, null);
INSERT INTO `crash_game_log` VALUES ('602', '2019', null, '2000.00', '304', '3', '1', null, '0', null, null);
INSERT INTO `crash_game_log` VALUES ('603', '2019', null, '1000.00', '306', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('604', '2019', null, '2000.00', '306', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('605', '2019', null, '1000.00', '307', '1', '1', null, '0', null, null);
INSERT INTO `crash_game_log` VALUES ('606', '2019', null, '2000.00', '307', '3', '1', null, '0', null, null);
INSERT INTO `crash_game_log` VALUES ('607', '2019', null, '1000.00', '308', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('608', '2019', null, '2000.00', '308', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('609', '2019', null, '1000.00', '309', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('610', '2019', null, '2000.00', '309', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('611', '2019', null, '1000.00', '310', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('612', '2019', null, '2000.00', '310', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('613', '2019', null, '1000.00', '311', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('614', '2019', null, '2000.00', '311', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('615', '2019', null, '1000.00', '312', '1', '1', null, '0', null, null);
INSERT INTO `crash_game_log` VALUES ('616', '2019', null, '2000.00', '312', '3', '1', null, '0', null, null);
INSERT INTO `crash_game_log` VALUES ('617', '2019', null, '1000.00', '314', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('618', '2019', null, '2000.00', '314', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('619', '2019', null, '1000.00', '315', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('620', '2019', null, '2000.00', '315', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('621', '2019', null, '1000.00', '316', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('622', '2019', null, '2000.00', '316', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('623', '2019', null, '1000.00', '317', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('624', '2019', null, '2000.00', '317', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('625', '2019', null, '1000.00', '318', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('626', '2019', null, '2000.00', '318', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('627', '2019', null, '1000.00', '319', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('628', '2019', null, '2000.00', '319', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('629', '2019', null, '1000.00', '320', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('630', '2019', null, '2000.00', '320', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('631', '2019', null, '1000.00', '321', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('632', '2019', null, '2000.00', '321', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('633', '2019', null, '1000.00', '322', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('634', '2019', null, '2000.00', '322', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('635', '2019', null, '1000.00', '323', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('636', '2019', null, '2000.00', '323', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('637', '2019', null, '1000.00', '324', '1', '1', null, '0', null, null);
INSERT INTO `crash_game_log` VALUES ('638', '2019', null, '2000.00', '324', '3', '1', null, '0', null, null);
INSERT INTO `crash_game_log` VALUES ('639', '2019', null, '100.00', '326', '1', '0', null, '0', null, '-100');
INSERT INTO `crash_game_log` VALUES ('640', '2019', null, '1000.00', '326', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('641', '2019', null, '2000.00', '326', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('642', '2019', null, '1000.00', '327', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('643', '2019', null, '2000.00', '327', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('644', '2019', null, '100.00', '328', '1', '0', null, '1.17', '117', '17');
INSERT INTO `crash_game_log` VALUES ('645', '2019', null, '1000.00', '328', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('646', '2019', null, '2000.00', '328', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('647', '2019', null, '1000.00', '329', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('648', '2019', null, '2000.00', '329', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('649', '2019', null, '1000.00', '330', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('650', '2019', null, '2000.00', '330', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('651', '2019', null, '1000.00', '331', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('652', '2019', null, '2000.00', '331', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('653', '2019', null, '1000.00', '332', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('654', '2019', null, '2000.00', '332', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('655', '2019', null, '1000.00', '333', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('656', '2019', null, '2000.00', '333', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('657', '2019', null, '1000.00', '334', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('658', '2019', null, '2000.00', '334', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('659', '2019', null, '1000.00', '335', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('660', '2019', null, '2000.00', '335', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('661', '2019', null, '1000.00', '336', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('662', '2019', null, '2000.00', '336', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('663', '2019', null, '1000.00', '337', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('664', '2019', null, '2000.00', '337', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('665', '2019', null, '1000.00', '338', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('666', '2019', null, '2000.00', '338', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('667', '2019', null, '1000.00', '339', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('668', '2019', null, '2000.00', '339', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('669', '2019', null, '1000.00', '340', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('670', '2019', null, '2000.00', '340', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('671', '2019', null, '1000.00', '341', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('672', '2019', null, '2000.00', '341', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('673', '2019', null, '1000.00', '342', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('674', '2019', null, '2000.00', '342', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('675', '2019', null, '1000.00', '343', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('676', '2019', null, '2000.00', '343', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('677', '2019', null, '1000.00', '344', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('678', '2019', null, '2000.00', '344', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('679', '2019', null, '1000.00', '345', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('680', '2019', null, '2000.00', '345', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('681', '2019', null, '1000.00', '346', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('682', '2019', null, '2000.00', '346', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('683', '2019', null, '1000.00', '347', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('684', '2019', null, '2000.00', '347', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('685', '2019', null, '1000.00', '348', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('686', '2019', null, '2000.00', '348', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('687', '2019', null, '1000.00', '349', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('688', '2019', null, '2000.00', '349', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('689', '2019', null, '1000.00', '350', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('690', '2019', null, '2000.00', '350', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('691', '2019', null, '1000.00', '351', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('692', '2019', null, '2000.00', '351', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('693', '2019', null, '1000.00', '352', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('694', '2019', null, '2000.00', '352', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('695', '2019', null, '1000.00', '353', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('696', '2019', null, '2000.00', '353', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('697', '2019', null, '1000.00', '354', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('698', '2019', null, '2000.00', '354', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('699', '2019', null, '1000.00', '355', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('700', '2019', null, '2000.00', '355', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('701', '2019', null, '1000.00', '356', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('702', '2019', null, '2000.00', '356', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('703', '2019', null, '1000.00', '357', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('704', '2019', null, '2000.00', '357', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('705', '2019', null, '1000.00', '358', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('706', '2019', null, '2000.00', '358', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('707', '2019', null, '1000.00', '359', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('708', '2019', null, '2000.00', '359', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('709', '2019', null, '1000.00', '360', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('710', '2019', null, '2000.00', '360', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('711', '2019', null, '1000.00', '361', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('712', '2019', null, '2000.00', '361', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('713', '2019', null, '1000.00', '362', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('714', '2019', null, '2000.00', '362', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('715', '2019', null, '1000.00', '363', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('716', '2019', null, '2000.00', '363', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('717', '2019', null, '1000.00', '364', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('718', '2019', null, '2000.00', '364', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('719', '2019', null, '1000.00', '365', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('720', '2019', null, '2000.00', '365', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('721', '2019', null, '1000.00', '366', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('722', '2019', null, '2000.00', '366', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('723', '2019', null, '1000.00', '367', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('724', '2019', null, '2000.00', '367', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('725', '2019', null, '1000.00', '368', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('726', '2019', null, '2000.00', '368', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('727', '2019', null, '1000.00', '369', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('728', '2019', null, '2000.00', '369', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('729', '2019', null, '1000.00', '370', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('730', '2019', null, '2000.00', '370', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('731', '2019', null, '1000.00', '371', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('732', '2019', null, '2000.00', '371', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('733', '2019', null, '1000.00', '372', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('734', '2019', null, '2000.00', '372', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('735', '2019', null, '1000.00', '373', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('736', '2019', null, '2000.00', '373', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('737', '2019', null, '1000.00', '374', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('738', '2019', null, '2000.00', '374', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('739', '2019', null, '1000.00', '375', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('740', '2019', null, '2000.00', '375', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('741', '2019', null, '1000.00', '376', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('742', '2019', null, '2000.00', '376', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('743', '2019', null, '1000.00', '377', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('744', '2019', null, '2000.00', '377', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('745', '2019', null, '1000.00', '378', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('746', '2019', null, '2000.00', '378', '3', '1', null, '0', '0', '-2000');
INSERT INTO `crash_game_log` VALUES ('747', '2019', null, '1000.00', '379', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('748', '2019', null, '2000.00', '379', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('749', '2019', null, '1000.00', '380', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('750', '2019', null, '2000.00', '380', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('751', '2019', null, '1000.00', '381', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('752', '2019', null, '2000.00', '381', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('753', '2019', null, '2000.00', '382', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('754', '2019', null, '1000.00', '382', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('755', '2019', null, '1000.00', '383', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('756', '2019', null, '2000.00', '383', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('757', '2019', null, '1000.00', '384', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('758', '2019', null, '2000.00', '384', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('759', '2019', null, '1000.00', '385', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('760', '2019', null, '2000.00', '385', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('761', '2019', null, '1000.00', '386', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('762', '2019', null, '2000.00', '386', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('763', '2019', null, '1000.00', '387', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('764', '2019', null, '2000.00', '387', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('765', '2019', null, '1000.00', '388', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('766', '2019', null, '2000.00', '388', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('767', '2019', null, '1000.00', '389', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('768', '2019', null, '2000.00', '389', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('769', '2019', null, '1000.00', '390', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('770', '2019', null, '2000.00', '390', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('771', '2019', null, '1000.00', '391', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('772', '2019', null, '2000.00', '391', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('773', '2019', null, '1000.00', '392', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('774', '2019', null, '2000.00', '392', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('775', '2019', null, '1000.00', '393', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('776', '2019', null, '2000.00', '393', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('777', '2019', null, '1000.00', '394', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('778', '2019', null, '2000.00', '394', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('779', '2019', null, '1000.00', '395', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('780', '2019', null, '2000.00', '395', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('781', '2019', null, '1000.00', '396', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('782', '2019', null, '2000.00', '396', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('783', '2019', null, '1000.00', '397', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('784', '2019', null, '2000.00', '397', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('785', '2019', null, '1000.00', '398', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('786', '2019', null, '2000.00', '398', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('787', '2019', null, '1000.00', '399', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('788', '2019', null, '2000.00', '399', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('789', '2019', null, '1000.00', '400', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('790', '2019', null, '2000.00', '400', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('791', '2019', null, '1000.00', '401', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('792', '2019', null, '2000.00', '401', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('793', '2019', null, '1000.00', '402', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('794', '2019', null, '2000.00', '402', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('795', '2019', null, '1000.00', '403', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('796', '2019', null, '2000.00', '403', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('797', '2019', null, '1000.00', '404', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('798', '2019', null, '2000.00', '404', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('799', '2019', null, '1000.00', '405', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('800', '2019', null, '2000.00', '405', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('801', '2019', null, '1000.00', '406', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('802', '2019', null, '2000.00', '406', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('803', '2019', null, '1000.00', '407', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('804', '2019', null, '2000.00', '407', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('805', '2019', null, '1000.00', '408', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('806', '2019', null, '2000.00', '408', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('807', '2019', null, '1000.00', '409', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('808', '2019', null, '2000.00', '409', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('809', '2019', null, '1000.00', '410', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('810', '2019', null, '2000.00', '410', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('811', '2019', null, '1000.00', '411', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('812', '2019', null, '2000.00', '411', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('813', '2019', null, '1000.00', '412', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('814', '2019', null, '2000.00', '412', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('815', '2019', null, '1000.00', '413', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('816', '2019', null, '2000.00', '413', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('817', '2019', null, '1000.00', '414', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('818', '2019', null, '2000.00', '414', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('819', '2019', null, '1000.00', '415', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('820', '2019', null, '2000.00', '415', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('821', '2019', null, '1000.00', '416', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('822', '2019', null, '2000.00', '416', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('823', '2019', null, '1000.00', '417', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('824', '2019', null, '2000.00', '417', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('825', '2019', null, '10.00', '418', '1', '0', null, '0', null, '-10');
INSERT INTO `crash_game_log` VALUES ('826', '2019', null, '1000.00', '418', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('827', '2019', null, '2000.00', '418', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('828', '2019', null, '1000.00', '419', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('829', '2019', null, '2000.00', '419', '3', '1', null, '0', '0', '-2000');
INSERT INTO `crash_game_log` VALUES ('830', '2019', null, '1000.00', '420', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('831', '2019', null, '2000.00', '420', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('832', '2019', null, '1000.00', '421', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('833', '2019', null, '2000.00', '421', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('834', '2019', null, '1000.00', '422', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('835', '2019', null, '2000.00', '422', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('836', '2019', null, '1000.00', '423', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('837', '2019', null, '2000.00', '423', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('838', '2019', null, '1000.00', '424', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('839', '2019', null, '2000.00', '424', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('840', '2019', null, '1000.00', '425', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('841', '2019', null, '2000.00', '425', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('842', '2019', null, '1000.00', '426', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('843', '2019', null, '2000.00', '426', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('844', '2019', null, '1000.00', '427', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('845', '2019', null, '2000.00', '427', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('846', '2019', null, '1000.00', '428', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('847', '2019', null, '2000.00', '428', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('848', '2019', null, '1000.00', '429', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('849', '2019', null, '2000.00', '429', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('850', '2019', null, '1000.00', '430', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('851', '2019', null, '2000.00', '430', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('852', '2019', null, '1000.00', '431', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('853', '2019', null, '2000.00', '431', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('854', '2019', null, '1000.00', '432', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('855', '2019', null, '2000.00', '432', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('856', '2019', null, '1000.00', '433', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('857', '2019', null, '2000.00', '433', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('858', '2019', null, '1000.00', '434', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('859', '2019', null, '2000.00', '434', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('860', '2019', null, '1000.00', '435', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('861', '2019', null, '2000.00', '435', '3', '1', null, '0', '0', '-2000');
INSERT INTO `crash_game_log` VALUES ('862', '2019', null, '1000.00', '437', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('863', '2019', null, '2000.00', '437', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('864', '2019', null, '1000.00', '438', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('865', '2019', null, '2000.00', '438', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('866', '2019', null, '1000.00', '439', '1', '1', null, '0', null, null);
INSERT INTO `crash_game_log` VALUES ('867', '2019', null, '2000.00', '439', '3', '1', null, '0', null, null);
INSERT INTO `crash_game_log` VALUES ('868', '2019', null, '1000.00', '440', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('869', '2019', null, '2000.00', '440', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('870', '2019', null, '1000.00', '441', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('871', '2019', null, '2000.00', '441', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('872', '2019', null, '1000.00', '442', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('873', '2019', null, '2000.00', '442', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('874', '2019', null, '1111.00', '443', '1', '0', null, '0', null, '-1111');
INSERT INTO `crash_game_log` VALUES ('875', '2019', null, '1000.00', '443', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('876', '2019', null, '2000.00', '443', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('877', '2019', null, '1000.00', '444', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('878', '2019', null, '2000.00', '444', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('879', '2019', null, '1000.00', '445', '1', '1', null, '0', '0', '-1000');
INSERT INTO `crash_game_log` VALUES ('880', '2019', null, '2000.00', '445', '3', '1', null, '0', null, '-2000');
INSERT INTO `crash_game_log` VALUES ('881', '2019', null, '1000.00', '446', '1', '1', null, '0', null, '-1000');
INSERT INTO `crash_game_log` VALUES ('882', '2019', null, '2000.00', '446', '3', '1', null, '0', null, '-2000');

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
) ENGINE=InnoDB AUTO_INCREMENT=448 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of crash_game_total
-- ----------------------------
INSERT INTO `crash_game_total` VALUES ('1', '2019-11-28 07:32:14', null, '1', '2019-11-28 07:34:20', '2019-11-28 07:34:34', '231.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('2', '2019-11-28 07:34:20', null, '2', '2019-11-28 07:34:42', '2019-11-28 07:34:44', '109.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('3', '2019-11-28 07:34:42', null, '3', '2019-11-28 07:34:52', '2019-11-28 07:35:20', '538.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('4', '2019-11-28 07:34:52', null, '4', '2019-11-28 07:35:28', '2019-11-28 07:35:45', '274.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('5', '2019-11-28 07:35:28', null, '5', '2019-11-28 07:35:53', '2019-11-28 07:36:05', '202.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('6', '2019-11-28 07:35:53', null, '6', '2019-11-28 07:36:13', '2019-11-28 07:36:36', '391.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('7', '2019-11-28 07:36:13', null, '7', '2019-11-28 07:36:44', '2019-11-28 07:36:50', '138.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('8', '2019-11-28 07:36:44', null, '8', '2019-11-28 07:36:58', '2019-11-28 07:37:20', '381.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('9', '2019-11-28 07:36:58', null, '9', '2019-11-28 07:37:28', '2019-11-28 07:37:34', '142.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('10', '2019-11-28 07:37:28', null, '10', '2019-11-28 07:37:42', '2019-11-28 07:38:04', '360.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('11', '2019-11-28 07:37:42', null, '11', '2019-11-28 07:38:12', '2019-11-28 07:38:18', '148.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('12', '2019-11-28 07:38:12', null, '12', '2019-11-28 07:38:27', '2019-11-28 07:38:27', '103.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('13', '2019-11-28 07:38:27', null, '13', '2019-11-28 07:38:35', '2019-11-28 07:38:59', '412.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('14', '2019-11-28 07:38:35', null, '14', '2019-11-28 07:39:07', '2019-11-28 07:39:30', '401.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('15', '2019-11-28 07:39:07', null, '15', '2019-11-28 07:39:38', '2019-11-28 07:40:01', '374.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('16', '2019-11-28 07:39:38', null, '16', '2019-11-28 07:40:09', '2019-11-28 07:40:11', '117.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('17', '2019-11-28 07:40:09', null, '17', '2019-11-28 07:40:19', '2019-11-28 07:40:22', '118.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('18', '2019-11-28 07:40:19', null, '18', '2019-11-28 07:40:30', '2019-11-28 07:40:47', '273.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('19', '2019-11-28 07:40:30', null, '19', '2019-11-28 07:40:55', '2019-11-28 07:41:02', '149.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('20', '2019-11-28 07:40:55', null, '20', '2019-11-28 07:41:10', '2019-11-28 07:41:16', '141.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('21', '2019-11-28 07:41:10', null, '21', '2019-11-28 07:41:24', '2019-11-28 07:42:00', '847.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('22', '2019-11-28 07:41:24', null, '22', '2019-11-28 07:42:08', '2019-11-28 07:42:34', '476.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('23', '2019-11-28 07:42:08', null, '23', '2019-11-28 07:42:42', '2019-11-28 07:42:51', '167.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('24', '2019-11-28 07:42:42', null, '24', '2019-11-30 05:53:57', '2019-11-30 05:54:11', '231.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('25', '2019-11-30 05:53:57', null, '25', '2019-11-30 05:54:19', '2019-11-30 05:54:20', '109.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('26', '2019-11-30 05:54:19', null, '26', '2019-11-30 05:54:28', '2019-11-30 05:54:57', '538.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('27', '2019-11-30 05:54:28', null, '27', '2019-11-30 05:55:05', '2019-11-30 05:55:22', '274.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('28', '2019-11-30 05:55:05', null, '28', '2019-11-30 05:55:30', '2019-11-30 05:55:41', '202.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('29', '2019-11-30 05:55:30', null, '29', '2019-11-30 05:55:50', '2019-11-30 05:56:12', '391.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('30', '2019-11-30 05:55:50', null, '30', '2019-11-30 05:56:21', '2019-11-30 05:56:26', '138.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('31', '2019-11-30 05:56:21', null, '31', '2019-11-30 05:56:34', '2019-11-30 05:56:57', '381.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('32', '2019-11-30 05:56:34', null, '32', '2019-11-30 05:57:05', '2019-11-30 05:57:11', '142.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('33', '2019-11-30 05:57:05', null, '33', '2019-11-30 05:57:19', '2019-11-30 05:57:40', '360.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('34', '2019-11-30 05:57:19', null, '34', '2019-11-30 05:57:48', '2019-11-30 05:57:55', '148.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('35', '2019-11-30 05:57:48', null, '35', '2019-11-30 05:58:03', '2019-11-30 05:58:04', '103.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('36', '2019-11-30 05:58:03', null, '36', '2019-11-30 05:58:12', '2019-11-30 05:58:36', '412.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('37', '2019-11-30 05:58:12', null, '37', '2019-11-30 05:58:44', '2019-11-30 05:59:07', '401.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('38', '2019-11-30 05:58:44', null, '38', '2019-11-30 05:59:15', '2019-11-30 05:59:37', '374.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('39', '2019-11-30 05:59:15', null, '39', '2019-11-30 05:59:45', '2019-11-30 05:59:48', '117.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('40', '2019-11-30 05:59:45', null, '40', '2019-11-30 05:59:56', '2019-11-30 05:59:59', '118.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('41', '2019-11-30 05:59:56', null, '41', '2019-11-30 06:00:07', '2019-11-30 06:00:24', '273.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('42', '2019-11-30 06:00:07', null, '42', '2019-11-30 06:00:32', '2019-11-30 06:00:39', '149.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('43', '2019-11-30 06:00:32', null, '43', '2019-11-30 06:00:47', '2019-11-30 06:00:53', '141.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('44', '2019-11-30 06:00:47', null, '44', '2019-11-30 06:01:01', '2019-11-30 06:01:36', '847.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('45', '2019-11-30 06:01:01', null, '45', '2019-11-30 06:01:44', '2019-11-30 06:02:11', '476.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('46', '2019-11-30 06:01:44', null, '46', '2019-11-30 06:02:19', null, '167.00', '0.0000', '0.0000', '0', '2', '', '0', 'STARTED', null, null);
INSERT INTO `crash_game_total` VALUES ('47', '2019-11-30 06:02:19', null, '47', '2019-11-30 06:10:01', '2019-11-30 06:10:15', '231.00', '0.0000', '0.0000', '0', '0', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('48', '2019-11-30 06:10:01', null, '48', '2019-11-30 06:10:23', '2019-11-30 06:10:24', '109.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('49', '2019-11-30 06:10:23', null, '49', '2019-11-30 06:10:32', '2019-11-30 06:11:01', '538.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('50', '2019-11-30 06:10:33', null, '50', '2019-11-30 06:11:09', '2019-11-30 06:11:26', '274.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('51', '2019-11-30 06:11:09', null, '51', '2019-11-30 06:11:34', '2019-11-30 06:11:46', '202.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('52', '2019-11-30 06:11:34', null, '52', '2019-11-30 06:11:54', '2019-11-30 06:12:17', '391.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('53', '2019-11-30 06:11:54', null, '53', '2019-11-30 06:12:25', '2019-11-30 06:12:30', '138.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('54', '2019-11-30 06:12:25', null, '54', '2019-11-30 06:12:38', '2019-11-30 06:13:01', '381.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('55', '2019-11-30 06:12:38', null, '55', '2019-11-30 06:13:09', '2019-11-30 06:13:15', '142.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('56', '2019-11-30 06:13:09', null, '56', '2019-11-30 06:13:23', '2019-11-30 06:13:44', '360.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('57', '2019-11-30 06:13:23', null, '57', '2019-11-30 06:13:52', '2019-11-30 06:13:59', '148.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('58', '2019-11-30 06:13:52', null, '58', '2019-11-30 06:14:07', '2019-11-30 06:14:08', '103.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('59', '2019-11-30 06:14:07', null, '59', '2019-11-30 06:14:16', '2019-11-30 06:14:40', '412.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('60', '2019-11-30 06:14:16', null, '60', '2019-11-30 06:14:48', '2019-11-30 06:15:11', '401.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('61', '2019-11-30 06:14:48', null, '61', '2019-11-30 06:15:19', '2019-11-30 06:15:41', '374.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('62', '2019-11-30 06:15:19', null, '62', '2019-11-30 06:15:49', '2019-11-30 06:15:52', '117.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('63', '2019-11-30 06:15:49', null, '63', '2019-11-30 06:16:00', '2019-11-30 06:16:03', '118.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('64', '2019-11-30 06:16:00', null, '64', '2019-11-30 06:16:11', '2019-11-30 06:16:28', '273.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('65', '2019-11-30 06:16:11', null, '65', '2019-11-30 06:16:36', '2019-11-30 06:16:43', '149.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('66', '2019-11-30 06:16:36', null, '66', '2019-11-30 06:16:51', '2019-11-30 06:16:57', '141.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('67', '2019-11-30 06:16:51', null, '67', '2019-11-30 06:17:05', '2019-11-30 06:17:41', '847.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('68', '2019-11-30 06:17:05', null, '68', '2019-11-30 06:17:49', '2019-11-30 06:18:15', '476.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('69', '2019-11-30 06:17:49', null, '69', '2019-11-30 06:18:23', '2019-11-30 06:18:32', '167.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('70', '2019-11-30 06:18:23', null, '70', '2019-11-30 06:18:40', '2019-11-30 06:18:44', '131.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('71', '2019-11-30 06:18:40', null, '71', '2019-11-30 06:23:54', '2019-11-30 06:24:08', '231.00', '0.0000', '0.0000', '0', '0', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('72', '2019-11-30 06:23:54', null, '72', '2019-11-30 06:24:16', '2019-11-30 06:24:17', '109.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('73', '2019-11-30 06:24:16', null, '73', '2019-11-30 06:24:26', '2019-11-30 06:24:54', '538.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('74', '2019-11-30 06:24:26', null, '74', '2019-11-30 06:25:02', '2019-11-30 06:25:19', '274.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('75', '2019-11-30 06:25:02', null, '75', '2019-11-30 06:25:27', '2019-11-30 06:25:39', '202.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('76', '2019-11-30 06:25:27', null, '76', '2019-11-30 06:25:47', '2019-11-30 06:26:10', '391.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('77', '2019-11-30 06:25:47', null, '77', '2019-11-30 06:26:18', '2019-11-30 06:26:23', '138.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('78', '2019-11-30 06:26:18', null, '78', '2019-11-30 06:26:31', '2019-11-30 06:26:54', '381.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('79', '2019-11-30 06:26:31', null, '79', '2019-11-30 06:27:02', '2019-11-30 06:27:08', '142.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('80', '2019-11-30 06:27:02', null, '80', '2019-11-30 06:27:16', '2019-11-30 06:27:37', '360.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('81', '2019-11-30 06:27:16', null, '81', '2019-11-30 06:27:45', '2019-11-30 06:27:52', '148.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('82', '2019-11-30 06:27:45', null, '82', '2019-11-30 06:28:00', '2019-11-30 06:28:01', '103.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('83', '2019-11-30 06:28:00', null, '83', '2019-11-30 06:28:09', '2019-11-30 06:28:33', '412.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('84', '2019-11-30 06:28:09', null, '84', '2019-11-30 06:28:41', '2019-11-30 06:29:04', '401.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('85', '2019-11-30 06:28:41', null, '85', '2019-11-30 06:29:12', '2019-11-30 06:29:34', '374.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('86', '2019-11-30 06:29:12', null, '86', '2019-11-30 06:29:42', '2019-11-30 06:29:45', '117.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('87', '2019-11-30 06:29:42', null, '87', '2019-11-30 06:29:53', '2019-11-30 06:29:56', '118.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('88', '2019-11-30 06:29:53', null, '88', '2019-11-30 06:30:04', '2019-11-30 06:30:21', '273.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('89', '2019-11-30 06:30:04', null, '89', '2019-11-30 06:30:29', '2019-11-30 06:30:36', '149.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('90', '2019-11-30 06:30:29', null, '90', '2019-11-30 06:30:44', '2019-11-30 06:30:50', '141.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('91', '2019-11-30 06:30:44', null, '91', '2019-11-30 06:30:58', '2019-11-30 06:31:33', '847.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('92', '2019-11-30 06:30:58', null, '92', '2019-11-30 06:31:41', '2019-11-30 06:32:08', '476.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('93', '2019-11-30 06:31:42', null, '93', '2019-11-30 06:32:16', '2019-11-30 06:32:24', '167.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('94', '2019-11-30 06:32:16', null, '94', '2019-11-30 06:32:32', '2019-11-30 06:32:37', '131.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('95', '2019-11-30 06:32:32', null, '95', '2019-11-30 06:32:45', '2019-11-30 06:33:00', '237.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('96', '2019-11-30 06:32:45', null, '96', '2019-11-30 06:33:08', '2019-11-30 06:33:19', '191.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('97', '2019-11-30 06:33:08', null, '97', '2019-11-30 06:33:27', '2019-11-30 06:33:53', '473.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('98', '2019-11-30 06:33:27', null, '98', '2019-11-30 06:34:01', '2019-11-30 06:34:02', '103.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('99', '2019-11-30 06:34:01', null, '99', '2019-11-30 06:34:10', '2019-11-30 06:34:14', '131.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('100', '2019-11-30 06:34:10', null, '100', '2019-11-30 06:34:22', '2019-11-30 06:34:29', '148.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('101', '2019-11-30 06:34:22', null, '101', '2019-11-30 06:34:37', '2019-11-30 06:34:44', '150.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('102', '2019-11-30 06:34:37', null, '102', '2019-11-30 06:34:52', '2019-11-30 06:35:12', '324.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('103', '2019-11-30 06:34:52', null, '103', '2019-11-30 06:35:20', '2019-11-30 06:35:35', '249.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('104', '2019-11-30 06:35:20', null, '104', '2019-12-01 02:53:03', '2019-12-01 02:53:17', '231.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('105', '2019-12-01 02:53:03', null, '105', '2019-12-01 02:53:25', '2019-12-01 02:53:26', '109.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('106', '2019-12-01 02:53:25', null, '106', '2019-12-01 02:53:35', '2019-12-01 02:54:03', '538.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('107', '2019-12-01 02:53:35', null, '107', '2019-12-01 02:54:11', '2019-12-01 02:54:28', '274.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('108', '2019-12-01 02:54:11', null, '108', '2019-12-01 02:54:36', '2019-12-01 02:54:48', '202.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('109', '2019-12-01 02:54:36', null, '109', '2019-12-01 02:54:56', '2019-12-01 02:55:19', '391.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('110', '2019-12-01 02:54:56', null, '110', '2019-12-01 02:55:27', '2019-12-01 02:55:32', '138.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('111', '2019-12-01 02:55:27', null, '111', '2019-12-01 02:55:40', '2019-12-01 02:56:03', '381.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('112', '2019-12-01 02:55:40', null, '112', '2019-12-01 02:56:11', '2019-12-01 02:56:17', '142.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('113', '2019-12-01 02:56:11', null, '113', '2019-12-01 02:56:25', '2019-12-01 02:56:47', '360.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('114', '2019-12-01 02:56:25', null, '114', '2019-12-01 02:56:55', '2019-12-01 02:57:01', '148.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('115', '2019-12-01 02:56:55', null, '115', '2019-12-01 02:57:09', '2019-12-01 02:57:10', '103.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('116', '2019-12-01 02:57:10', null, '116', '2019-12-01 02:57:18', '2019-12-01 02:57:42', '412.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('117', '2019-12-01 02:57:18', null, '117', '2019-12-01 02:57:50', '2019-12-01 02:58:13', '401.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('118', '2019-12-01 02:57:50', null, '118', '2019-12-01 02:58:21', '2019-12-01 02:58:43', '374.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('119', '2019-12-01 02:58:21', null, '119', '2019-12-01 02:58:52', '2019-12-01 02:58:54', '117.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('120', '2019-12-01 02:58:52', null, '120', '2019-12-01 02:59:02', '2019-12-01 02:59:05', '118.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('121', '2019-12-01 02:59:02', null, '121', '2019-12-01 02:59:13', '2019-12-01 02:59:30', '273.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('122', '2019-12-01 02:59:13', null, '122', '2019-12-01 02:59:38', '2019-12-01 02:59:45', '149.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('123', '2019-12-01 02:59:38', null, '123', '2019-12-01 02:59:53', '2019-12-01 02:59:59', '141.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('124', '2019-12-01 02:59:53', null, '124', '2019-12-01 03:00:07', '2019-12-01 03:00:43', '847.00', '0.0000', '-2111.0900', '1', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('125', '2019-12-01 03:00:07', null, '125', '2019-12-01 03:00:51', '2019-12-01 03:01:17', '476.00', '0.0000', '-25221.9700', '1', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('126', '2019-12-01 03:00:51', null, '126', '2019-12-01 03:01:25', '2019-12-01 03:01:34', '167.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('127', '2019-12-01 03:01:25', null, '127', '2019-12-01 03:01:42', '2019-12-01 03:01:46', '131.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('128', '2019-12-01 03:01:42', null, '128', '2019-12-01 03:01:55', '2019-12-01 03:02:09', '237.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('129', '2019-12-01 03:01:55', null, '129', '2019-12-01 03:02:17', '2019-12-01 03:02:28', '191.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('130', '2019-12-01 03:02:17', null, '130', '2019-12-01 03:02:36', '2019-12-01 03:03:02', '473.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('131', '2019-12-01 03:02:36', null, '131', '2019-12-01 03:03:10', '2019-12-01 03:03:11', '103.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('132', '2019-12-01 03:03:10', null, '132', '2019-12-01 03:03:19', '2019-12-01 03:03:24', '131.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('133', '2019-12-01 03:03:19', null, '133', '2019-12-01 03:03:32', '2019-12-01 03:03:38', '148.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('134', '2019-12-01 03:03:32', null, '134', '2019-12-01 03:03:47', '2019-12-01 03:03:54', '150.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('135', '2019-12-01 03:03:47', null, '135', '2019-12-01 03:04:02', '2019-12-01 03:04:22', '324.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('136', '2019-12-01 03:04:02', null, '136', '2019-12-01 03:04:31', '2019-12-01 03:04:46', '249.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('137', '2019-12-01 03:04:31', null, '137', '2019-12-01 03:04:55', '2019-12-01 03:05:18', '401.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('138', '2019-12-01 03:04:55', null, '138', '2019-12-01 03:05:27', '2019-12-01 03:05:30', '122.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('139', '2019-12-01 03:05:27', null, '139', '2019-12-01 03:05:38', '2019-12-01 03:05:47', '170.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('140', '2019-12-01 03:05:38', null, '140', '2019-12-01 03:05:55', '2019-12-01 03:06:13', '289.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('141', '2019-12-01 03:05:55', null, '141', '2019-12-01 03:06:21', '2019-12-01 03:07:18', '3062.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('142', '2019-12-01 03:06:21', null, '142', '2019-12-01 03:07:27', '2019-12-01 03:07:38', '196.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('143', '2019-12-01 03:07:27', null, '143', '2019-12-01 03:07:46', '2019-12-01 03:07:56', '183.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('144', '2019-12-01 03:07:46', null, '144', '2019-12-01 03:08:04', '2019-12-01 03:08:16', '194.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('145', '2019-12-01 03:08:04', null, '145', '2019-12-01 03:08:24', '2019-12-01 03:08:32', '163.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('146', '2019-12-01 03:08:24', null, '146', '2019-12-01 03:08:40', '2019-12-01 03:08:41', '103.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('147', '2019-12-01 03:08:40', null, '147', '2019-12-01 03:08:49', '2019-12-01 03:09:19', '620.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('148', '2019-12-01 03:08:49', null, '148', '2019-12-01 03:09:27', '2019-12-01 03:09:39', '196.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('149', '2019-12-01 03:09:27', null, '149', '2019-12-01 03:09:47', '2019-12-01 03:09:50', '123.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('150', '2019-12-01 03:09:47', null, '150', '2019-12-01 03:09:58', '2019-12-01 03:10:19', '344.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('151', '2019-12-01 03:09:58', null, '151', '2019-12-01 03:10:27', '2019-12-01 03:10:33', '139.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('152', '2019-12-01 03:10:27', null, '152', '2019-12-01 03:10:41', '2019-12-01 03:11:26', '1489.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('153', '2019-12-01 03:10:41', null, '153', '2019-12-01 03:11:35', '2019-12-01 03:11:37', '118.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('154', '2019-12-01 03:11:35', null, '154', '2019-12-01 03:11:46', '2019-12-01 03:11:59', '220.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('155', '2019-12-01 03:11:46', null, '155', '2019-12-01 03:12:07', '2019-12-01 03:12:46', '1019.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('156', '2019-12-01 03:12:07', null, '156', '2019-12-01 03:17:13', '2019-12-01 03:17:27', '231.00', '0.0000', '0.0000', '0', '4', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('157', '2019-12-01 03:17:13', null, '157', '2019-12-01 03:17:35', '2019-12-01 03:17:37', '109.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('158', '2019-12-01 03:17:35', null, '158', '2019-12-01 03:17:45', '2019-12-01 03:18:13', '538.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('159', '2019-12-01 03:17:45', null, '159', '2019-12-01 03:18:21', '2019-12-01 03:18:38', '274.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('160', '2019-12-01 03:18:21', null, '160', '2019-12-01 03:18:46', '2019-12-01 03:18:58', '202.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('161', '2019-12-01 03:18:46', null, '161', '2019-12-01 03:19:06', '2019-12-01 03:19:29', '391.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('162', '2019-12-01 03:19:06', null, '162', '2019-12-01 03:19:37', '2019-12-01 03:19:43', '138.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('163', '2019-12-01 03:19:37', null, '163', '2019-12-01 03:19:51', '2019-12-01 03:20:13', '381.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('164', '2019-12-01 03:19:51', null, '164', '2019-12-01 03:20:21', '2019-12-01 03:20:27', '142.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('165', '2019-12-01 03:20:21', null, '165', '2019-12-01 03:20:36', '2019-12-01 03:20:57', '360.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('166', '2019-12-01 03:20:36', null, '166', '2019-12-01 03:21:05', '2019-12-01 03:21:12', '148.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('167', '2019-12-01 03:21:05', null, '167', '2019-12-01 03:21:20', '2019-12-01 03:21:20', '103.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('168', '2019-12-01 03:21:20', null, '168', '2019-12-01 03:21:28', '2019-12-01 03:21:52', '412.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('169', '2019-12-01 03:21:29', null, '169', '2019-12-01 03:22:01', '2019-12-01 03:22:24', '401.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('170', '2019-12-01 03:22:01', null, '170', '2019-12-01 03:22:32', '2019-12-01 03:22:54', '374.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('171', '2019-12-01 03:22:32', null, '171', '2019-12-01 03:23:02', '2019-12-01 03:23:05', '117.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('172', '2019-12-01 03:23:02', null, '172', '2019-12-01 03:23:13', '2019-12-01 03:23:16', '118.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('173', '2019-12-01 03:23:13', null, '173', '2019-12-01 03:23:24', '2019-12-01 03:23:41', '273.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('174', '2019-12-01 03:23:24', null, '174', '2019-12-01 03:23:49', '2019-12-01 03:23:56', '149.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('175', '2019-12-01 03:23:49', null, '175', '2019-12-01 03:24:04', '2019-12-01 03:24:10', '141.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('176', '2019-12-01 03:24:04', null, '176', '2019-12-01 03:24:18', '2019-12-01 03:24:54', '847.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('177', '2019-12-01 03:24:18', null, '177', '2019-12-01 03:25:02', '2019-12-01 03:25:28', '476.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('178', '2019-12-01 03:25:02', null, '178', '2019-12-01 03:25:36', '2019-12-01 03:25:45', '167.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('179', '2019-12-01 03:25:36', null, '179', '2019-12-01 03:25:53', '2019-12-01 03:25:58', '131.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('180', '2019-12-01 03:25:53', null, '180', '2019-12-01 03:26:06', '2019-12-01 03:26:20', '237.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('181', '2019-12-01 03:26:06', null, '181', '2019-12-01 03:26:28', '2019-12-01 03:26:39', '191.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('182', '2019-12-01 03:26:28', null, '182', '2019-12-01 03:26:47', '2019-12-01 03:27:13', '473.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('183', '2019-12-01 03:26:47', null, '183', '2019-12-01 03:27:22', '2019-12-01 03:27:22', '103.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('184', '2019-12-01 03:27:22', null, '184', '2019-12-01 03:27:30', '2019-12-01 03:27:35', '131.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('185', '2019-12-01 03:27:30', null, '185', '2019-12-01 03:31:20', '2019-12-01 03:31:34', '231.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('186', '2019-12-01 03:31:20', null, '186', '2019-12-01 03:31:43', '2019-12-01 03:31:44', '109.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('187', '2019-12-01 03:31:43', null, '187', '2019-12-01 03:31:52', '2019-12-01 03:32:21', '538.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('188', '2019-12-01 03:31:53', null, '188', '2019-12-01 03:32:29', '2019-12-01 03:32:46', '274.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('189', '2019-12-01 03:32:29', null, '189', '2019-12-01 03:32:54', '2019-12-01 03:33:06', '202.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('190', '2019-12-01 03:32:54', null, '190', '2019-12-01 03:33:14', '2019-12-01 03:33:37', '391.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('191', '2019-12-01 03:33:14', null, '191', '2019-12-01 03:33:45', '2019-12-01 03:33:51', '138.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('192', '2019-12-01 03:33:45', null, '192', '2019-12-01 03:33:59', '2019-12-01 03:34:21', '381.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('193', '2019-12-01 03:33:59', null, '193', '2019-12-01 03:34:29', '2019-12-01 03:34:35', '142.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('194', '2019-12-01 03:34:29', null, '194', '2019-12-01 03:34:43', '2019-12-01 03:35:05', '360.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('195', '2019-12-01 03:34:43', null, '195', '2019-12-01 03:35:13', '2019-12-01 03:35:19', '148.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('196', '2019-12-01 03:35:13', null, '196', '2019-12-01 03:35:28', '2019-12-01 03:35:28', '103.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('197', '2019-12-01 03:35:28', null, '197', '2019-12-01 03:35:36', '2019-12-01 03:36:00', '412.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('198', '2019-12-01 03:35:36', null, '198', '2019-12-01 03:36:08', '2019-12-01 03:36:31', '401.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('199', '2019-12-01 03:36:08', null, '199', '2019-12-01 03:36:40', '2019-12-01 03:37:02', '374.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('200', '2019-12-01 03:36:40', null, '200', '2019-12-01 03:37:10', '2019-12-01 03:37:13', '117.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('201', '2019-12-01 03:37:10', null, '201', '2019-12-01 03:37:21', '2019-12-01 03:37:24', '118.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('202', '2019-12-01 03:37:21', null, '202', '2019-12-01 03:37:32', '2019-12-01 03:37:48', '273.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('203', '2019-12-01 03:37:32', null, '203', '2019-12-01 03:37:57', '2019-12-01 03:38:03', '149.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('204', '2019-12-01 03:37:57', null, '204', '2019-12-01 03:38:11', '2019-12-01 03:38:17', '141.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('205', '2019-12-01 03:38:11', null, '205', '2019-12-01 03:38:25', '2019-12-01 03:39:01', '847.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('206', '2019-12-01 03:38:25', null, '206', '2019-12-01 03:39:09', '2019-12-01 03:39:35', '476.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('207', '2019-12-01 03:39:09', null, '207', '2019-12-01 03:39:44', '2019-12-01 03:39:52', '167.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('208', '2019-12-01 03:39:44', null, '208', '2019-12-01 03:45:23', '2019-12-01 03:45:37', '231.00', '0.0000', '0.0000', '0', '0', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('209', '2019-12-01 03:45:23', null, '209', '2019-12-01 03:45:45', '2019-12-01 03:45:47', '109.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('210', '2019-12-01 03:45:45', null, '210', '2019-12-01 03:45:55', '2019-12-01 03:46:23', '538.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('211', '2019-12-01 03:45:55', null, '211', '2019-12-01 03:46:31', '2019-12-01 03:46:48', '274.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('212', '2019-12-01 03:46:31', null, '212', '2019-12-01 03:46:56', '2019-12-01 03:47:08', '202.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('213', '2019-12-01 03:46:56', null, '213', '2019-12-01 03:47:16', '2019-12-01 03:47:39', '391.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('214', '2019-12-01 03:47:16', null, '214', '2019-12-01 03:47:47', '2019-12-01 03:47:53', '138.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('215', '2019-12-01 03:47:47', null, '215', '2019-12-01 03:48:01', '2019-12-01 03:48:23', '381.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('216', '2019-12-01 03:48:01', null, '216', '2019-12-01 03:48:31', '2019-12-01 03:48:37', '142.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('217', '2019-12-01 03:48:31', null, '217', '2019-12-01 03:48:45', '2019-12-01 03:49:07', '360.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('218', '2019-12-01 03:48:45', null, '218', '2019-12-01 03:49:15', '2019-12-01 03:49:22', '148.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('219', '2019-12-01 03:49:15', null, '219', '2019-12-01 03:49:30', '2019-12-01 03:49:30', '103.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('220', '2019-12-01 03:49:30', null, '220', '2019-12-01 03:49:38', '2019-12-01 03:50:02', '412.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('221', '2019-12-01 03:49:38', null, '221', '2019-12-01 03:50:10', '2019-12-01 03:50:34', '401.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('222', '2019-12-01 03:50:10', null, '222', '2019-12-01 03:50:42', '2019-12-01 03:51:04', '374.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('223', '2019-12-01 03:50:42', null, '223', '2019-12-01 03:51:12', '2019-12-01 03:51:15', '117.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('224', '2019-12-01 03:51:12', null, '224', '2019-12-01 03:51:23', '2019-12-01 03:51:26', '118.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('225', '2019-12-01 03:51:23', null, '225', '2019-12-01 03:51:34', '2019-12-01 03:51:51', '273.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('226', '2019-12-01 03:51:34', null, '226', '2019-12-01 03:51:59', '2019-12-01 03:52:05', '149.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('227', '2019-12-01 03:51:59', null, '227', '2019-12-01 03:52:13', '2019-12-01 03:52:19', '141.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('228', '2019-12-01 03:52:13', null, '228', '2019-12-01 03:52:27', '2019-12-01 03:53:03', '847.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('229', '2019-12-01 03:52:27', null, '229', '2019-12-01 03:53:11', '2019-12-01 03:53:37', '476.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('230', '2019-12-01 03:53:11', null, '230', '2019-12-01 03:53:46', '2019-12-01 03:53:54', '167.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('231', '2019-12-01 03:53:46', null, '231', '2019-12-01 03:54:02', '2019-12-01 03:54:07', '131.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('232', '2019-12-01 03:54:02', null, '232', '2019-12-01 03:54:15', '2019-12-01 03:54:29', '237.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('233', '2019-12-01 03:54:15', null, '233', '2019-12-01 03:54:38', '2019-12-01 03:54:49', '191.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('234', '2019-12-01 03:54:38', null, '234', '2019-12-01 03:54:57', '2019-12-01 03:55:23', '473.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('235', '2019-12-01 03:54:57', null, '235', '2019-12-01 03:55:31', '2019-12-01 03:55:31', '103.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('236', '2019-12-01 03:55:31', null, '236', '2019-12-01 03:55:39', '2019-12-01 03:55:44', '131.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('237', '2019-12-01 03:55:39', null, '237', '2019-12-01 03:55:52', '2019-12-01 03:55:59', '148.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('238', '2019-12-01 03:55:52', null, '238', '2019-12-01 03:56:07', '2019-12-01 03:56:14', '150.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('239', '2019-12-01 03:56:07', null, '239', '2019-12-01 03:56:22', '2019-12-01 03:56:41', '324.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('240', '2019-12-01 03:56:22', null, '240', '2019-12-01 03:56:55', '2019-12-01 03:57:31', '880.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('241', '2019-12-01 03:56:55', null, '241', '2019-12-01 03:57:39', '2019-12-01 03:58:15', '880.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('242', '2019-12-01 03:57:39', null, '242', '2019-12-01 03:58:23', '2019-12-01 03:59:00', '880.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('243', '2019-12-01 03:58:23', null, '243', '2019-12-01 03:59:08', '2019-12-01 03:59:44', '880.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('244', '2019-12-01 03:59:08', null, '244', '2019-12-01 03:59:52', '2019-12-01 04:00:29', '880.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('245', '2019-12-01 03:59:52', null, '245', '2019-12-01 04:00:37', '2019-12-01 04:01:13', '880.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('246', '2019-12-01 04:00:37', null, '246', '2019-12-01 04:01:21', '2019-12-01 04:01:58', '880.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('247', '2019-12-01 04:01:21', null, '247', '2019-12-01 04:02:06', null, '880.00', '0.0000', '0.0000', '0', '2', '', '0', 'STARTED', null, null);
INSERT INTO `crash_game_total` VALUES ('248', '2019-12-01 04:02:06', null, '248', '2019-12-01 04:06:09', '2019-12-01 04:06:46', '880.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('249', '2019-12-01 04:06:09', null, '249', '2019-12-01 04:06:54', '2019-12-01 04:07:30', '880.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('250', '2019-12-01 04:06:54', null, '250', '2019-12-01 04:07:38', '2019-12-01 04:08:15', '880.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('251', '2019-12-01 04:07:38', null, '251', '2019-12-01 04:08:23', '2019-12-01 04:08:59', '880.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('252', '2019-12-01 04:08:23', null, '252', '2019-12-01 04:09:07', '2019-12-01 04:09:44', '880.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('253', '2019-12-01 04:09:07', null, '253', '2019-12-01 04:09:52', '2019-12-01 04:10:28', '880.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('254', '2019-12-01 04:09:52', null, '254', '2019-12-01 04:10:36', '2019-12-01 04:11:13', '880.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('255', '2019-12-01 04:10:36', null, '255', '2019-12-01 04:11:21', '2019-12-01 04:11:57', '880.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('256', '2019-12-01 04:11:21', null, '256', '2019-12-01 04:12:05', '2019-12-01 04:12:42', '880.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('257', '2019-12-01 04:12:05', null, '257', '2019-12-01 04:12:50', '2019-12-01 04:13:26', '880.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('258', '2019-12-01 04:12:50', null, '258', '2019-12-01 04:13:34', '2019-12-01 04:14:10', '880.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('259', '2019-12-01 04:13:34', null, '259', '2019-12-01 04:14:19', '2019-12-01 04:14:55', '880.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('260', '2019-12-01 04:14:19', null, '260', '2019-12-01 04:15:03', '2019-12-01 04:15:39', '880.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('261', '2019-12-01 04:15:03', null, '261', '2019-12-01 04:15:47', '2019-12-01 04:16:24', '880.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('262', '2019-12-01 04:15:47', null, '262', '2019-12-01 04:16:32', '2019-12-01 04:17:08', '880.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('263', '2019-12-01 04:16:32', null, '263', '2019-12-01 04:17:16', '2019-12-01 04:17:53', '880.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('264', '2019-12-01 04:17:16', null, '264', '2019-12-01 04:21:31', '2019-12-01 04:21:56', '440.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('265', '2019-12-01 04:21:31', null, '265', '2019-12-01 04:22:04', '2019-12-01 04:22:29', '440.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('266', '2019-12-01 04:22:04', null, '266', '2019-12-01 04:22:37', '2019-12-01 04:23:02', '440.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('267', '2019-12-01 04:22:37', null, '267', '2019-12-01 04:23:10', '2019-12-01 04:23:35', '440.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('268', '2019-12-01 04:23:10', null, '268', '2019-12-01 04:23:43', '2019-12-01 04:24:08', '440.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('269', '2019-12-01 04:23:43', null, '269', '2019-12-01 04:24:16', '2019-12-01 04:24:41', '440.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('270', '2019-12-01 04:24:16', null, '270', '2019-12-01 04:24:49', '2019-12-01 04:25:14', '440.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('271', '2019-12-01 04:24:49', null, '271', '2019-12-01 04:25:22', '2019-12-01 04:25:47', '440.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('272', '2019-12-01 04:25:22', null, '272', '2019-12-01 04:25:55', '2019-12-01 04:26:20', '440.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('273', '2019-12-01 04:25:55', null, '273', '2019-12-01 04:26:28', '2019-12-01 04:26:52', '440.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('274', '2019-12-01 04:26:28', null, '274', '2019-12-01 04:27:01', '2019-12-01 04:27:25', '440.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('275', '2019-12-01 04:27:01', null, '275', '2019-12-01 04:27:34', '2019-12-01 04:27:59', '440.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('276', '2019-12-01 04:27:34', null, '276', '2019-12-01 04:28:07', '2019-12-01 04:28:32', '440.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('277', '2019-12-01 04:28:07', null, '277', '2019-12-01 04:28:40', null, '440.00', '0.0000', '0.0000', '0', '2', '', '0', 'STARTED', null, null);
INSERT INTO `crash_game_total` VALUES ('278', '2019-12-01 04:28:40', null, '278', '2019-12-01 04:28:56', '2019-12-01 04:29:26', '600.00', '0.0000', '0.0000', '0', '0', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('279', '2019-12-01 04:28:56', null, '279', '2019-12-01 04:29:34', '2019-12-01 04:30:04', '600.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('280', '2019-12-01 04:29:34', null, '280', '2019-12-01 04:30:12', '2019-12-01 04:30:42', '600.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('281', '2019-12-01 04:30:12', null, '281', '2019-12-01 04:30:50', '2019-12-01 04:31:20', '600.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('282', '2019-12-01 04:30:50', null, '282', '2019-12-01 04:31:28', '2019-12-01 04:31:58', '600.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('283', '2019-12-01 04:31:28', null, '283', '2019-12-01 04:32:06', '2019-12-01 04:32:36', '600.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('284', '2019-12-01 04:32:07', null, '284', '2019-12-01 04:32:45', '2019-12-01 04:33:14', '600.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('285', '2019-12-01 04:32:45', null, '285', '2019-12-01 04:33:23', '2019-12-01 04:33:53', '600.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('286', '2019-12-01 04:33:23', null, '286', '2019-12-01 04:34:01', '2019-12-01 04:34:31', '600.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('287', '2019-12-01 04:34:01', null, '287', '2019-12-01 04:34:39', '2019-12-01 04:35:09', '600.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('288', '2019-12-01 04:34:39', null, '288', '2019-12-01 04:35:17', null, '600.00', '0.0000', '0.0000', '0', '2', '', '0', 'STARTED', null, null);
INSERT INTO `crash_game_total` VALUES ('289', '2019-12-01 04:35:17', null, '289', '2019-12-01 04:37:39', '2019-12-01 04:38:09', '600.00', '0.0000', '0.0000', '0', '0', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('290', '2019-12-01 04:37:39', null, '290', '2019-12-01 04:38:17', '2019-12-01 04:38:48', '600.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('291', '2019-12-01 04:38:17', null, '291', '2019-12-01 04:38:56', '2019-12-01 04:39:26', '600.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('292', '2019-12-01 04:38:56', null, '292', '2019-12-01 04:39:34', '2019-12-01 04:40:04', '600.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('293', '2019-12-01 04:39:34', null, '293', '2019-12-01 04:40:12', '2019-12-01 04:40:42', '600.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('294', '2019-12-01 04:40:12', null, '294', '2019-12-01 04:40:50', '2019-12-01 04:41:20', '600.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('295', '2019-12-01 04:40:50', null, '295', '2019-12-01 04:41:29', '2019-12-01 04:41:58', '600.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('296', '2019-12-01 04:41:29', null, '296', '2019-12-01 04:42:07', '2019-12-01 04:42:37', '600.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('297', '2019-12-01 04:42:07', null, '297', '2019-12-01 04:42:45', '2019-12-01 04:43:15', '600.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('298', '2019-12-01 04:42:45', null, '298', '2019-12-01 04:43:23', '2019-12-01 04:43:53', '600.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('299', '2019-12-01 04:43:23', null, '299', '2019-12-01 04:44:01', '2019-12-01 04:44:31', '600.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('300', '2019-12-01 04:44:01', null, '300', '2019-12-01 04:44:39', '2019-12-01 04:45:09', '600.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('301', '2019-12-01 04:44:39', null, '301', '2019-12-01 04:45:17', '2019-12-01 04:45:47', '600.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('302', '2019-12-01 04:45:17', null, '302', '2019-12-01 04:45:55', '2019-12-01 04:46:25', '600.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('303', '2019-12-01 04:45:55', null, '303', '2019-12-01 04:46:33', '2019-12-01 04:47:03', '600.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('304', '2019-12-01 04:46:33', null, '304', '2019-12-01 04:47:11', null, '600.00', '0.0000', '0.0000', '0', '2', '', '0', 'STARTED', null, null);
INSERT INTO `crash_game_total` VALUES ('305', '2019-12-01 04:47:11', null, '305', '2019-12-01 04:47:34', '2019-12-01 04:47:38', '120.00', '0.0000', '0.0000', '0', '0', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('306', '2019-12-01 04:47:35', null, '306', '2019-12-01 04:47:46', '2019-12-01 04:47:49', '120.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('307', '2019-12-01 04:47:46', null, '307', '2019-12-01 04:47:57', null, '120.00', '0.0000', '0.0000', '0', '2', '', '0', 'STARTED', null, null);
INSERT INTO `crash_game_total` VALUES ('308', '2019-12-01 04:47:57', null, '308', '2019-12-02 06:04:16', '2019-12-02 06:04:19', '120.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('309', '2019-12-02 06:04:16', null, '309', '2019-12-02 06:04:27', '2019-12-02 06:04:30', '120.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('310', '2019-12-02 06:04:27', null, '310', '2019-12-02 06:04:38', '2019-12-02 06:04:42', '120.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('311', '2019-12-02 06:04:38', null, '311', '2019-12-02 06:04:50', '2019-12-02 06:04:53', '120.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('312', '2019-12-02 06:04:50', null, '312', '2019-12-02 06:05:01', null, '120.00', '0.0000', '0.0000', '0', '2', '', '0', 'STARTED', null, null);
INSERT INTO `crash_game_total` VALUES ('313', '2019-12-02 06:05:01', null, '313', '2019-12-02 06:05:08', '2019-12-02 06:05:37', '550.00', '0.0000', '0.0000', '0', '0', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('314', '2019-12-02 06:05:08', null, '314', '2019-12-02 06:05:45', '2019-12-02 06:06:14', '550.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('315', '2019-12-02 06:05:45', null, '315', '2019-12-02 06:06:22', '2019-12-02 06:06:50', '550.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('316', '2019-12-02 06:06:22', null, '316', '2019-12-02 06:06:59', '2019-12-02 06:07:27', '550.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('317', '2019-12-02 06:06:59', null, '317', '2019-12-02 06:07:35', '2019-12-02 06:08:04', '550.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('318', '2019-12-02 06:07:35', null, '318', '2019-12-02 06:08:12', '2019-12-02 06:08:40', '550.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('319', '2019-12-02 06:08:12', null, '319', '2019-12-02 06:08:48', '2019-12-02 06:09:17', '550.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('320', '2019-12-02 06:08:48', null, '320', '2019-12-02 06:09:25', '2019-12-02 06:09:54', '550.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('321', '2019-12-02 06:09:25', null, '321', '2019-12-02 06:10:02', '2019-12-02 06:10:30', '550.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('322', '2019-12-02 06:10:02', null, '322', '2019-12-02 06:10:38', '2019-12-02 06:11:07', '550.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('323', '2019-12-02 06:10:38', null, '323', '2019-12-02 06:11:15', '2019-12-02 06:11:44', '550.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('324', '2019-12-02 06:11:15', null, '324', '2019-12-02 06:11:52', null, '550.00', '0.0000', '0.0000', '0', '2', '', '0', 'STARTED', null, null);
INSERT INTO `crash_game_total` VALUES ('325', '2019-12-02 06:11:52', null, '325', '2019-12-04 06:45:59', '2019-12-04 06:46:14', '231.00', '0.0000', '0.0000', '0', '0', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('326', '2019-12-04 06:46:00', null, '326', '2019-12-04 06:46:22', '2019-12-04 06:46:23', '109.00', '0.0000', '100.0000', '1', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('327', '2019-12-04 06:46:22', null, '327', '2019-12-04 06:46:31', '2019-12-04 06:47:00', '538.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('328', '2019-12-04 06:46:31', null, '328', '2019-12-04 06:47:08', '2019-12-04 06:47:25', '274.00', '0.0000', '-17.0000', '1', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('329', '2019-12-04 06:47:08', null, '329', '2019-12-04 06:47:33', '2019-12-04 06:47:45', '202.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('330', '2019-12-04 06:47:33', null, '330', '2019-12-04 06:47:53', '2019-12-04 06:48:15', '391.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('331', '2019-12-04 06:47:53', null, '331', '2019-12-04 06:48:24', '2019-12-04 06:48:29', '138.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('332', '2019-12-04 06:48:24', null, '332', '2019-12-04 06:48:37', '2019-12-04 06:49:00', '381.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('333', '2019-12-04 06:48:37', null, '333', '2019-12-04 06:49:08', '2019-12-04 06:49:14', '142.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('334', '2019-12-04 06:49:08', null, '334', '2019-12-04 06:49:22', '2019-12-04 06:49:43', '360.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('335', '2019-12-04 06:49:22', null, '335', '2019-12-04 06:49:51', '2019-12-04 06:49:58', '148.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('336', '2019-12-04 06:49:51', null, '336', '2019-12-04 06:50:06', '2019-12-04 06:50:06', '103.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('337', '2019-12-04 06:50:06', null, '337', '2019-12-04 06:50:15', '2019-12-04 06:50:38', '412.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('338', '2019-12-04 06:50:15', null, '338', '2019-12-04 06:50:46', '2019-12-04 06:51:10', '401.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('339', '2019-12-04 06:50:46', null, '339', '2019-12-04 06:51:18', '2019-12-04 06:51:40', '374.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('340', '2019-12-04 06:51:18', null, '340', '2019-12-04 06:51:48', '2019-12-04 06:51:50', '117.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('341', '2019-12-04 06:51:48', null, '341', '2019-12-04 06:51:59', '2019-12-04 06:52:01', '118.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('342', '2019-12-04 06:51:59', null, '342', '2019-12-04 06:52:10', '2019-12-04 06:52:26', '273.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('343', '2019-12-04 06:52:10', null, '343', '2019-12-04 06:52:34', '2019-12-04 06:52:41', '149.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('344', '2019-12-04 06:52:34', null, '344', '2019-12-04 06:52:49', '2019-12-04 06:52:55', '141.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('345', '2019-12-04 06:52:49', null, '345', '2019-12-04 06:53:03', '2019-12-04 06:53:39', '847.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('346', '2019-12-04 06:53:03', null, '346', '2019-12-04 06:53:47', '2019-12-04 06:54:13', '476.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('347', '2019-12-04 06:53:47', null, '347', '2019-12-04 06:54:21', '2019-12-04 06:54:30', '167.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('348', '2019-12-04 06:54:21', null, '348', '2019-12-04 06:54:38', '2019-12-04 06:54:42', '131.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('349', '2019-12-04 06:54:38', null, '349', '2019-12-04 06:54:51', '2019-12-04 06:55:05', '237.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('350', '2019-12-04 06:54:51', null, '350', '2019-12-04 06:55:13', '2019-12-04 06:55:24', '191.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('351', '2019-12-04 06:55:13', null, '351', '2019-12-04 06:55:32', '2019-12-04 06:55:58', '473.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('352', '2019-12-04 06:55:32', null, '352', '2019-12-04 06:56:06', '2019-12-04 06:56:07', '103.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('353', '2019-12-04 06:56:06', null, '353', '2019-12-04 06:56:15', '2019-12-04 06:56:20', '131.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('354', '2019-12-04 06:56:15', null, '354', '2019-12-04 06:56:28', '2019-12-04 06:56:34', '148.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('355', '2019-12-04 06:56:28', null, '355', '2019-12-04 06:56:42', '2019-12-04 06:56:49', '150.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('356', '2019-12-04 06:56:42', null, '356', '2019-12-04 06:56:57', '2019-12-04 06:57:17', '324.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('357', '2019-12-04 06:56:57', null, '357', '2019-12-04 06:57:25', '2019-12-04 06:57:40', '249.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('358', '2019-12-04 06:57:25', null, '358', '2019-12-04 06:57:49', '2019-12-04 06:58:12', '401.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('359', '2019-12-04 06:57:49', null, '359', '2019-12-04 06:58:20', '2019-12-04 06:58:23', '122.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('360', '2019-12-04 06:58:20', null, '360', '2019-12-04 06:58:31', '2019-12-04 06:58:40', '170.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('361', '2019-12-04 06:58:31', null, '361', '2019-12-04 06:58:48', '2019-12-04 06:59:06', '289.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('362', '2019-12-04 06:58:48', null, '362', '2019-12-04 06:59:14', '2019-12-04 07:00:11', '3062.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('363', '2019-12-04 06:59:14', null, '363', '2019-12-04 07:00:19', '2019-12-04 07:00:31', '196.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('364', '2019-12-04 07:00:19', null, '364', '2019-12-04 07:00:39', '2019-12-04 07:00:49', '183.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('365', '2019-12-04 07:00:39', null, '365', '2019-12-04 07:00:57', '2019-12-04 07:01:08', '194.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('366', '2019-12-04 07:00:57', null, '366', '2019-12-04 07:01:16', '2019-12-04 07:01:25', '163.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('367', '2019-12-04 07:01:16', null, '367', '2019-12-04 07:01:33', '2019-12-04 07:01:33', '103.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('368', '2019-12-04 07:01:33', null, '368', '2019-12-04 07:01:41', '2019-12-04 07:02:12', '620.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('369', '2019-12-04 07:01:41', null, '369', '2019-12-04 07:02:20', '2019-12-04 07:02:31', '196.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('370', '2019-12-04 07:02:20', null, '370', '2019-12-04 07:02:39', '2019-12-04 07:02:43', '123.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('371', '2019-12-04 07:02:39', null, '371', '2019-12-04 07:02:51', '2019-12-04 07:03:12', '344.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('372', '2019-12-04 07:02:51', null, '372', '2019-12-04 07:03:20', '2019-12-04 07:03:25', '139.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('373', '2019-12-04 07:03:20', null, '373', '2019-12-04 07:03:33', '2019-12-04 07:04:18', '1489.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('374', '2019-12-04 07:03:33', null, '374', '2019-12-04 07:04:27', '2019-12-04 07:04:29', '118.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('375', '2019-12-04 07:04:27', null, '375', '2019-12-04 07:04:38', '2019-12-04 07:04:51', '220.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('376', '2019-12-04 07:04:38', null, '376', '2019-12-04 07:04:59', '2019-12-04 07:05:38', '1019.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('377', '2019-12-04 07:04:59', null, '377', '2019-12-04 07:05:46', '2019-12-04 07:05:54', '156.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('378', '2019-12-04 07:05:46', null, '378', '2019-12-04 07:06:02', '2019-12-04 07:07:10', '6000.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('379', '2019-12-04 07:06:02', null, '379', '2019-12-04 07:07:18', '2019-12-04 07:07:23', '129.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('380', '2019-12-04 07:07:18', null, '380', '2019-12-04 07:07:31', '2019-12-04 07:07:51', '338.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('381', '2019-12-04 07:07:31', null, '381', '2019-12-04 07:07:59', '2019-12-04 07:08:28', '561.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('382', '2019-12-04 07:07:59', null, '382', '2019-12-04 08:47:40', '2019-12-04 08:47:54', '231.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('383', '2019-12-04 08:47:40', null, '383', '2019-12-04 08:48:02', '2019-12-04 08:48:04', '109.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('384', '2019-12-04 08:48:02', null, '384', '2019-12-04 08:48:12', '2019-12-04 08:48:40', '538.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('385', '2019-12-04 08:48:12', null, '385', '2019-12-04 08:48:48', '2019-12-04 08:49:05', '274.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('386', '2019-12-04 08:48:48', null, '386', '2019-12-04 08:49:13', '2019-12-04 08:49:25', '202.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('387', '2019-12-04 08:49:13', null, '387', '2019-12-04 08:49:33', '2019-12-04 08:49:56', '391.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('388', '2019-12-04 08:49:33', null, '388', '2019-12-04 08:50:04', '2019-12-04 08:50:10', '138.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('389', '2019-12-04 08:50:04', null, '389', '2019-12-04 08:50:18', '2019-12-04 08:50:40', '381.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('390', '2019-12-04 08:50:18', null, '390', '2019-12-04 08:50:48', '2019-12-04 08:50:54', '142.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('391', '2019-12-04 08:50:48', null, '391', '2019-12-04 08:51:02', '2019-12-04 08:51:24', '360.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('392', '2019-12-04 08:51:02', null, '392', '2019-12-04 08:51:32', '2019-12-04 08:51:39', '148.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('393', '2019-12-04 08:51:32', null, '393', '2019-12-04 08:51:47', '2019-12-04 08:51:47', '103.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('394', '2019-12-04 08:51:47', null, '394', '2019-12-04 08:51:55', '2019-12-04 08:52:19', '412.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('395', '2019-12-04 08:51:55', null, '395', '2019-12-04 08:52:27', '2019-12-04 08:52:50', '401.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('396', '2019-12-04 08:52:27', null, '396', '2019-12-04 08:52:58', '2019-12-04 08:53:21', '374.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('397', '2019-12-04 08:52:59', null, '397', '2019-12-04 08:53:29', '2019-12-04 08:53:31', '117.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('398', '2019-12-04 08:53:29', null, '398', '2019-12-04 08:53:39', '2019-12-04 08:53:42', '118.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('399', '2019-12-04 08:53:40', null, '399', '2019-12-04 08:53:50', '2019-12-04 08:54:07', '273.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('400', '2019-12-04 08:53:50', null, '400', '2019-12-04 08:54:15', '2019-12-04 08:54:22', '149.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('401', '2019-12-04 08:54:15', null, '401', '2019-12-04 08:54:30', '2019-12-04 08:54:36', '141.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('402', '2019-12-04 08:54:30', null, '402', '2019-12-04 08:54:44', '2019-12-04 08:55:20', '847.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('403', '2019-12-04 08:54:44', null, '403', '2019-12-04 08:55:28', '2019-12-04 08:55:54', '476.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('404', '2019-12-04 08:55:28', null, '404', '2019-12-04 08:56:02', '2019-12-04 08:56:11', '167.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('405', '2019-12-04 08:56:02', null, '405', '2019-12-04 08:56:19', '2019-12-04 08:56:23', '131.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('406', '2019-12-04 08:56:19', null, '406', '2019-12-04 08:56:31', '2019-12-04 08:56:46', '237.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('407', '2019-12-04 08:56:31', null, '407', '2019-12-04 08:56:54', '2019-12-04 08:57:05', '191.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('408', '2019-12-04 08:56:54', null, '408', '2019-12-04 08:57:13', '2019-12-04 08:57:39', '473.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('409', '2019-12-04 08:57:13', null, '409', '2019-12-04 08:57:47', '2019-12-04 08:57:48', '103.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('410', '2019-12-04 08:57:47', null, '410', '2019-12-04 08:57:56', '2019-12-04 08:58:00', '131.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('411', '2019-12-04 08:57:56', null, '411', '2019-12-04 08:58:08', '2019-12-04 08:58:15', '148.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('412', '2019-12-04 08:58:08', null, '412', '2019-12-04 08:58:23', '2019-12-04 08:58:30', '150.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('413', '2019-12-04 08:58:23', null, '413', '2019-12-04 08:58:38', '2019-12-04 08:58:58', '324.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('414', '2019-12-04 08:58:38', null, '414', '2019-12-04 08:59:06', '2019-12-04 08:59:21', '249.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('415', '2019-12-04 08:59:06', null, '415', '2019-12-04 08:59:29', '2019-12-04 08:59:53', '401.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('416', '2019-12-04 08:59:30', null, '416', '2019-12-04 09:00:01', '2019-12-04 09:00:04', '122.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('417', '2019-12-04 09:00:01', null, '417', '2019-12-04 09:00:12', '2019-12-04 09:00:21', '170.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('418', '2019-12-04 09:00:12', null, '418', '2019-12-04 09:00:29', '2019-12-04 09:00:47', '289.00', '0.0000', '10.0000', '1', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('419', '2019-12-04 09:00:29', null, '419', '2019-12-04 09:00:55', '2019-12-04 09:01:53', '3062.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('420', '2019-12-04 09:00:55', null, '420', '2019-12-04 09:02:01', '2019-12-04 09:02:12', '196.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('421', '2019-12-04 09:02:01', null, '421', '2019-12-04 09:02:20', '2019-12-04 09:02:30', '183.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('422', '2019-12-04 09:02:20', null, '422', '2019-12-04 09:02:38', '2019-12-04 09:02:49', '194.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('423', '2019-12-04 09:02:38', null, '423', '2019-12-04 09:02:57', '2019-12-04 09:03:06', '163.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('424', '2019-12-04 09:02:57', null, '424', '2019-12-04 09:03:14', '2019-12-04 09:03:14', '103.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('425', '2019-12-04 09:03:14', null, '425', '2019-12-04 09:03:22', '2019-12-04 09:03:53', '620.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('426', '2019-12-04 09:03:23', null, '426', '2019-12-04 09:04:01', '2019-12-04 09:04:12', '196.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('427', '2019-12-04 09:04:01', null, '427', '2019-12-04 09:04:20', '2019-12-04 09:04:24', '123.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('428', '2019-12-04 09:04:20', null, '428', '2019-12-04 09:04:32', '2019-12-04 09:04:53', '344.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('429', '2019-12-04 09:04:32', null, '429', '2019-12-04 09:05:01', '2019-12-04 09:05:06', '139.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('430', '2019-12-04 09:05:01', null, '430', '2019-12-04 09:05:15', '2019-12-04 09:06:00', '1489.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('431', '2019-12-04 09:05:15', null, '431', '2019-12-04 09:06:08', '2019-12-04 09:06:11', '118.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('432', '2019-12-04 09:06:08', null, '432', '2019-12-04 09:06:19', '2019-12-04 09:06:32', '220.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('433', '2019-12-04 09:06:19', null, '433', '2019-12-04 09:06:40', '2019-12-04 09:07:19', '1019.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('434', '2019-12-04 09:06:40', null, '434', '2019-12-04 09:07:27', '2019-12-04 09:07:34', '156.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('435', '2019-12-04 09:07:27', null, '435', '2019-12-04 09:07:43', null, '6000.00', '0.0000', '0.0000', '0', '2', '', '0', 'STARTED', null, null);
INSERT INTO `crash_game_total` VALUES ('436', '2019-12-04 09:07:43', null, '436', '2019-12-04 12:02:53', '2019-12-04 12:03:07', '231.00', '0.0000', '0.0000', '0', '0', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('437', '2019-12-04 12:02:53', null, '437', '2019-12-04 12:03:15', '2019-12-04 12:03:17', '109.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('438', '2019-12-04 12:03:15', null, '438', '2019-12-04 12:03:25', '2019-12-04 12:03:53', '538.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('439', '2019-12-04 12:03:25', null, '439', '2019-12-04 12:04:01', null, '274.00', '0.0000', '0.0000', '0', '2', '', '0', 'STARTED', null, null);
INSERT INTO `crash_game_total` VALUES ('440', '2019-12-04 12:04:01', null, '440', '2019-12-04 12:06:02', '2019-12-04 12:06:16', '231.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('441', '2019-12-04 12:06:02', null, '441', '2019-12-04 12:06:24', '2019-12-04 12:06:26', '109.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('442', '2019-12-04 12:06:24', null, '442', '2019-12-04 12:06:34', '2019-12-04 12:07:02', '538.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('443', '2019-12-04 12:06:34', null, '443', '2019-12-04 12:07:10', '2019-12-04 12:07:27', '274.00', '0.0000', '1111.0000', '1', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('444', '2019-12-04 12:07:10', null, '444', '2019-12-04 12:07:35', '2019-12-04 12:07:47', '202.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('445', '2019-12-04 12:07:35', null, '445', '2019-12-04 12:07:55', '2019-12-04 12:08:18', '391.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('446', '2019-12-04 12:07:55', null, '446', '2019-12-04 12:08:26', '2019-12-04 12:08:31', '138.00', '0.0000', '0.0000', '0', '2', '', '0', 'BUSTED', null, null);
INSERT INTO `crash_game_total` VALUES ('447', '2019-12-04 12:08:26', null, '447', null, null, '0.00', '0.0000', '0.0000', '0', '1', '', '0', 'WAITING', null, null);

-- ----------------------------
-- Table structure for cron
-- ----------------------------
DROP TABLE IF EXISTS `cron`;
CREATE TABLE `cron` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `CREATE_TIME` int(12) DEFAULT NULL,
  `DATE` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of cron
-- ----------------------------

-- ----------------------------
-- Table structure for jackpot_game
-- ----------------------------
DROP TABLE IF EXISTS `jackpot_game`;
CREATE TABLE `jackpot_game` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'GAME_UNIQ_ID',
  `CREATE_TIME` int(11) DEFAULT NULL,
  `UPDATE_TIME` int(11) DEFAULT NULL,
  `HASH` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `TOTAL_PLAYERS` bigint(20) DEFAULT '0',
  `TOTAL_PROFIT` decimal(20,2) DEFAULT NULL,
  `DEL_YN` char(1) COLLATE utf8_unicode_ci DEFAULT 'N',
  `TOTAL_BETTING_AMOUNT` decimal(20,2) DEFAULT '0.00',
  `WINNER` bigint(10) DEFAULT '0' COMMENT '// the winner',
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of jackpot_game
-- ----------------------------

-- ----------------------------
-- Table structure for jackpot_game_log
-- ----------------------------
DROP TABLE IF EXISTS `jackpot_game_log`;
CREATE TABLE `jackpot_game_log` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `CREATE_TIME` int(11) DEFAULT NULL,
  `UPDATE_TIME` int(11) DEFAULT NULL,
  `BET_AMOUNT` decimal(20,2) DEFAULT NULL,
  `GAMEID` bigint(20) DEFAULT NULL,
  `USERID` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE,
  KEY `FK_ROULETTE_GAME_TO_ROULETTE_GAME_LOG` (`GAMEID`) USING BTREE,
  KEY `FK_USERS_TO_ROULETTE_GAME_LOG` (`USERID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of jackpot_game_log
-- ----------------------------

-- ----------------------------
-- Table structure for ladder_detail
-- ----------------------------
DROP TABLE IF EXISTS `ladder_detail`;
CREATE TABLE `ladder_detail` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `CREATE_TIME` int(11) DEFAULT NULL,
  `UPDATE_TIME` int(11) DEFAULT NULL,
  `DEL_YN` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `BET` decimal(20,2) DEFAULT '0.00',
  `PROFIT` decimal(20,2) DEFAULT '0.00',
  `BET_VALUE` enum('O','E') COLLATE utf8_unicode_ci DEFAULT NULL,
  `USERID` bigint(20) DEFAULT NULL,
  `GAMEID` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE,
  KEY `FK_USERS_TO_LADDER_DETAIL` (`USERID`) USING BTREE,
  KEY `FK_LADDER_TOTAL_TO_LADDER_DETAIL` (`GAMEID`) USING BTREE,
  CONSTRAINT `FK_USERS_TO_LADDER_DETAIL` FOREIGN KEY (`USERID`) REFERENCES `users` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of ladder_detail
-- ----------------------------

-- ----------------------------
-- Table structure for ladder_total
-- ----------------------------
DROP TABLE IF EXISTS `ladder_total`;
CREATE TABLE `ladder_total` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `CREATE_TIME` int(11) DEFAULT NULL,
  `UPDATE_TIME` int(11) DEFAULT NULL,
  `DEL_YN` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'N',
  `START_TIME` int(11) DEFAULT NULL,
  `FINISHED_TIME` int(11) DEFAULT NULL,
  `DATE` date DEFAULT NULL,
  `GAME_NO` int(10) DEFAULT NULL,
  `PROFIT` decimal(20,2) DEFAULT '0.00',
  `STATE` enum('STARTED','FINISHED') COLLATE utf8_unicode_ci DEFAULT 'STARTED',
  `RESULT1` enum('L','R') COLLATE utf8_unicode_ci DEFAULT NULL,
  `RESULT2` enum('3','4') COLLATE utf8_unicode_ci DEFAULT NULL,
  `RESULT3` enum('O','E') COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of ladder_total
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
-- Table structure for roulette_game
-- ----------------------------
DROP TABLE IF EXISTS `roulette_game`;
CREATE TABLE `roulette_game` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'GAME_UNIQ_ID',
  `CREATE_TIME` int(11) DEFAULT NULL,
  `UPDATE_TIME` int(11) DEFAULT NULL,
  `ROLL` int(5) DEFAULT NULL,
  `HASH` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `STATUS` char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  `TOTAL_PLAYERS` bigint(20) DEFAULT '0',
  `TOTAL_PROFIT` decimal(20,2) DEFAULT NULL,
  `DEL_YN` char(1) COLLATE utf8_unicode_ci DEFAULT 'N',
  `BOTS` bigint(10) DEFAULT '0',
  `TOTAL_BETTING_AMOUNT` decimal(20,2) DEFAULT '0.00',
  `WINNER_PLAYERS` bigint(10) DEFAULT '0',
  `TYPE` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT '- red\r\n	- green\r\n	- black',
  `END` tinyint(2) DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of roulette_game
-- ----------------------------

-- ----------------------------
-- Table structure for roulette_game_log
-- ----------------------------
DROP TABLE IF EXISTS `roulette_game_log`;
CREATE TABLE `roulette_game_log` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `CREATE_TIME` int(11) DEFAULT NULL,
  `UPDATE_TIME` int(11) DEFAULT NULL,
  `DEL_YN` char(1) COLLATE utf8_unicode_ci DEFAULT 'N',
  `BET_AMOUNT` decimal(20,2) DEFAULT NULL,
  `TYPE` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL COMMENT 'red , black ,  green\r\n	',
  `WIN` tinyint(4) DEFAULT NULL,
  `GAMEID` bigint(20) DEFAULT NULL,
  `USERID` bigint(20) DEFAULT NULL,
  `PROFIT` decimal(20,2) DEFAULT NULL,
  PRIMARY KEY (`ID`) USING BTREE,
  KEY `FK_ROULETTE_GAME_TO_ROULETTE_GAME_LOG` (`GAMEID`) USING BTREE,
  KEY `FK_USERS_TO_ROULETTE_GAME_LOG` (`USERID`) USING BTREE,
  CONSTRAINT `FK_USERS_TO_ROULETTE_GAME_LOG` FOREIGN KEY (`USERID`) REFERENCES `users` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT;

-- ----------------------------
-- Records of roulette_game_log
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
INSERT INTO `users` VALUES ('1', 'Test Account', 'b59c67bf196a4758191e42f76670ceba', 'test@test.com', null, '1558829905', 'N', '0.0.0.0', 'Y', '0', null, '', 'http://localhost:7900/assets/user/images/avatar/profile.png', 'http://localhost:7900/assets/user/images/avatar/profile1.png', 'N', null, 'LEVEL1', '::1', '2263869.06', 'kwOVz7xSJ92UUO9ZGPeC8q6K', '183515.00', '2080354.06');
INSERT INTO `users` VALUES ('2', 'Michale Jackson', 'b59c67bf196a4758191e42f76670ceba', 'Michale@test.com', null, null, 'N', '0.0.0.0', 'N', '0', null, null, 'http://localhost:7900/assets/user/images/avatar/img6.jpg', 'http://localhost:7900/assets/user/images/avatar/img6.jpg', 'N', null, 'LEVEL1', '::1', '1099440.00', 'EIG1dndwHsw7bbsMgglY2V1E', '-74024.00', '1173464.00');
SET FOREIGN_KEY_CHECKS=1;
