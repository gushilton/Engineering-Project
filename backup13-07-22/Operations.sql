-- MySQL dump 10.13  Distrib 5.7.31, for Linux (i686)
--
-- Host: localhost    Database: Operations
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
-- Current Database: `Operations`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `Operations` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `Operations`;

--
-- Table structure for table `Components`
--

DROP TABLE IF EXISTS `Components`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Components` (
  `ComponentShort` char(10) NOT NULL,
  `ComponentNumber` int(6) unsigned zerofill NOT NULL,
  `heirachy` char(3) DEFAULT NULL,
  `function` int(6) unsigned zerofill NOT NULL,
  `Maker` varchar(30) DEFAULT NULL,
  `Model` varchar(30) DEFAULT NULL,
  `SerialNumber` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ComponentShort`,`ComponentNumber`),
  KEY `fk_com_function` (`heirachy`,`function`),
  CONSTRAINT `fk_com_function` FOREIGN KEY (`heirachy`, `function`) REFERENCES `functions` (`heirachy`, `function`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Components`
--

LOCK TABLES `Components` WRITE;
/*!40000 ALTER TABLE `Components` DISABLE KEYS */;
INSERT INTO `Components` VALUES ('ALT',000001,'AB',000001,'AEG','S500','AEG-SPOLE-001'),('ALT',000002,'AB',000002,'AEG','S500','AEG-SPOLE-002'),('ALT',000003,'AB',000003,'AEG','S500','AEG-SPOLE-003'),('ALT',000004,'AB',000004,'AEG','S500','AEG-SPOLE-004'),('ENGINE',000001,'AA',000001,'ABB','ABB14V','ABB-14V-001'),('ENGINE',000002,'AA',000002,'ABB','ABB14V','ABB-14V-002'),('ENGINE',000003,'AA',000003,'ABB','ABB14V','ABB-14V-003'),('ENGINE',000004,'AA',000004,'ABB','ABB14V','ABB-14V-004'),('FireDet',000001,'GBA',000001,'Consillium','CON Loops','con-m85-00001'),('FireDet',000002,'GBA',000002,'Consillium','CON Loops','con-m85-00002'),('FireDet',000003,'GBA',000003,'Consillium','CON Loops','con-m85-00003'),('GMDSS',000001,'CC',000001,'Sailor','6600','s100'),('Lifts',000001,'DA',000001,'Kone','kn1000Kg','knlift001'),('Lifts',000002,'DA',000002,'Kone','kn1000Kg','knlift002'),('Lifts',000003,'DA',000003,'Kone','kn1000Kg','knlift003'),('Lifts',000004,'DA',000004,'Kone','kn1000Kg','knlift004');
/*!40000 ALTER TABLE `Components` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Function_Hierachy`
--

DROP TABLE IF EXISTS `Function_Hierachy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Function_Hierachy` (
  `DivisionName` varchar(40) DEFAULT NULL,
  `Division1` char(1) DEFAULT NULL,
  `Division2` char(1) DEFAULT NULL,
  `Division3` char(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Function_Hierachy`
--

LOCK TABLES `Function_Hierachy` WRITE;
/*!40000 ALTER TABLE `Function_Hierachy` DISABLE KEYS */;
INSERT INTO `Function_Hierachy` VALUES ('Power Generation','A','',''),('Prime Mover','A','A',''),('Alternators','A','B',''),('Power Distribution','B','',''),('Main Switchboard','B','A',''),('Substations','B','B',''),('Navigation','C','',''),('Steering Gear','C','A',''),('Nav Lights','C','B',''),('GMDSS','C','C',''),('ECDIS','C','D',''),('Hotel','D','',''),('Lifts','D','A',''),('Laundry','D','B',''),('Galley','E','',''),('Workshop Equipment','F','',''),('Electrical','F','A',''),('Multimeters','F','A','A'),('Calibrators','F','A','B'),('Safety','G','',''),('Emergency Power','G','A',''),('Fire','G','B',''),('Fire Detection','G','B','A'),('Fire Fighting','G','B','B'),('Emergency Prime Mover','G','A','A'),('Emergency Alternator','G','A','B'),('Transitional Batteries','G','A','C'),('Fast Rescue Craft','G','F','');
/*!40000 ALTER TABLE `Function_Hierachy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MaintenanceTasks`
--

DROP TABLE IF EXISTS `MaintenanceTasks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `MaintenanceTasks` (
  `yearID` smallint(2) NOT NULL,
  `JobID` mediumint(6) unsigned zerofill NOT NULL AUTO_INCREMENT,
  `Job_Name` varchar(255) DEFAULT NULL,
  `AssignedTo` int(11) DEFAULT NULL,
  `routineDuty` bit(1) DEFAULT b'0',
  `Department_short` char(3) DEFAULT NULL,
  `Routine_number` int(5) unsigned zerofill DEFAULT NULL,
  `descriptionProblem` varchar(255) DEFAULT '',
  `descriptionAction` varchar(255) DEFAULT '',
  `hierachy` char(3) DEFAULT NULL,
  `functionID` int(6) unsigned zerofill DEFAULT NULL,
  `ComponentShort` char(10) DEFAULT NULL,
  `ComponentNumber` int(6) unsigned zerofill NOT NULL,
  `Date_Created` date DEFAULT NULL,
  `Date_Due` date DEFAULT NULL,
  `Date_Complete` date DEFAULT NULL,
  `Complete` bit(1) DEFAULT b'0',
  `completeBy` int(11) DEFAULT NULL,
  PRIMARY KEY (`yearID`,`JobID`),
  KEY `fk_assigned` (`AssignedTo`),
  KEY `fk_routine` (`Department_short`,`Routine_number`),
  KEY `fk_hierachy` (`hierachy`,`functionID`),
  KEY `fk_component` (`ComponentShort`,`ComponentNumber`),
  KEY `fk_completeBy` (`completeBy`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MaintenanceTasks`
--

LOCK TABLES `MaintenanceTasks` WRITE;
/*!40000 ALTER TABLE `MaintenanceTasks` DISABLE KEYS */;
INSERT INTO `MaintenanceTasks` VALUES (22,000001,'ELE/2 - Lift 1, Monthly Maintenance ',22,_binary '','ELE',00002,'','','DA',000001,'LIFTS',000001,'2022-03-01','2022-04-01','2022-04-01',_binary '',11),(22,000002,'ELE/2 - Lift 2, Monthly Maintenance ',22,_binary '','ELE',00002,'','','DA',000002,'LIFTS',000002,'2022-03-07','2022-04-07','2022-04-07',_binary '',11),(22,000003,'ELE/2 - Lift 2, Monthly Maintenance ',22,_binary '','ELE',00003,'','','DA',000002,'LIFTS',000002,'2022-01-07','2022-04-07','2022-04-07',_binary '',11),(21,008000,'ELE/2 - Lift 4, Monthly Maintenance ',22,_binary '','ELE',00003,'','','DA',000004,'LIFTS',000004,'2021-12-28','2022-03-28','2022-03-28',_binary '',11),(21,007900,'ELE/2 - Lift 2, Monthly Maintenance ',22,_binary '','ELE',00003,'','','DA',000002,'LIFTS',000002,'2022-10-07','2022-01-07','2022-01-07',_binary '',11),(22,000004,'Fire Zone 1 Detector Testing',22,_binary '','ELE',00005,'','','GBA',000001,'FireDet',000001,'2022-02-08','2022-03-08','2022-03-08',_binary '',11),(22,000005,'Fire Zone 2 Detector Testing',22,_binary '','ELE',00005,'','','GBA',000002,'FireDet',000002,'2022-02-16','2022-03-16','2022-03-16',_binary '',11),(22,000006,'Fire Zone 3 Detector Testing',22,_binary '','ELE',00005,'','','GBA',000003,'FireDet',000003,'2022-02-26','2022-03-26','2022-03-26',_binary '',11),(21,009000,'Fire Zone 1 Detector Testing',22,_binary '','ELE',00005,'','','GBA',000001,'FireDet',000001,'2021-12-06','2022-01-06','2022-01-06',_binary '',11),(21,008050,'Fire Zone 1 Detector Testing',22,_binary '','ELE',00005,'','','GBA',000001,'FireDet',000001,'2021-11-06','2021-12-06','2021-12-06',_binary '',11),(21,007880,'Fire Zone 1 Detector Testing',22,_binary '','ELE',00005,'','','GBA',000001,'FireDet',000001,'2021-10-06','2021-11-06','2021-11-06',_binary '',11),(22,000007,'Fire Zone 1 Detector Testing',22,_binary '','ELE',00005,'','','GBA',000001,'FireDet',000001,'2022-01-06','2022-02-05','2022-02-05',_binary '',11),(22,000008,'Fire Zone 1 Detector Testing',22,_binary '','ELE',00005,'','','GBA',000001,'FireDet',000001,'2022-01-06','2022-02-05','2022-02-05',_binary '',11),(22,000009,'Fire Zone 1 Detector Testing',22,_binary '','ELE',00005,'','','GBA',000001,'FireDet',000001,'2022-02-05','2022-03-07','2022-03-07',_binary '',11),(22,000010,'Fire Zone 1 Detector Testing',22,_binary '','ELE',00005,'','','GBA',000001,'FireDet',000001,'2022-02-05','2022-03-07','2022-03-07',_binary '',11),(22,000011,'Fire Zone 1 Detector Testing',22,_binary '','ELE',00005,'','','GBA',000001,'FireDet',000001,'2022-03-07','2022-04-06','2022-04-06',_binary '',11),(22,000012,'Fire Zone 1 Detector Testing',22,_binary '','ELE',00005,'','','GBA',000001,'FireDet',000001,'2022-03-07','2022-04-06','2022-04-06',_binary '',11),(22,000013,'Fire Zone 1 Detector Testing',22,_binary '','ELE',00005,'','','GBA',000001,'FireDet',000001,'2022-03-08','2022-04-07','2022-04-07',_binary '',11),(22,000014,'Fire Zone 2 Detector Testing',22,_binary '','ELE',00005,'','','GBA',000002,'FireDet',000002,'2022-03-16','2022-04-15','2022-04-15',_binary '',11),(22,000015,'Fire Zone 3 Detector Testing',22,_binary '','ELE',00005,'','','GBA',000003,'FireDet',000003,'2022-03-26','2022-04-25','2022-04-25',_binary '',11),(22,000016,'ELE/2 - Lift 4, Monthly Maintenance ',22,_binary '','ELE',00003,'','','DA',000004,'LIFTS',000004,'2022-03-28','2022-06-26','2022-06-26',_binary '',11),(22,000017,'ELE/2 - Lift 1, Monthly Maintenance ',22,_binary '','ELE',00002,'','','DA',000001,'LIFTS',000001,'2022-04-01','2022-05-01','2022-05-01',_binary '',11),(22,000018,'Fire Zone 1 Detector Testing',22,_binary '','ELE',00005,'','','GBA',000001,'FireDet',000001,'2022-04-06','2022-05-06','2022-05-06',_binary '',11),(22,000019,'Fire Zone 1 Detector Testing',22,_binary '','ELE',00005,'','','GBA',000001,'FireDet',000001,'2022-04-06','2022-05-06','2022-05-06',_binary '',11),(22,000020,'Fire Zone 1 Detector Testing',22,_binary '','ELE',00005,'','','GBA',000001,'FireDet',000001,'2022-04-07','2022-05-07','2022-05-07',_binary '',11),(22,000021,'ELE/2 - Lift 2, Monthly Maintenance ',22,_binary '','ELE',00003,'','','DA',000002,'LIFTS',000002,'2022-04-07','2022-07-06','2022-07-06',_binary '',11),(22,000022,'ELE/2 - Lift 2, Monthly Maintenance ',22,_binary '','ELE',00002,'','','DA',000002,'LIFTS',000002,'2022-04-07','2022-04-07','2022-07-06',_binary '',11),(22,000023,'Fire Zone 2 Detector Testing',22,_binary '','ELE',00005,'','','GBA',000002,'FireDet',000002,'2022-04-15','2022-04-15','2022-07-06',_binary '',11),(22,000024,'Fire Zone 3 Detector Testing',22,_binary '','ELE',00005,'','','GBA',000003,'FireDet',000003,'2022-04-25','2022-04-25','2022-07-06',_binary '',11),(22,000025,'ELE/2 - Lift 4, Monthly Maintenance ',22,_binary '','ELE',00003,'','','DA',000004,'LIFTS',000004,'2022-06-26','2022-06-26','2022-07-08',_binary '',11),(22,000026,'ELE/2 - Lift 1, Monthly Maintenance ',22,_binary '','ELE',00002,'','','DA',000001,'LIFTS',000001,'2022-05-01','2022-05-01','2022-07-06',_binary '',11),(22,000027,'Fire Zone 1 Detector Testing',22,_binary '','ELE',00005,'','','GBA',000001,'FireDet',000001,'2022-05-06','2022-05-06','2022-07-06',_binary '',11),(22,000028,'Fire Zone 1 Detector Testing',22,_binary '','ELE',00005,'','','GBA',000001,'FireDet',000001,'2022-05-06','2022-05-06','2022-07-06',_binary '',11),(22,000029,'Fire Zone 1 Detector Testing',22,_binary '','ELE',00005,'','','GBA',000001,'FireDet',000001,'2022-05-07','2022-05-07','2022-07-07',_binary '',11),(22,000030,'ELE/3 - Lift 2, 3 Monthly Maintenance ',22,_binary '','ELE',00003,'','','DA',000002,'LIFTS',000002,'2022-07-06','2022-10-04',NULL,_binary '\0',NULL),(22,000031,'ELE/2 - Lift 2, Monthly Maintenance ',22,_binary '','ELE',00002,'','','DA',000002,'LIFTS',000002,'2022-07-06','2022-08-05',NULL,_binary '\0',NULL),(22,000032,'Fire Zone 2 Detector Testing',22,_binary '','ELE',00005,'','','GBA',000002,'FireDet',000002,'2022-07-06','2022-08-05',NULL,_binary '\0',NULL),(22,000033,'Fire Zone 3 Detector Testing',22,_binary '','ELE',00005,'','','GBA',000003,'FireDet',000003,'2022-07-06','2022-08-05',NULL,_binary '\0',NULL),(22,000043,'ELE/00001 - ALternator 1 Inspection',20,_binary '','ELE',00001,'','','AB',000001,'ALT',000001,'2022-01-01','2022-12-31',NULL,_binary '\0',NULL),(22,000035,'ELE/2 - Lift 1, Monthly Maintenance ',22,_binary '','ELE',00002,'','','DA',000001,'LIFTS',000001,'2022-07-06','2022-08-05',NULL,_binary '\0',NULL),(22,000036,'Fire Zone 1 Detector Testing',22,_binary '','ELE',00005,'','','GBA',000001,'FireDet',000001,'2022-07-06','2022-08-05',NULL,_binary '\0',NULL),(22,000038,'Fire Zone 1 Detector Testing',22,_binary '\0',NULL,00005,'detector not working on testing','detector replaced','GBA',000001,'FireDet',000001,'2022-07-06','2022-07-08','2022-07-06',_binary '',11),(22,000039,'ELE/2 - Lift 1, Monthly Maintenance ',22,_binary '\0',NULL,NULL,'button broken','button replaced','DA',000001,'Lifts',000001,'2022-07-07','2022-07-15','2022-07-07',_binary '',11),(22,000040,'Fire Zone 2 Detector Testing',22,_binary '\0',NULL,NULL,'loop went into fault, faulty loop card','loop card replaced ','GBA',000002,'FireDet',000002,'2022-07-07','2022-07-09','2022-07-08',_binary '',11),(22,000042,'ELE/2 - Lift 4, Monthly Maintenance ',22,_binary '','ELE',00003,'','','DA',000004,'LIFTS',000004,'2022-07-08','2022-10-06',NULL,_binary '\0',NULL),(21,005000,'ELE/00001 - ALternator 2 Inspection',20,_binary '','ELE',00001,'','','AB',000002,'ALT',000002,'2021-03-15','2022-03-15',NULL,_binary '\0',NULL),(21,010000,'ELE/00001 - ALternator 3 Inspection',20,_binary '','ELE',00001,'','','AB',000003,'ALT',000003,'2021-06-15','2022-06-15',NULL,_binary '\0',NULL),(21,020000,'ELE/00001 - ALternator 4 Inspection',20,_binary '','ELE',00001,'','','AB',000004,'ALT',000004,'2021-09-15','2022-09-15',NULL,_binary '\0',NULL),(21,000100,'ENG/00001 - Engine 1 Overhaul',11,_binary '','ENG',00001,'','','AA',000001,'ENG',000001,'2021-01-15','2023-01-15',NULL,_binary '\0',NULL),(21,001100,'ENG/00001 - Engine 2 Overhaul',11,_binary '','ENG',00001,'','','AA',000002,'ENG',000002,'2021-03-15','2022-03-15',NULL,_binary '\0',NULL),(21,021000,'ENG/00001 - Engine 3 Overhaul',11,_binary '','ENG',00001,'','','AA',000003,'ENG',000003,'2021-06-15','2022-06-15',NULL,_binary '\0',NULL),(21,030000,'ENG/00001 - Engine 4 Overhaul',11,_binary '','ENG',00001,'','','AA',000004,'ENG',000004,'2021-09-15','2022-09-15',NULL,_binary '\0',NULL),(22,000044,' button replaced ',22,_binary '\0',NULL,NULL,'call button damaged ','button replaced ','DA',000001,'Lifts',000001,'2022-07-11','2022-07-11','2022-07-12',_binary '',11),(22,000045,'head replaced ',22,_binary '\0',NULL,NULL,'head not activated on testing ','head replaced ','GBA',000001,'FireDet',000001,'2022-07-11','2022-07-12',NULL,_binary '\0',NULL),(22,000046,'loop card failure',22,_binary '\0',NULL,NULL,'loop went into fault, problem with card','loop card replace ','GBA',000003,'FireDet',000003,'2022-07-11','2022-07-14','2022-07-12',_binary '',11),(22,000047,'call button stuck',22,_binary '\0',NULL,NULL,'landing call button always lit not responding to call','replaced button ','DA',000001,'Lifts',000001,'2022-07-12','2022-07-14',NULL,_binary '\0',NULL);
/*!40000 ALTER TABLE `MaintenanceTasks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TaskNotes`
--

DROP TABLE IF EXISTS `TaskNotes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `TaskNotes` (
  `NoteID` int(11) NOT NULL AUTO_INCREMENT,
  `YearID` int(11) DEFAULT NULL,
  `JobID` int(11) DEFAULT NULL,
  `DateTime` datetime DEFAULT NULL,
  `Note` varchar(300) DEFAULT NULL,
  PRIMARY KEY (`NoteID`),
  KEY `fk_jobID` (`JobID`),
  KEY `fk_yearID` (`YearID`)
) ENGINE=MyISAM AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TaskNotes`
--

LOCK TABLES `TaskNotes` WRITE;
/*!40000 ALTER TABLE `TaskNotes` DISABLE KEYS */;
INSERT INTO `TaskNotes` VALUES (1,22,2,'2022-04-07 00:00:00','task complete nothing to report'),(2,22,14,'2022-04-15 00:00:00','task complete nothing to report'),(3,22,15,'2022-04-25 00:00:00','task complete nothing to report'),(4,22,16,'2022-06-26 00:00:00','task complete nothing to report'),(5,22,17,'2022-05-01 00:00:00','task complete nothing to report'),(6,22,18,'2022-05-06 00:00:00','task complete nothing to report'),(7,22,19,'2022-05-06 00:00:00','task complete nothing to report'),(8,22,20,'2022-05-07 00:00:00','task complete nothing to report'),(9,22,21,'2022-07-06 00:00:00','task complete nothing to report'),(10,22,22,'2022-07-06 00:00:00','Task completed as per work order\nnothing abnormal'),(11,22,23,'2022-07-06 00:00:00','Completed as per WO\nNothing abnormal'),(12,22,24,'2022-07-06 00:00:00','completed as per WO\nnothing abnormal'),(13,22,22,'2022-07-06 00:00:00','completed as per WO\nNothing abnormal to report'),(14,22,26,'2022-07-06 00:00:00','Lift monthly found faulty part'),(15,22,26,'2022-07-06 00:00:00','task completed'),(16,22,27,'2022-07-06 19:13:03','Fire Zone testing as per WO \nsee Fire detector testing spreadsheet'),(17,22,27,'2022-07-06 19:13:17','complete as per WO'),(18,22,28,'2022-07-06 19:18:12','completed as pe WO'),(19,22,29,'2022-07-07 07:47:02','nothing to report'),(20,22,25,'2022-07-08 13:39:25','completed as per wo\nnothing to report');
/*!40000 ALTER TABLE `TaskNotes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `functions`
--

DROP TABLE IF EXISTS `functions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `functions` (
  `heirachy` char(3) NOT NULL,
  `function` int(6) unsigned zerofill NOT NULL,
  `functionName` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`heirachy`,`function`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `functions`
--

LOCK TABLES `functions` WRITE;
/*!40000 ALTER TABLE `functions` DISABLE KEYS */;
INSERT INTO `functions` VALUES ('',000000,''),('AA',000001,'Prime Mover 1'),('AA',000002,'Prime Mover 2'),('AA',000003,'Prime Mover 3'),('AA',000004,'Prime Mover 4'),('AB',000001,'Alternator 1'),('AB',000002,'Alternator 2'),('AB',000003,'Alternator 3'),('AB',000004,'Alternator 4'),('CC',000001,'GMDSS Equipment'),('DA',000001,'Lift 1'),('DA',000002,'Lift 2'),('DA',000003,'Lift 3'),('DA',000004,'Lift 4'),('DB',000001,'Washing Machine 1'),('DB',000002,'Washing Machine 2'),('DB',000003,'Drying Machine 1'),('DB',000004,'Drying Machine 2'),('E',000001,'Deep fat fryer 1'),('E',000002,'Deep fat fryer 2'),('E',000003,'Oven 1'),('E',000004,'Oven 2'),('E',000005,'Hot Plates range 1'),('E',000006,'Hot Plates range 2'),('E',000007,'Fridge 1'),('E',000008,'Fridge 2'),('E',000009,'Freezer'),('FAA',000001,'Multimeter 1'),('FAA',000002,'Multimeter 2'),('FAA',000003,'Multimeter 3'),('FAA',000004,'Multimeter 4'),('FAB',000001,'Loop calibrator 1'),('FAB',000002,'Loop Calibrator 2'),('FAB',000003,'Temperature cal 1'),('FAB',000004,'pressure cal 2'),('GAA',000001,'Emeregency Engine 1'),('GAB',000001,'Emergency Alternator 1'),('GAC',000001,'Transitional Batteries'),('GBA',000001,'Fire Zone 1'),('GBA',000002,'Fire Zone 2'),('GBA',000003,'Fire Zone 3'),('GBB',000001,'Main Fire Pump'),('GBB',000002,'Emergency Fire Pump'),('GBB',000003,'Sprinkler Fire Pump'),('GBB',000004,'Hydrants and Hoses'),('GBB',000005,'Extinguishers');
/*!40000 ALTER TABLE `functions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `routineJobs`
--

DROP TABLE IF EXISTS `routineJobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `routineJobs` (
  `Department_short` char(3) NOT NULL,
  `number` int(5) unsigned zerofill NOT NULL,
  `name` varchar(40) DEFAULT NULL,
  `heirachy` char(3) NOT NULL,
  `functionID` int(6) unsigned zerofill NOT NULL,
  `role` int(11) DEFAULT NULL,
  `frequency` varchar(25) DEFAULT NULL,
  `details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Department_short`,`number`,`heirachy`,`functionID`),
  KEY `fk_function` (`heirachy`,`functionID`),
  KEY `fk_role` (`role`),
  CONSTRAINT `fk_function` FOREIGN KEY (`heirachy`, `functionID`) REFERENCES `functions` (`heirachy`, `function`),
  CONSTRAINT `fk_role` FOREIGN KEY (`role`) REFERENCES `personnel`.`CrewRoles` (`RoleID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `routineJobs`
--

LOCK TABLES `routineJobs` WRITE;
/*!40000 ALTER TABLE `routineJobs` DISABLE KEYS */;
INSERT INTO `routineJobs` VALUES ('',00000,'','',000000,1,'',''),('ELE',00001,'Alternator Inspection','AB',000001,20,'365',''),('ELE',00001,'Alternator Inspectionl','AB',000002,20,'365',''),('ELE',00001,'Alternator Inspection','AB',000003,20,'365',''),('ELE',00001,'Alternator Inspection','AB',000004,20,'365',''),('ELE',00002,'Lift Monthly Inspection','DA',000001,22,'30','Lift Shaft PTW needed.\nInspect landing doors and door safety contact.\n Repeat landing door and door safety contact for each floor.'),('ELE',00002,'Lift Monthly Inspection','DA',000002,22,'30','Lift Shaft PTW needed.\nInspect landing doors and door safety contact.\n Repeat landing door and door safety contact for each floor.'),('ELE',00002,'Lift Monthly Inspection','DA',000003,22,'30','Lift Shaft PTW needed.\nInspect landing doors and door safety contact.\n Repeat landing door and door safety contact for each floor.'),('ELE',00002,'Lift Monthly Inspection','DA',000004,22,'30','Lift Shaft PTW needed.\nInspect landing doors and door safety contact.\n Repeat landing door and door safety contact for each floor.'),('ELE',00003,'Lift Quaterly Inspection','DA',000001,22,'90','Lift Shaft PTW needed.\nInspect landing doors and door safety contact.\n Repeat landing door and door safety contact for each floor.'),('ELE',00003,'Lift Quaterly Inspection','DA',000002,22,'90','Lift Shaft PTW needed.\nInspect landing doors and door safety contact.\n Repeat landing door and door safety contact for each floor.'),('ELE',00003,'Lift Quaterly Inspection','DA',000003,22,'90','Lift Shaft PTW needed.\nInspect landing doors and door safety contact.\n Repeat landing door and door safety contact for each floor.'),('ELE',00003,'Lift Quaterly Inspection','DA',000004,22,'90','Lift Shaft PTW needed.\nInspect landing doors and door safety contact.\n Repeat landing door and door safety contact for each floor.'),('ELE',00004,'GMDSS Monthly Battery Test','CC',000001,21,'30','Inspect GMDSS batteries and terminals.\n Perfom a discharge test for at least 30 mins.\nVolatge must not drop more than 10%, if it does stop test and replace batteries as soon as possible'),('ELE',00005,'Fire Zone 1 Montlhy Testing','GBA',000001,22,'30','Test the smoke detectors and MCP\'s, at least 12 smoke detectors and 4 MCP\'s to be tested. At least 4 smoke detectors in engine RM to be tested.'),('ELE',00005,'Fire Zone 2 Montlhy Testing','GBA',000002,22,'30','Test the smoke detectors and MCP\'s, at least 12 smoke detectors and 4 MCP\'s to be tested. At least 4 smoke detectors in engine RM to be tested.'),('ELE',00005,'Fire Zone 3 Montlhy Testing','GBA',000003,22,'30','Test the smoke detectors and MCP\'s, at least 12 smoke detectors and 4 MCP\'s to be tested. At least 4 smoke detectors in engine RM to be tested.'),('ENG',00001,'Engine Overhaul','AA',000001,11,'365',''),('ENG',00001,'Engine Overhaul','AA',000002,11,'365',''),('ENG',00001,'Engine Overhaul','AA',000003,11,'365',''),('ENG',00001,'Engine Overhaul','AA',000004,11,'365','');
/*!40000 ALTER TABLE `routineJobs` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-07-13 16:39:30
