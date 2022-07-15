-- MySQL dump 10.13  Distrib 5.7.31, for Linux (i686)
--
-- Host: localhost    Database: personnel
-- ------------------------------------------------------
-- Server version	5.7.31-0ubuntu0.16.04.1

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
-- Current Database: `personnel`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `personnel` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `personnel`;

--
-- Table structure for table `CrewRoles`
--

DROP TABLE IF EXISTS `CrewRoles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CrewRoles` (
  `RoleID` int(11) NOT NULL AUTO_INCREMENT,
  `Department` varchar(15) DEFAULT NULL,
  `Rank` varchar(12) DEFAULT NULL,
  PRIMARY KEY (`RoleID`)
) ENGINE=InnoDB AUTO_INCREMENT=97 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CrewRoles`
--

LOCK TABLES `CrewRoles` WRITE;
/*!40000 ALTER TABLE `CrewRoles` DISABLE KEYS */;
INSERT INTO `CrewRoles` VALUES (1,'Deck','Captain'),(2,'Deck','Chief'),(3,'Deck','1st Off'),(4,'Deck','2nd Off'),(5,'Deck','3rd Off'),(6,'Deck','4th Off'),(7,'Deck','Cadet Dk'),(8,'Deck','Coxswain'),(9,'Engine','Chief Eng'),(10,'Engine','StfChiefEng'),(11,'Engine','1st Eng'),(12,'Engine','2nd Eng'),(13,'Engine','3rd Eng'),(14,'Engine','4th Eng'),(15,'Engine','Cadet Eng'),(16,'Engine','Mechanic'),(17,'Engine','Fitter'),(18,'Engine','Motorman'),(19,'Electro-Tech','Staff Chief'),(20,'Electro-Tech','1ETO'),(21,'Electro-Tech','2ETO'),(22,'Electro-Tech','3ETO'),(23,'Electro-Tech','Technician'),(24,'Electro-Tech','Cadet ETO');
/*!40000 ALTER TABLE `CrewRoles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OnAndHistory`
--

DROP TABLE IF EXISTS `OnAndHistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `OnAndHistory` (
  `CompanyID` int(11) NOT NULL,
  `RoleID` int(11) DEFAULT NULL,
  `FirstName` varchar(25) DEFAULT NULL,
  `LastName` varchar(25) DEFAULT NULL,
  `UserName` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OnAndHistory`
--

LOCK TABLES `OnAndHistory` WRITE;
/*!40000 ALTER TABLE `OnAndHistory` DISABLE KEYS */;
INSERT INTO `OnAndHistory` VALUES (1,1,'Captain','1','cap1'),(2,1,'Captain','2','cap2'),(3,3,'1st Off','Deck 1','1DO1'),(4,3,'1st Off','Deck 2','1DO2'),(5,9,'Chief ','Engineer 1','CEng1'),(6,9,'Chief','Engineer 2','CEng2'),(7,11,'1st Engineer','Officer 1','1EO1'),(8,11,'1st Engineer','Officer 2','1EO2'),(9,20,'1st ETO','1','1ETO1'),(10,20,'1st ETO ','2','1ETO2'),(11,22,'3rd ETO','1','3ETO1'),(12,22,'3rd ETO','2','3ETO2');
/*!40000 ALTER TABLE `OnAndHistory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `OnBoard`
--

DROP TABLE IF EXISTS `OnBoard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `OnBoard` (
  `CompanyID` int(11) NOT NULL,
  `RoleID` int(11) DEFAULT NULL,
  `roleTxtID` varchar(20) DEFAULT NULL,
  `FirstName` varchar(25) DEFAULT NULL,
  `LastName` varchar(25) DEFAULT NULL,
  `UserName` varchar(30) DEFAULT NULL,
  `EmbarkedDate` date DEFAULT NULL,
  `DisembarkDate` date DEFAULT NULL,
  PRIMARY KEY (`CompanyID`),
  KEY `RoleID` (`RoleID`),
  CONSTRAINT `OnBoard_ibfk_1` FOREIGN KEY (`RoleID`) REFERENCES `CrewRoles` (`RoleID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `OnBoard`
--

LOCK TABLES `OnBoard` WRITE;
/*!40000 ALTER TABLE `OnBoard` DISABLE KEYS */;
INSERT INTO `OnBoard` VALUES (1,1,NULL,'Captain','1','cap1','2022-06-20','2022-08-20'),(2,1,NULL,'Captain','2','cap2','2022-01-20','2022-06-20'),(3,3,NULL,'1st Off','Deck 1','1DO1','2022-06-27','2022-06-29'),(4,3,NULL,'1st Off','Deck 2','1DO2','2022-06-12','2022-06-27'),(5,9,NULL,'Chief ','Engineer 1','CEng1','2022-06-06','2022-08-18'),(6,9,NULL,'Chief','Engineer 2','CEng2','2022-04-03','2022-06-16'),(7,11,NULL,'1st Engineer','Officer 1','1EO1','2022-06-01','2022-07-21'),(8,11,NULL,'1st Engineer','Officer 2','1EO2','2022-04-10','2022-06-01'),(9,20,NULL,'1st ETO','1','1ETO1','2022-06-01','2022-06-30'),(10,20,NULL,'1st ETO ','2','1ETO2','2022-06-30','2022-08-11'),(11,22,NULL,'3rd ETO','1','3ETO1','2022-06-05','2022-08-05'),(12,22,NULL,'3rd ETO','2','3ETO2','2022-04-11','2022-06-05');
/*!40000 ALTER TABLE `OnBoard` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-06-30 20:18:55
