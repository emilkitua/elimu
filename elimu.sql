-- MySQL dump 10.13  Distrib 5.7.9, for Win64 (x86_64)
--
-- Host: localhost    Database: elimu
-- ------------------------------------------------------
-- Server version	5.7.9

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin` (
  `admin_id` int(255) NOT NULL AUTO_INCREMENT,
  `school_id` int(10) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `ip_add` varchar(50) NOT NULL,
  `lastlogin` varchar(50) NOT NULL,
  `position` varchar(50) NOT NULL,
  PRIMARY KEY (`admin_id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES (1,7,'admin','a8f5f167f44f4964e6c998dee827110c','1','2016-09-07 12:37:46','Administrator'),(8,7,'test','a8f5f167f44f4964e6c998dee827110c','','2016-09-07 12:12:38','admin');
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `classes`
--

DROP TABLE IF EXISTS `classes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `classes` (
  `class_id` int(255) NOT NULL AUTO_INCREMENT,
  `school_id` int(10) NOT NULL,
  `level` varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL,
  `stream` varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL,
  `teacher` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `active` tinyint(1) DEFAULT '1',
  `time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`class_id`)
) ENGINE=MyISAM AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `classes`
--

LOCK TABLES `classes` WRITE;
/*!40000 ALTER TABLE `classes` DISABLE KEYS */;
INSERT INTO `classes` VALUES (5,7,'Form 1','A','1',1,'2016-09-02 10:02:12'),(4,7,'Form 2','B','2',1,'2016-09-02 10:00:35'),(28,7,'Form 3','A','10',1,'2016-09-05 15:25:34');
/*!40000 ALTER TABLE `classes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `courses`
--

DROP TABLE IF EXISTS `courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `courses` (
  `course_id` int(255) NOT NULL AUTO_INCREMENT,
  `school_id` int(10) NOT NULL,
  `course_name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `classes` text COLLATE utf8mb4_unicode_ci,
  `active` tinyint(1) DEFAULT '1',
  `time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`course_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `courses`
--

LOCK TABLES `courses` WRITE;
/*!40000 ALTER TABLE `courses` DISABLE KEYS */;
INSERT INTO `courses` VALUES (1,7,'English','All Classes',1,'2016-09-02 12:44:47'),(2,7,'ICT','All Classes',1,'2016-09-02 12:46:17'),(3,7,'Math','All Classes',1,'2016-09-02 13:46:16');
/*!40000 ALTER TABLE `courses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `parents`
--

DROP TABLE IF EXISTS `parents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `parents` (
  `parent_id` int(255) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  `phone` varchar(50) NOT NULL,
  `student_id` int(255) NOT NULL,
  PRIMARY KEY (`parent_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `parents`
--

LOCK TABLES `parents` WRITE;
/*!40000 ALTER TABLE `parents` DISABLE KEYS */;
/*!40000 ALTER TABLE `parents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `school_details`
--

DROP TABLE IF EXISTS `school_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `school_details` (
  `school_id` int(255) unsigned NOT NULL AUTO_INCREMENT,
  `school_name` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `motto` text COLLATE utf8mb4_unicode_ci,
  `logo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `head` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deputy` varchar(150) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mission` text COLLATE utf8mb4_unicode_ci,
  `details` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `grading` varchar(25) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`school_id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `school_details`
--

LOCK TABLES `school_details` WRITE;
/*!40000 ALTER TABLE `school_details` DISABLE KEYS */;
INSERT INTO `school_details` VALUES (7,'asd','asd','asd/LOGO.png','asd','asd','asd','','75','2016-08-30 07:33:59');
/*!40000 ALTER TABLE `school_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `school_images`
--

DROP TABLE IF EXISTS `school_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `school_images` (
  `img_id` int(255) unsigned NOT NULL AUTO_INCREMENT,
  `school_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`img_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `school_images`
--

LOCK TABLES `school_images` WRITE;
/*!40000 ALTER TABLE `school_images` DISABLE KEYS */;
INSERT INTO `school_images` VALUES (1,'7','asd/LOGO.png');
/*!40000 ALTER TABLE `school_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_images`
--

DROP TABLE IF EXISTS `student_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `student_images` (
  `img_id` int(255) unsigned NOT NULL AUTO_INCREMENT,
  `student_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`img_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_images`
--

LOCK TABLES `student_images` WRITE;
/*!40000 ALTER TABLE `student_images` DISABLE KEYS */;
/*!40000 ALTER TABLE `student_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `students`
--

DROP TABLE IF EXISTS `students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `students` (
  `student_id` int(255) NOT NULL AUTO_INCREMENT,
  `student_name` varchar(150) NOT NULL,
  `username` varchar(50) NOT NULL,
  `guardian_one_name` varchar(150) NOT NULL,
  `guardian_one_phone` varchar(25) NOT NULL,
  `guardian_two_name` varchar(150) NOT NULL,
  `guardian_two_phone` varchar(25) NOT NULL,
  `gender` varchar(10) NOT NULL,
  `class_id` int(20) NOT NULL,
  `details` text NOT NULL,
  `files` varchar(150) NOT NULL,
  `password` varchar(100) NOT NULL,
  `time` varchar(150) NOT NULL,
  `ip_addr` varchar(15) NOT NULL,
  `lastlogin` timestamp NOT NULL,
  PRIMARY KEY (`student_id`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `students`
--

LOCK TABLES `students` WRITE;
/*!40000 ALTER TABLE `students` DISABLE KEYS */;
INSERT INTO `students` VALUES (1,'Emil Gabriel Kitua','SEMIKIT1596','gabriel kitua','727235709','romana kitua','727235709','male',4,'aaaaaaaaaaaaaaaaaaaaaaaaaaa','','asdasd','2016-08-30 23:41:41','','2016-09-19 21:00:00'),(4,'Glory Gabriel Kitua','SGLOKIT1592','gabriel kitua','727235709','romana kitua','727235709','female',5,'aaaaaaaaaaaaaaaaaaaaaaaaaaa','','aaaaaaaaaaaaaaaa','2016-08-30 23:53:04','','2016-09-11 21:00:00'),(5,'Daudi Gabriel Kitua','SGLOKIT1592','gabriel kitua','727235709','romana kitua','727235709','female',5,'aaaaaaaaaaaaaaaaaaaaaaaaaaa','','aaaaaaaaaaaaaaaa','2016-08-30 23:53:04','','2016-09-07 14:50:10'),(6,'Gabriel Kitua','SGLOKIT1592','gabriel kitua','727235709','romana kitua','727235709','female',5,'aaaaaaaaaaaaaaaaaaaaaaaaaaa','','aaaaaaaaaaaaaaaa','2016-08-30 23:53:04','','2016-09-07 14:50:42'),(7,'Romana Kitua','SGLOKIT1592','gabriel kitua','727235709','romana kitua','727235709','female',5,'aaaaaaaaaaaaaaaaaaaaaaaaaaa','','aaaaaaaaaaaaaaaa','2016-08-30 23:53:04','','2016-09-07 14:50:42'),(8,'test Kitua','SGLOKIT1592','gabriel kitua','727235709','romana kitua','727235709','female',5,'aaaaaaaaaaaaaaaaaaaaaaaaaaa','','aaaaaaaaaaaaaaaa','2016-08-30 23:53:04','','2016-09-07 14:52:04'),(9,'asdasd','SGLOKIT1592','gabriel kitua','727235709','romana kitua','727235709','female',5,'aaaaaaaaaaaaaaaaaaaaaaaaaaa','','aaaaaaaaaaaaaaaa','2016-08-30 23:53:04','','2016-09-07 14:52:04'),(10,'qweeeeeee','SGLOKIT1592','gabriel kitua','727235709','romana kitua','727235709','female',5,'aaaaaaaaaaaaaaaaaaaaaaaaaaa','','aaaaaaaaaaaaaaaa','2016-08-30 23:53:04','','2016-09-07 14:52:04'),(11,'another','SGLOKIT1592','gabriel kitua','727235709','romana kitua','727235709','female',5,'aaaaaaaaaaaaaaaaaaaaaaaaaaa','','aaaaaaaaaaaaaaaa','2016-08-30 23:53:04','','2016-09-07 14:52:04'),(12,'another 1','SGLOKIT1592','gabriel kitua','727235709','romana kitua','727235709','female',5,'aaaaaaaaaaaaaaaaaaaaaaaaaaa','','aaaaaaaaaaaaaaaa','2016-08-30 23:53:04','','2016-09-07 14:53:12');
/*!40000 ALTER TABLE `students` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teachers`
--

DROP TABLE IF EXISTS `teachers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `teachers` (
  `teacher_id` int(255) NOT NULL AUTO_INCREMENT,
  `username` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `teacher_name` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phone` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `course` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `maxload` int(10) NOT NULL,
  `unavailable_days` text COLLATE utf8mb4_unicode_ci,
  `active` tinyint(1) DEFAULT '1',
  `ip_add` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lastlogin` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`teacher_id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `phone` (`phone`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teachers`
--

LOCK TABLES `teachers` WRITE;
/*!40000 ALTER TABLE `teachers` DISABLE KEYS */;
INSERT INTO `teachers` VALUES (1,'EKITEMI1172','a8f5f167f44f4964e6c998dee827110c','Emil Kitua','kituaemil@gmail.com','+254727235709','computer',12,'none',1,'1','2016-09-09 09:03:54','2016-09-02 09:44:38'),(2,'EKITGLO1694','a8f5f167f44f4964e6c998dee827110c','Glory Kitua','kituaemil@gmail.com','+2547272111111','english',12,'asd',1,'','','2016-09-02 09:53:13'),(9,'EASDTES1812','a8f5f167f44f4964e6c998dee827110c','test asds','kituaemil@gmail.com','1234555666','24',123,'asdasd',1,'','','2016-09-07 10:50:00'),(10,'EASDTES1428','a8f5f167f44f4964e6c998dee827110c','test asds','kituaemil@gmail.com','12345512','25',123,'asdasd',1,'','','2016-09-07 10:51:53'),(11,'EASDTES1623','a8f5f167f44f4964e6c998dee827110c','test asds','kituaemil@gmail.com','12345534','26',123,'asdasd',1,'','','2016-09-07 10:54:05'),(12,'EASDTES1517','a8f5f167f44f4964e6c998dee827110c','test asds','kituaemil@gmail.com','333333333','28',123,'asdasd',1,'','','2016-09-07 10:56:35');
/*!40000 ALTER TABLE `teachers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teachers_courses`
--

DROP TABLE IF EXISTS `teachers_courses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `teachers_courses` (
  `id` int(255) NOT NULL AUTO_INCREMENT,
  `teacher_id` int(255) NOT NULL,
  `course_id` int(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=29 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teachers_courses`
--

LOCK TABLES `teachers_courses` WRITE;
/*!40000 ALTER TABLE `teachers_courses` DISABLE KEYS */;
INSERT INTO `teachers_courses` VALUES (28,12,3),(27,12,2),(26,2,3),(25,1,3),(24,1,2);
/*!40000 ALTER TABLE `teachers_courses` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-09-21 21:41:24
