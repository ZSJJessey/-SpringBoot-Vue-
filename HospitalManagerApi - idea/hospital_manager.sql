-- MySQL dump 10.13  Distrib 8.0.12, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: hospital_manager
-- ------------------------------------------------------
-- Server version	8.0.12

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `admini`
--

DROP TABLE IF EXISTS `admini`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `admini` (
  `a_id` int(11) NOT NULL,
  `a_password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a_gender` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a_card` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a_phone` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `a_email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  PRIMARY KEY (`a_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admini`
--

LOCK TABLES `admini` WRITE;
/*!40000 ALTER TABLE `admini` DISABLE KEYS */;
INSERT INTO `admini` VALUES (3000,'123456','admin','男','440111111111111111','13544444444','123@qq.com');
/*!40000 ALTER TABLE `admini` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `arrange`
--

DROP TABLE IF EXISTS `arrange`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `arrange` (
  `ar_id` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `ar_time` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `d_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`ar_id`) USING BTREE,
  KEY `arTOd` (`d_id`) USING BTREE,
  CONSTRAINT `arTOd` FOREIGN KEY (`d_id`) REFERENCES `doctor` (`d_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `arrange`
--

LOCK TABLES `arrange` WRITE;
/*!40000 ALTER TABLE `arrange` DISABLE KEYS */;
INSERT INTO `arrange` VALUES ('20012025-03-04','2025-03-04',2001),('20012025-03-05','2025-03-05',2001),('20012025-03-08','2025-03-08',2001),('20012025-03-09','2025-03-09',2001),('20022025-03-04','2025-03-04',2002),('20022025-03-06','2025-03-06',2002),('20022025-03-08','2025-03-08',2002),('20022025-03-09','2025-03-09',2002),('20032025-03-08','2025-03-08',2003);
/*!40000 ALTER TABLE `arrange` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bed`
--

DROP TABLE IF EXISTS `bed`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `bed` (
  `b_id` int(11) NOT NULL,
  `p_id` int(11) DEFAULT NULL,
  `b_state` int(11) DEFAULT NULL,
  `b_start` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `d_id` int(11) DEFAULT NULL,
  `b_reason` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  PRIMARY KEY (`b_id`) USING BTREE,
  KEY `bTOp` (`p_id`) USING BTREE,
  KEY `bTOd` (`d_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bed`
--

LOCK TABLES `bed` WRITE;
/*!40000 ALTER TABLE `bed` DISABLE KEYS */;
INSERT INTO `bed` VALUES (10,2000,1,'2025-01-19',1000,'23424',NULL),(2001,1000,1,'2025-03-08',2003,'、失眠头疼,出现了失眠、多梦、疲倦、头痛等情况考虑有可能是内分泌失调',NULL);
/*!40000 ALTER TABLE `bed` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `checks`
--

DROP TABLE IF EXISTS `checks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `checks` (
  `ch_id` int(11) NOT NULL AUTO_INCREMENT,
  `ch_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `ch_price` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`ch_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `checks`
--

LOCK TABLES `checks` WRITE;
/*!40000 ALTER TABLE `checks` DISABLE KEYS */;
INSERT INTO `checks` VALUES (1,'B超',201.00),(2,'CT',435.00),(3,'核磁共振',653.00),(4,'MRI',534.00),(5,'心电图',634.00),(6,'彩超',213.00),(7,'血常规',434.00),(8,'肝功能',543.00),(9,'血糖',434.00),(10,'甲状腺',434.00),(11,'视力',50.00);
/*!40000 ALTER TABLE `checks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctor`
--

DROP TABLE IF EXISTS `doctor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `doctor` (
  `d_id` int(11) NOT NULL,
  `d_password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `d_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `d_gender` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `d_phone` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `d_card` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `d_email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `d_post` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `d_introduction` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `d_section` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `d_state` int(11) NOT NULL,
  `d_price` decimal(10,2) DEFAULT NULL,
  `d_people` int(11) DEFAULT NULL,
  `d_star` decimal(10,2) DEFAULT NULL,
  `d_avg_star` decimal(10,2) DEFAULT NULL,
  `d_avatar_url` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`d_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctor`
--

LOCK TABLES `doctor` WRITE;
/*!40000 ALTER TABLE `doctor` DISABLE KEYS */;
INSERT INTO `doctor` VALUES (2001,'7182d8b34a5e882d7bee8ae225484a3e','张伟','男','13211111111','111111111111111','123@qq.com','副主任医师','http://localhost:9282/#/doctorList钻研学习医学科学技术，挽救生命以治病为业的人，一般指临床医师。2014年调查显示月入过万者仅占6.15%。按照卫生部、卫健委、医政部有关医疗卫生管理条例的法律法规，主持医患沟通，学术讨论，新技术推广、预后分析、公众教育、护理示教、康复','神经内科',1,20.00,10,46.00,4.60,'fde4adb8-2721-4363-9b7f-05d1d6766495.jpg'),(2002,'7182d8b34a5e882d7bee8ae225484a3e','李建','男','13111111111','111111111111111','123@qq.com','副主任医师','青霉素可用于治疗多种细菌感染。主要针对某些链球菌、肺炎链球菌和未产生耐药性的金黄色葡萄球菌引发的疾病，但需注意目前超过90%的金黄色葡萄球菌会让青霉素','神经内科',1,12.00,1,2.00,2.00,'742a91a5-2d63-489f-8c3c-4ded883f8096.jpg'),(2003,'3d7dd7b26500bd0595573b651d0080fd','扁鹊','男','18211111111','642141121245454',NULL,'主治医生','钻研学习医学科学技术，挽救生命以治病为业的人，一般指临床医师。2014年调查显示月入过万者仅占6.15%。按照卫生部、卫健委、医政部有关医疗卫生管理条例的法律法规，主持医患沟通，学术讨论，新技术推广、预后分析、公众教育、护理示教、康复','内分泌科',1,20.00,2,8.00,4.00,'2461f2a9-2b1a-467a-81c1-7a72142a0904.jpg');
/*!40000 ALTER TABLE `doctor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `drug`
--

DROP TABLE IF EXISTS `drug`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `drug` (
  `dr_id` int(11) NOT NULL AUTO_INCREMENT,
  `dr_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `dr_price` decimal(10,2) DEFAULT NULL,
  `dr_number` int(11) DEFAULT NULL,
  `dr_publisher` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `dr_unit` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `d_avatar_url` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`dr_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `drug`
--

LOCK TABLES `drug` WRITE;
/*!40000 ALTER TABLE `drug` DISABLE KEYS */;
INSERT INTO `drug` VALUES (1,'青霉素',50.00,96,'西安制药厂','盒','f568743d-ed95-4825-9b27-8e2fe910f71c.jpg'),(2,'苯唑西林',11.00,26,'国家医药局','盒','49bd5bcd-ccc3-48e9-83ff-94625265e7f6.jpg'),(3,'氨苄西林',13.00,50,'国家医药局','袋','36ecea86-2d05-40a0-9d68-5fb3455d7e2a.jpg'),(4,'哌拉西林',2.00,6,'国家医药局','盒','6694f489-0ae5-48a6-b633-b62f7e7990f2.jpg'),(5,'阿莫西林',13.00,20,'国家医药局','盒','527fdaea-49fa-44e8-ac84-2763399f924f.jpg'),(6,'头孢唑林',3.00,31,'国家医药局','盒','8dea1c7b-432c-4262-8767-ef1f9b4d21e1.jpg'),(7,'头孢氨苄',4.00,43,'国家医药局','盒','98c9ffe5-f449-4f0c-821b-10eeecf17065.jpg'),(8,'头孢呋辛',8.00,54,'国家医药局','盒','98c9ffe5-f449-4f0c-821b-10eeecf17065.jpg'),(9,'阿米卡星',5.00,53,'国家医药局','袋','098fbd4a-f0bd-4c66-b623-e1c78f3707ca.jpg'),(10,'庆大霉素',10.00,64,'国家医药局','袋',NULL),(11,'红霉素',6.00,73,'国家医药局','袋',NULL),(12,'阿奇霉素',54.00,52,'国家医药局','袋',NULL),(13,'克林霉素',65.00,21,'国家医药局','袋',NULL),(14,'复方磺胺甲噁唑',76.00,54,'国家医药局','袋',NULL),(15,'诺氟沙星',65.00,32,'国家医药局','袋',NULL),(16,'左氧氟沙星',76.00,43,'国家医药局','袋',NULL),(17,'感康',15.00,10,'感康集团','盒',NULL),(20,'盐酸多尼',20.00,1,'士大夫士大夫撒旦飞洒地方','盒','58246b5d-e7e3-4003-84f9-ef204ed3341a.jpg');
/*!40000 ALTER TABLE `drug` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `message`
--

DROP TABLE IF EXISTS `message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `message` (
  `mid` int(11) NOT NULL AUTO_INCREMENT,
  `message` varchar(200) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  `did` int(11) DEFAULT NULL,
  `pid` int(11) NOT NULL,
  `has_read` tinyint(1) DEFAULT '0',
  `send_time` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`mid`)
) ENGINE=MyISAM AUTO_INCREMENT=92 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci COMMENT='消息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `message`
--

LOCK TABLES `message` WRITE;
/*!40000 ALTER TABLE `message` DISABLE KEYS */;
INSERT INTO `message` VALUES (90,'1000医生需要给2000安排病床',1000,2000,1,'2025-01-19 23:12:46'),(91,'2003医生需要给1000安排病床',2003,1000,1,'2025-03-08 17:30:24');
/*!40000 ALTER TABLE `message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `orders` (
  `o_id` int(11) NOT NULL AUTO_INCREMENT,
  `p_id` int(11) DEFAULT NULL,
  `d_id` int(11) DEFAULT NULL,
  `o_record` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `o_start` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `o_end` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `o_state` int(11) DEFAULT NULL,
  `o_drug` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `o_check` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `o_total_price` decimal(10,2) DEFAULT NULL,
  `o_price_state` int(11) DEFAULT NULL,
  `o_advice` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `p_name` varchar(100) DEFAULT NULL,
  `d_section` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`o_id`) USING BTREE,
  KEY `oTOp` (`p_id`) USING BTREE,
  KEY `0TOd` (`d_id`) USING BTREE,
  CONSTRAINT `0TOd` FOREIGN KEY (`d_id`) REFERENCES `doctor` (`d_id`),
  CONSTRAINT `oTOp` FOREIGN KEY (`p_id`) REFERENCES `patient` (`p_id`)
) ENGINE=InnoDB AUTO_INCREMENT=211209 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
INSERT INTO `orders` VALUES (3178,1000,2002,'电饭煲v的撒个','2025-03-09 10:30-11:30','2025-03-09 10:36:3',1,'诺氟沙星*65(元)*1  药物总价65元 ','B超*201(元)  项目总价201元 ',0.00,1,NULL,'张三','神经内科'),(3253,2000,2001,'送达方式打发撒的发撒的发撒的发撒发撒发生的发','2025-03-05 10:30-11:30','2025-03-05 10:44:39',1,'青霉素*50(元)*1  药物总价50元 ','B超*201(元)  项目总价201元 ',251.00,1,NULL,'患者1','神经内科'),(4549,1000,2003,'失眠头疼,出现了失眠、多梦、疲倦、头痛等情况考虑有可能是内分泌失调','2025-03-08 16:30-17:30','2025-03-08 17:28:49',1,'红霉素*6(元)*1 阿米卡星*5(元)*1  药物总价11元 ','彩超*213(元) 甲状腺*434(元)  项目总价647元 ',0.00,1,NULL,'张三','内分泌科'),(11350,2000,2001,'阿飞湿答答收复失地','2025-03-05 10:30-11:30','2025-03-05 10:46:20',1,'苯唑西林*11(元)*1 氨苄西林*13(元)*1  药物总价24元 ','B超*201(元)  项目总价201元 ',0.00,1,NULL,'患者1','神经内科');
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `patient`
--

DROP TABLE IF EXISTS `patient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `patient` (
  `p_id` int(11) NOT NULL,
  `p_password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `p_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `p_gender` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `p_phone` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `p_card` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `p_email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `p_state` int(11) DEFAULT NULL,
  `p_birthday` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `p_age` int(11) DEFAULT NULL,
  PRIMARY KEY (`p_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient`
--

LOCK TABLES `patient` WRITE;
/*!40000 ALTER TABLE `patient` DISABLE KEYS */;
INSERT INTO `patient` VALUES (1000,'7182d8b34a5e882d7bee8ae225484a3e','张三','男','15337777777','111111111111111',NULL,1,'2013-03-05',12),(2000,'7182d8b34a5e882d7bee8ae225484a3e','患者1','男','13511111111','123123123123213','12321@qq.com',1,'2020-03-05',4),(2001,'7182d8b34a5e882d7bee8ae225484a3e','患者2','女','13412345678','121321321312134','123@qq.comm',1,'2020-02-04',4),(2002,'7182d8b34a5e882d7bee8ae225484a3e','患者3','男','13211111111','111111111111111','111@qq.com',1,'2024-12-20',0),(3002,'7182d8b34a5e882d7bee8ae225484a3e','患者4','女','13211111111','111111111111111','123124@qq.com',0,'2020-02-05',5);
/*!40000 ALTER TABLE `patient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `person`
--

DROP TABLE IF EXISTS `person`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `person` (
  `birthday` date DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `person`
--

LOCK TABLES `person` WRITE;
/*!40000 ALTER TABLE `person` DISABLE KEYS */;
INSERT INTO `person` VALUES ('2000-01-01'),('2000-02-01');
/*!40000 ALTER TABLE `person` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-03-08 17:46:51
