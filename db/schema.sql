-- MySQL dump 10.17  Distrib 10.3.12-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: torontocatrescue
-- ------------------------------------------------------
-- Server version	10.3.12-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Cat`
--

DROP TABLE IF EXISTS `Cat`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Cat` (
  `CatID` int(11) NOT NULL AUTO_INCREMENT,
  `CatName` varchar(256) NOT NULL,
  `Age` varchar(4) DEFAULT NULL,
  `DateOfBirth` date DEFAULT NULL,
  Sex varchar(8) DEFAULT NULL,
  `Description` varchar(64) DEFAULT NULL,
  `ProposalDate` date DEFAULT NULL,
  `ShelterName` varchar(128) DEFAULT NULL,
  ShelterID varchar(64) DEFAULT NULL,
  `PetPointID` varchar(32) DEFAULT NULL,
  Microchip varchar(32) DEFAULT NULL,
  ToPost varchar(4) DEFAULT 'No',
  Posted varchar(4) DEFAULT 'No',
  `ImageURI` varchar(512) DEFAULT NULL,
  `FIVStatus` varchar(8) DEFAULT 'Unknown',
  `FLVStatus` varchar(8) DEFAULT 'Unknown',
  `FVRCPDate` date DEFAULT NULL,
  `RabiesDate` date DEFAULT NULL,
  `MedicalNotes` varchar(65535) DEFAULT NULL,
  `BehaviourNotes` varchar(65535) DEFAULT NULL,
  `Status` varchar(32) DEFAULT NULL,
  `Outcome` varchar(32) DEFAULT NULL,
  `IntakeDate` date DEFAULT NULL,
  `CurrentLocation` varchar(128) DEFAULT NULL,
   FamilyID INT NULL,
  PRIMARY KEY (`CatID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Cat`
--

LOCK TABLES `Cat` WRITE;
/*!40000 ALTER TABLE `Cat` DISABLE KEYS */;
/*!40000 ALTER TABLE `Cat` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CatFosterHome`
--

DROP TABLE IF EXISTS `CatFosterHome`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CatFosterHome` (
  `CatID` int(11) NOT NULL,
  `FosterHomeID` int(11) NOT NULL,
  PRIMARY KEY (`CatID`,`FosterHomeID`),
  CONSTRAINT CatID FOREIGN KEY (`CatID`) REFERENCES `Cat` (`CatID`),
  CONSTRAINT FosterHomeID FOREIGN KEY (`FosterHomeID`) REFERENCES `FosterHome` (`FosterHomeID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CatFosterHome`
--

LOCK TABLES `CatFosterHome` WRITE;
/*!40000 ALTER TABLE `CatFosterHome` DISABLE KEYS */;
/*!40000 ALTER TABLE `CatFosterHome` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CatPetStore`
--

DROP TABLE IF EXISTS `CatPetStore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CatPetStore` (
  `CatID` int(11) NOT NULL,
  `PetStoreID` int(11) NOT NULL,
  PRIMARY KEY (`CatID`,`PetStoreID`),
  KEY `PetStoreID` (`PetStoreID`),
  CONSTRAINT `CatPetStore_ibfk_1` FOREIGN KEY (`CatID`) REFERENCES `Cat` (`CatID`),
  CONSTRAINT `CatPetStore_ibfk_2` FOREIGN KEY (`PetStoreID`) REFERENCES `PetStore` (`PetStoreID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CatPetStore`
--

LOCK TABLES `CatPetStore` WRITE;
/*!40000 ALTER TABLE `CatPetStore` DISABLE KEYS */;
/*!40000 ALTER TABLE `CatPetStore` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CatVetClinic`
--

DROP TABLE IF EXISTS `CatVetClinic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CatVetClinic` (
  `CatID` int(11) NOT NULL,
  `VetClinicID` int(11) NOT NULL,
  PRIMARY KEY (`CatID`,`VetClinicID`),
  KEY `VetClinicID` (`VetClinicID`),
  CONSTRAINT `CatVetClinic_ibfk_1` FOREIGN KEY (`CatID`) REFERENCES `Cat` (`CatID`),
  CONSTRAINT `CatVetClinic_ibfk_2` FOREIGN KEY (`VetClinicID`) REFERENCES `VetClinic` (`VetClinicID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CatVetClinic`
--

LOCK TABLES `CatVetClinic` WRITE;
/*!40000 ALTER TABLE `CatVetClinic` DISABLE KEYS */;
/*!40000 ALTER TABLE `CatVetClinic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FamilyID`
--

DROP TABLE IF EXISTS `FamilyID`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `FamilyID` (
  `next_not_cached_value` bigint(21) NOT NULL,
  `minimum_value` bigint(21) NOT NULL,
  `maximum_value` bigint(21) NOT NULL,
  `start_value` bigint(21) NOT NULL COMMENT 'start value when sequences is created or value if RESTART is used',
  `increment` bigint(21) NOT NULL COMMENT 'increment value',
  `cache_size` bigint(21) unsigned NOT NULL,
  `cycle_option` tinyint(1) unsigned NOT NULL COMMENT '0 if no cycles are allowed, 1 if the sequence should begin a new cycle when maximum_value is passed',
  `cycle_count` bigint(21) NOT NULL COMMENT 'How many cycles have been done'
) ENGINE=InnoDB SEQUENCE=1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FamilyID`
--

LOCK TABLES `FamilyID` WRITE;
/*!40000 ALTER TABLE `FamilyID` DISABLE KEYS */;
INSERT INTO `FamilyID` VALUES (1001,1,9223372036854775806,1,1,1000,0,0);
/*!40000 ALTER TABLE `FamilyID` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FosterCoordinator`
--

DROP TABLE IF EXISTS `FosterCoordinator`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `FosterCoordinator` (
  `FosterCoordinatorID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(128) DEFAULT NULL,
  `PhoneNumber` varchar(32) DEFAULT NULL,
  `Email` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`FosterCoordinatorID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FosterCoordinator`
--

LOCK TABLES `FosterCoordinator` WRITE;
/*!40000 ALTER TABLE `FosterCoordinator` DISABLE KEYS */;
/*!40000 ALTER TABLE `FosterCoordinator` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FosterHome`
--

DROP TABLE IF EXISTS `FosterHome`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `FosterHome` (
  `FosterHomeID` int(11) NOT NULL AUTO_INCREMENT,
  `FosterName` varchar(256) DEFAULT NULL,
  `Address` varchar(256) DEFAULT NULL,
  `City` varchar(64) DEFAULT NULL,
  `PostalCode` varchar(16) DEFAULT NULL,
  `PhoneNumber` varchar(16) DEFAULT NULL,
  `MajorIntersection` varchar(64) DEFAULT NULL,
  `Experience` varchar(32) DEFAULT NULL,
  `Notes` varchar(8192) DEFAULT NULL,
  `Email` varchar(64) DEFAULT NULL,
  `AdoptionCounsellor` varchar(128) DEFAULT NULL,
  FosterCoordinatorID INT(11),
  PRIMARY KEY (`FosterHomeID`),
  CONSTRAINT `FosterCoordinatorID` FOREIGN KEY (`FosterCoordinatorID`) REFERENCES `FosterCoordinator` (`FosterCoordinatorID`) ON DELETE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FosterHome`
--

LOCK TABLES `FosterHome` WRITE;
/*!40000 ALTER TABLE `FosterHome` DISABLE KEYS */;
/*!40000 ALTER TABLE `FosterHome` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PetStore`
--

DROP TABLE IF EXISTS `PetStore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PetStore` (
  `PetStoreID` int(11) NOT NULL AUTO_INCREMENT,
  `StoreName` varchar(128) DEFAULT NULL,
  `Address` varchar(128) DEFAULT NULL,
  `City` varchar(64) DEFAULT NULL,
  `Phone` varchar(64) DEFAULT NULL,
  `MoneyPickup` varchar(128) DEFAULT NULL,
  `StoreCoordinator` varchar(128) DEFAULT NULL,
  `StoreCoordinatorEmail` varchar(128) DEFAULT NULL,
  `VolunteerCoordinator` varchar(128) DEFAULT NULL,
  `VolunteerCoordinatorEmail` varchar(128) DEFAULT NULL,
  `StoreLead` varchar(128) DEFAULT NULL,
  PRIMARY KEY (`PetStoreID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PetStore`
--

LOCK TABLES `PetStore` WRITE;
/*!40000 ALTER TABLE `PetStore` DISABLE KEYS */;
/*!40000 ALTER TABLE `PetStore` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `UserLogin`
--

DROP TABLE IF EXISTS `UserLogin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `UserLogin` (
  `UserName` varchar(128) NOT NULL,
  `Password` varchar(256) NOT NULL,
  `Name` varchar(256) DEFAULT NULL,
  `Email` varchar(128) DEFAULT NULL,
  `UserRole` varchar(64) DEFAULT NULL,
  `Notes` varchar(2048) DEFAULT NULL,
  PRIMARY KEY (`UserName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `UserLogin`
--

LOCK TABLES `UserLogin` WRITE;
/*!40000 ALTER TABLE `UserLogin` DISABLE KEYS */;
/*!40000 ALTER TABLE `UserLogin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `VetClinic`
--

DROP TABLE IF EXISTS `VetClinic`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `VetClinic` (
  `VetClinicID` int(11) NOT NULL AUTO_INCREMENT,
  `ClinicName` varchar(256) DEFAULT NULL,
  `Address` varchar(256) DEFAULT NULL,
  `City` varchar(64) DEFAULT NULL,
  `PostalCode` varchar(16) DEFAULT NULL,
  `Phone` varchar(16) DEFAULT NULL,
  `Email` varchar(128) DEFAULT NULL,
  `ClinicCoordinator` text DEFAULT NULL,
  PRIMARY KEY (`VetClinicID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `VetClinic`
--

LOCK TABLES `VetClinic` WRITE;
/*!40000 ALTER TABLE `VetClinic` DISABLE KEYS */;
/*!40000 ALTER TABLE `VetClinic` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'torontocatrescue'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-03-31 10:47:33
