-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 03, 2020 at 07:52 AM
-- Server version: 10.3.16-MariaDB
-- PHP Version: 7.3.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `smms_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `approvedemployees`
--

CREATE TABLE `approvedemployees` (
  `EmployeeID` smallint(6) NOT NULL,
  `SiteURL` varchar(150) NOT NULL,
  `IsSubscribed` bit(1) NOT NULL DEFAULT b'1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `approvedemployees`
--

INSERT INTO `approvedemployees` (`EmployeeID`, `SiteURL`, `IsSubscribed`) VALUES
(1, 'facebook.com', b'1'),
(1, 'twitter.com', b'1'),
(2, 'facebook.com', b'0'),
(2, 'twitter.com', b'1'),
(3, 'twitter.com', b'1');

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `EmployeeID` smallint(6) NOT NULL,
  `JobTitle` varchar(150) NOT NULL,
  `Name` varchar(150) NOT NULL,
  `AccessLevel` enum('Full','Guest') DEFAULT NULL,
  `isApprover` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `employees`
--

INSERT INTO `employees` (`EmployeeID`, `JobTitle`, `Name`, `AccessLevel`, `isApprover`) VALUES
(1, 'Social Media Manager', 'Jane Doe', 'Full', 1),
(2, 'Head of Social Media', 'Janice Smith', 'Full', 1),
(3, 'Assistant to the Head of Social Media', 'Dwight Schrute', 'Full', 0),
(5, 'Head of HR', 'John Appleseed', 'Full', 0);

-- --------------------------------------------------------

--
-- Table structure for table `liveposts`
--

CREATE TABLE `liveposts` (
  `SiteURL` varchar(150) NOT NULL,
  `PostID` smallint(6) NOT NULL,
  `EmployeeID` smallint(6) NOT NULL,
  `PostUploadTime` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `liveposts`
--

INSERT INTO `liveposts` (`SiteURL`, `PostID`, `EmployeeID`, `PostUploadTime`) VALUES
('facebook.com', 2, 1, '0000-00-00 00:00:00'),
('twitter.com', 1, 1, '0000-00-00 00:00:00'),
('twitter.com', 5, 1, '2000-02-24 00:00:00'),
('twitter.com', 9, 1, '0000-00-00 00:00:00'),
('twitter.com', 9, 5, '0000-00-00 00:00:00'),
('twitter.com', 10, 1, '0000-00-00 00:00:00'),
('twitter.com', 10, 5, '0000-00-00 00:00:00'),
('twitter.com', 11, 1, '0000-00-00 00:00:00'),
('twitter.com', 12, 1, '0000-00-00 00:00:00'),
('twitter.com', 13, 3, '0000-00-00 00:00:00'),
('twitter.com', 14, 3, '0000-00-00 00:00:00'),
('twitter.com', 16, 3, '0000-00-00 00:00:00'),
('twitter.com', 17, 3, '0000-00-00 00:00:00'),
('twitter.com', 18, 5, '0000-00-00 00:00:00'),
('twitter.com', 21, 3, '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `PostID` smallint(6) NOT NULL,
  `IsScheduled` tinyint(1) NOT NULL DEFAULT 0,
  `Status` enum('Draft','Live','Deleted') DEFAULT 'Draft',
  `Content` text DEFAULT NULL,
  `approved` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`PostID`, `IsScheduled`, `Status`, `Content`, `approved`) VALUES
(1, 0, 'Live', 'Hello World!', 1),
(2, 1, 'Live', 'Remember to stay at home.', 1),
(3, 0, 'Live', 'Hello World!', 1),
(4, 1, 'Draft', 'Remember to stay at home.', 0),
(5, 0, 'Live', 'Who wants to get lunch tomorrow?', 1),
(6, 1, 'Live', 'Loo Loo Loo!', 1),
(9, 0, 'Live', 'Test post', 1),
(10, 0, 'Live', 'app test', 1),
(11, 0, 'Live', 'full app test', 1),
(12, 0, 'Live', 'hello world', 1),
(13, 0, 'Live', 'Please keep safe', 1),
(14, 0, 'Live', 'Happy Birthday!', 1),
(16, 0, 'Live', 'Happy Birthday test', 1),
(17, 0, 'Live', 'Get the best deals....', 1),
(18, 0, 'Draft', 'We are looking for software engineers', 0),
(21, 0, 'Draft', 'be the best', 0);

-- --------------------------------------------------------

--
-- Table structure for table `socialmediasites`
--

CREATE TABLE `socialmediasites` (
  `SiteURL` varchar(150) NOT NULL,
  `AccessToken` mediumtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `socialmediasites`
--

INSERT INTO `socialmediasites` (`SiteURL`, `AccessToken`) VALUES
('facebook.com', 'SSdtIGdvaW5nIHRvIHN0ZWFsIGFsbCB5b3VyIGRhdGE='),
('twitter.com', 'aGVsbG8gd29ybGQ=');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `userID` smallint(6) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `EmployeeID` smallint(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`userID`, `username`, `password`, `email`, `EmployeeID`) VALUES
(1, 'janedoe', 'test', 'janedoe@gmail.com', 1),
(6, 'dschrute', 'beetroot', 'dschrute@org.com', 3),
(7, 'jsmith', 'password', 'jsmith@org.com', 2),
(8, 'jpseed', 'password1', 'john.appleseed@org.com', 5);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `approvedemployees`
--
ALTER TABLE `approvedemployees`
  ADD PRIMARY KEY (`EmployeeID`,`SiteURL`),
  ADD KEY `SiteURL` (`SiteURL`);

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`EmployeeID`);

--
-- Indexes for table `liveposts`
--
ALTER TABLE `liveposts`
  ADD PRIMARY KEY (`SiteURL`,`PostID`,`EmployeeID`),
  ADD KEY `PostID` (`PostID`),
  ADD KEY `EmployeeID` (`EmployeeID`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`PostID`);

--
-- Indexes for table `socialmediasites`
--
ALTER TABLE `socialmediasites`
  ADD PRIMARY KEY (`SiteURL`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`userID`),
  ADD KEY `EmployeeID` (`EmployeeID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `employees`
--
ALTER TABLE `employees`
  MODIFY `EmployeeID` smallint(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `PostID` smallint(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `userID` smallint(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `approvedemployees`
--
ALTER TABLE `approvedemployees`
  ADD CONSTRAINT `approvedemployees_ibfk_1` FOREIGN KEY (`EmployeeID`) REFERENCES `employees` (`EmployeeID`),
  ADD CONSTRAINT `approvedemployees_ibfk_2` FOREIGN KEY (`SiteURL`) REFERENCES `socialmediasites` (`SiteURL`);

--
-- Constraints for table `liveposts`
--
ALTER TABLE `liveposts`
  ADD CONSTRAINT `liveposts_ibfk_1` FOREIGN KEY (`PostID`) REFERENCES `posts` (`PostID`),
  ADD CONSTRAINT `liveposts_ibfk_2` FOREIGN KEY (`EmployeeID`) REFERENCES `employees` (`EmployeeID`),
  ADD CONSTRAINT `liveposts_ibfk_3` FOREIGN KEY (`SiteURL`) REFERENCES `socialmediasites` (`SiteURL`);

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`EmployeeID`) REFERENCES `employees` (`EmployeeID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
