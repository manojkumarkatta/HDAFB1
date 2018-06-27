-- phpMyAdmin SQL Dump
-- version 4.8.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 05, 2018 at 08:53 AM
-- Server version: 10.1.32-MariaDB
-- PHP Version: 5.6.36

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `first_demo_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `blood`
--

CREATE TABLE `blood` (
  `Name` varchar(30) NOT NULL,
  `City` varchar(30) NOT NULL,
  `Email` varchar(15) NOT NULL,
  `Phone` varchar(10) NOT NULL,
  `Btype` varchar(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `blood`
--

INSERT INTO `blood` (`Name`, `City`, `Email`, `Phone`, `Btype`) VALUES
('Arun', 'chennai', 'kiran@yahoo.com', '6253211455', 'B+ve'),
('david', 'Hyderabad', 'david@yahoo.com', '9856133221', 'A-ve'),
('ganguly', 'kolkata', 'ganguly@gmail.c', '9300254615', 'B-ve'),
('kiran', 'chennai', 'kiran@yahoo.com', '6253211455', 'B+ve'),
('mittal', 'mumbai', 'mittal@gmail.co', '7802354164', 'AB-ve'),
('Name', 'City', 'Email', 'Phone', 'Blood'),
('Raj', 'Bengaluru', 'Raj@gmail.com', '7702340046', 'A+ve'),
('rose', 'Indore', 'rose@hotmail.co', '8956321562', 'AB-ve'),
('roy', 'pune', 'roy@gmail.com', '9930023155', 'B+ve'),
('sachin', 'Chennai', 'sachn@gmaill.co', '7486213315', 'AB+ve');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `blood`
--
ALTER TABLE `blood`
  ADD PRIMARY KEY (`Name`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
