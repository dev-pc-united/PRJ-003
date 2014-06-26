/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50616
Source Host           : localhost:3306
Source Database       : pietpaulusma

Target Server Type    : MYSQL
Target Server Version : 50616
File Encoding         : 65001

Date: 2014-06-26 18:39:14
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `weatherdata`
-- ----------------------------
DROP TABLE IF EXISTS `weatherdata`;
CREATE TABLE `weatherdata` (
  `weatherdata_id` int(12) NOT NULL AUTO_INCREMENT,
  `weatherdata_city_id` int(12) NOT NULL,
  `weatherdata_temp` int(4) NOT NULL,
  `weatherdata_temp_min` int(4) DEFAULT NULL,
  `weatherdata_temp_max` int(4) DEFAULT NULL,
  `weatherdata_pressure` int(12) NOT NULL,
  `weatherdata_wind_speed` int(12) NOT NULL,
  `weatherdata_wind_deg` int(12) NOT NULL,
  `weatherdata_clouds` int(3) NOT NULL,
  `weatherdata_rain` int(5) DEFAULT NULL,
  `weatherdata_snow` int(5) DEFAULT NULL,
  `weatherdata_weather` int(5) DEFAULT NULL,
  `weatherdata_date` date NOT NULL,
  PRIMARY KEY (`weatherdata_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of weatherdata
-- ----------------------------
INSERT INTO `weatherdata` VALUES ('1', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '2014-06-09');
INSERT INTO `weatherdata` VALUES ('2', '9', '8', '7', '6', '5', '4', '3', '2', '1', '0', '10', '2014-06-10');
