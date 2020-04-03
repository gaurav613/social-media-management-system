/*query to create employees table*/
DROP TABLE IF EXISTS `employees`;
CREATE TABLE `employees` (
 `EmployeeID` smallint(6) NOT NULL AUTO_INCREMENT,
 `JobTitle` varchar(150) NOT NULL,
 `Name` varchar(150) NOT NULL,
 `AccessLevel` enum('Full','Guest') DEFAULT NULL,
 `isApprover` tinyint(1) NOT NULL DEFAULT 0,
 PRIMARY KEY (`EmployeeID`)
);

/*query to create posts table*/
DROP TABLE IF EXISTS `posts`;
CREATE TABLE `posts` (
 `PostID` smallint(6) NOT NULL AUTO_INCREMENT,
 `IsScheduled` tinyint(1) NOT NULL DEFAULT 0,
 `Status` enum('Draft','Live','Deleted') DEFAULT 'Draft',
 `Content` text DEFAULT NULL,
 `approved` tinyint(1) NOT NULL DEFAULT 0,
 PRIMARY KEY (`PostID`)
);

/*query to create users table*/
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
 `userID` smallint(6) NOT NULL AUTO_INCREMENT,
 `username` varchar(255) NOT NULL,
 `password` varchar(255) NOT NULL,
 `email` varchar(255) NOT NULL,
 `EmployeeID` smallint(6) NOT NULL,
 PRIMARY KEY (`userID`),
 KEY `EmployeeID` (`EmployeeID`),
 CONSTRAINT `users_ibfk_1` FOREIGN KEY (`EmployeeID`) REFERENCES `employees` (`EmployeeID`)
) ;

/*query to create SocialMediaSites table*/
DROP TABLE IF EXISTS `SocialMediaSites`;
CREATE TABLE `socialmediasites` (
 `SiteURL` varchar(150) NOT NULL,
 `AccessToken` mediumtext NOT NULL,
 PRIMARY KEY (`SiteURL`)
);

/*query to create LivePosts table*/
DROP TABLE IF EXISTS `LivePosts`;
CREATE TABLE `liveposts` (
 `SiteURL` varchar(150) NOT NULL,
 `PostID` smallint(6) NOT NULL,
 `EmployeeID` smallint(6) NOT NULL,
 `PostUploadTime` datetime NOT NULL,
 PRIMARY KEY (`SiteURL`,`PostID`,`EmployeeID`),
 KEY `PostID` (`PostID`),
 KEY `EmployeeID` (`EmployeeID`),
 CONSTRAINT `liveposts_ibfk_1` FOREIGN KEY (`PostID`) REFERENCES `posts` (`PostID`),
 CONSTRAINT `liveposts_ibfk_2` FOREIGN KEY (`EmployeeID`) REFERENCES `employees` (`EmployeeID`),
 CONSTRAINT `liveposts_ibfk_3` FOREIGN KEY (`SiteURL`) REFERENCES `socialmediasites` (`SiteURL`)
);

/*query to create ApprovedEmployees table*/
DROP TABLE IF EXISTS `ApprovedEmployees`;
CREATE TABLE `approvedemployees` (
 `EmployeeID` smallint(6) NOT NULL,
 `SiteURL` varchar(150) NOT NULL,
 `IsSubscribed` bit(1) NOT NULL DEFAULT b'1',
 PRIMARY KEY (`EmployeeID`,`SiteURL`),
 KEY `SiteURL` (`SiteURL`),
 CONSTRAINT `approvedemployees_ibfk_1` FOREIGN KEY (`EmployeeID`) REFERENCES `employees` (`EmployeeID`),
 CONSTRAINT `approvedemployees_ibfk_2` FOREIGN KEY (`SiteURL`) REFERENCES `socialmediasites` (`SiteURL`)
);




	

