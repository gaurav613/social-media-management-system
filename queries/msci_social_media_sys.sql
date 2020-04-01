-- MySQL dump 10.13  Distrib 8.0.19, for osx10.15 (x86_64)
--
-- Host: localhost    Database: msci_social_media_sys
-- ------------------------------------------------------
-- Server version	8.0.19

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `ApprovedEmployees`
--

DROP TABLE IF EXISTS `ApprovedEmployees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ApprovedEmployees` (
  `EmployeeID` smallint NOT NULL,
  `SiteURL` varchar(150) NOT NULL,
  `IsSubscribed` bit(1) NOT NULL DEFAULT b'1',
  PRIMARY KEY (`EmployeeID`,`SiteURL`),
  KEY `SiteURL` (`SiteURL`),
  CONSTRAINT `approvedemployees_ibfk_1` FOREIGN KEY (`EmployeeID`) REFERENCES `Employees` (`EmployeeID`),
  CONSTRAINT `approvedemployees_ibfk_2` FOREIGN KEY (`SiteURL`) REFERENCES `SocialMediaSites` (`SiteURL`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ApprovedEmployees`
--

LOCK TABLES `ApprovedEmployees` WRITE;
/*!40000 ALTER TABLE `ApprovedEmployees` DISABLE KEYS */;
INSERT INTO `ApprovedEmployees` VALUES (1,'facebook.com',_binary ''),(1,'twitter.com',_binary ''),(2,'facebook.com',_binary '\0'),(2,'twitter.com',_binary ''),(3,'twitter.com',_binary '');
/*!40000 ALTER TABLE `ApprovedEmployees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Employees`
--

DROP TABLE IF EXISTS `Employees`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Employees` (
  `EmployeeID` smallint NOT NULL AUTO_INCREMENT,
  `JobTitle` varchar(150) NOT NULL,
  `Name` varchar(150) NOT NULL,
  `AccessLevel` enum('Full','Guest') DEFAULT NULL,
  PRIMARY KEY (`EmployeeID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Employees`
--

LOCK TABLES `Employees` WRITE;
/*!40000 ALTER TABLE `Employees` DISABLE KEYS */;
INSERT INTO `Employees` VALUES (1,'Social Media Manager','Jane Doe','Full'),(2,'Head of Social Media','Janice Smith','Full'),(3,'Assistant to the Head of Social Media','Dwight Schrute','Full'),(4,'Contractor','Beep Boop','Guest');
/*!40000 ALTER TABLE `Employees` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LivePosts`
--

DROP TABLE IF EXISTS `LivePosts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `LivePosts` (
  `SiteURL` varchar(150) NOT NULL,
  `PostID` smallint NOT NULL,
  `EmployeeID` smallint NOT NULL,
  `PostUploadTime` datetime NOT NULL,
  PRIMARY KEY (`SiteURL`,`PostID`,`EmployeeID`),
  KEY `PostID` (`PostID`),
  KEY `EmployeeID` (`EmployeeID`),
  CONSTRAINT `liveposts_ibfk_1` FOREIGN KEY (`PostID`) REFERENCES `Posts` (`PostID`),
  CONSTRAINT `liveposts_ibfk_2` FOREIGN KEY (`EmployeeID`) REFERENCES `Employees` (`EmployeeID`),
  CONSTRAINT `liveposts_ibfk_3` FOREIGN KEY (`SiteURL`) REFERENCES `SocialMediaSites` (`SiteURL`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LivePosts`
--

LOCK TABLES `LivePosts` WRITE;
/*!40000 ALTER TABLE `LivePosts` DISABLE KEYS */;
/*!40000 ALTER TABLE `LivePosts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Posts`
--

DROP TABLE IF EXISTS `Posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Posts` (
  `PostID` smallint NOT NULL AUTO_INCREMENT,
  `IsScheduled` bit(1) NOT NULL DEFAULT b'0',
  `Status` enum('Draft','Live','Deleted') DEFAULT 'Draft',
  `Content` text,
  PRIMARY KEY (`PostID`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Posts`
--

LOCK TABLES `Posts` WRITE;
/*!40000 ALTER TABLE `Posts` DISABLE KEYS */;
INSERT INTO `Posts` VALUES (1,_binary '\0','Live','Hello World!'),(2,_binary '','Draft','Remember to stay at home.'),(3,_binary '\0','Live','Hello World!'),(4,_binary '','Draft','Remember to stay at home.'),(5,_binary '\0','Deleted','Who wants to get lunch tomorrow?'),(6,_binary '','Live','Loo Loo Loo!');
/*!40000 ALTER TABLE `Posts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `SocialMediaSites`
--

DROP TABLE IF EXISTS `SocialMediaSites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `SocialMediaSites` (
  `SiteURL` varchar(150) NOT NULL,
  `AccessToken` mediumtext NOT NULL,
  PRIMARY KEY (`SiteURL`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SocialMediaSites`
--

LOCK TABLES `SocialMediaSites` WRITE;
/*!40000 ALTER TABLE `SocialMediaSites` DISABLE KEYS */;
INSERT INTO `SocialMediaSites` VALUES ('facebook.com','SSdtIGdvaW5nIHRvIHN0ZWFsIGFsbCB5b3VyIGRhdGE='),('twitter.com','aGVsbG8gd29ybGQ=');
/*!40000 ALTER TABLE `SocialMediaSites` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-03-31 23:46:11
