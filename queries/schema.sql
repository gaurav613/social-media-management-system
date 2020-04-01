/*!40101 SET character_set_client = @saved_cs_client */;

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
);

/*!40101 SET character_set_client = @saved_cs_client */;

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
);

/*!40101 SET character_set_client = @saved_cs_client */;

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
);

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
);

/*!40101 SET character_set_client = @saved_cs_client */;

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
);


/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-03-31 22:27:19
