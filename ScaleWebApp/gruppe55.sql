-- phpMyAdmin SQL Dump
-- version 4.1.6
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Jun 20, 2014 at 08:54 AM
-- Server version: 5.6.16
-- PHP Version: 5.5.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `gruppe55`
--
CREATE DATABASE IF NOT EXISTS `gruppe55` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;
USE `gruppe55`;

-- --------------------------------------------------------

--
-- Table structure for table `matbatch`
--

CREATE TABLE IF NOT EXISTS `matbatch` (
  `mb_id` int(11) NOT NULL,
  `m_id` int(11) NOT NULL,
  `amount` double NOT NULL,
  PRIMARY KEY (`mb_id`),
  KEY `mbFk_543` (`m_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `matbatch`
--

INSERT INTO `matbatch` (`mb_id`, `m_id`, `amount`) VALUES
(10200000, 10000001, 10000),
(20030050, 10000003, 33000);

-- --------------------------------------------------------

--
-- Table structure for table `materials`
--

CREATE TABLE IF NOT EXISTS `materials` (
  `m_id` int(11) NOT NULL,
  `m_name` varchar(100) COLLATE utf8_bin NOT NULL,
  `supplier` varchar(100) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`m_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `materials`
--

INSERT INTO `materials` (`m_id`, `m_name`, `supplier`) VALUES
(10000001, 'Paracetamol', 'Bents Biokemi'),
(10000002, 'Acetylsyre', 'Bents Biokemi'),
(10000003, 'Salt', 'Stens Saltminer'),
(20040100, 'Chlorid', 'Carstens Chemistry Company'),
(40005000, 'Natrium', 'Niels Natrium'),
(90030002, 'Magnesium', 'Carstens Chemistry Company');

-- --------------------------------------------------------

--
-- Table structure for table `pbcomponent`
--

CREATE TABLE IF NOT EXISTS `pbcomponent` (
  `pb_id` int(11) NOT NULL,
  `mb_id` int(11) NOT NULL,
  `netto` double NOT NULL,
  `tara` double NOT NULL,
  `u_id` int(11) NOT NULL,
  PRIMARY KEY (`pb_id`,`mb_id`),
  KEY `mb_id` (`mb_id`),
  KEY `pbcomFk3` (`u_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `precomponent`
--

CREATE TABLE IF NOT EXISTS `precomponent` (
  `pre_id` int(11) NOT NULL,
  `m_id` int(11) NOT NULL,
  `netto` double NOT NULL,
  `tolerance` double NOT NULL,
  PRIMARY KEY (`pre_id`,`m_id`),
  KEY `m_id` (`m_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `precomponent`
--

INSERT INTO `precomponent` (`pre_id`, `m_id`, `netto`, `tolerance`) VALUES
(10020030, 10000001, 10, 0.5),
(10020030, 10000002, 200, 5),
(20003001, 10000001, 100, 1),
(20003001, 10000003, 5, 0.5),
(20003001, 20040100, 30, 5);

-- --------------------------------------------------------

--
-- Table structure for table `prescription`
--

CREATE TABLE IF NOT EXISTS `prescription` (
  `pre_id` int(11) NOT NULL,
  `pre_name` varchar(100) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`pre_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `prescription`
--

INSERT INTO `prescription` (`pre_id`, `pre_name`) VALUES
(10020030, 'Hovedpinepiller'),
(20003001, 'Smertestillende');

-- --------------------------------------------------------

--
-- Table structure for table `productbatch`
--

CREATE TABLE IF NOT EXISTS `productbatch` (
  `pb_id` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  `pre_id` int(11) NOT NULL,
  PRIMARY KEY (`pb_id`),
  KEY `probFk1` (`pre_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `productbatch`
--

INSERT INTO `productbatch` (`pb_id`, `status`, `pre_id`) VALUES
(10002040, 0, 20003001),
(20300401, 0, 10020030),
(40030200, 0, 10020030);

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE IF NOT EXISTS `suppliers` (
  `s_id` int(11) NOT NULL,
  `s_name` varchar(100) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`s_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `u_id` int(11) NOT NULL,
  `u_name` varchar(100) COLLATE utf8_bin NOT NULL,
  `u_cpr` varchar(10) COLLATE utf8_bin NOT NULL,
  `password` varchar(100) COLLATE utf8_bin NOT NULL,
  `u_level` int(11) NOT NULL,
  `u_active` int(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`u_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`u_id`, `u_name`, `u_cpr`, `password`, `u_level`, `u_active`) VALUES
(10203040, 'Kristin Hansen', '0512872573', 'asdASD123', 1, 1),
(20103040, 'Lars Peter Jensen', '1205560012', 'asdASD123', 2, 1),
(30104020, 'Malte Magnussen', '1112051025', 'asdASD123', 3, 1),
(30401020, 'Leo Jiahua', '3101872210', 'asdASD123', 3, 0),
(40103020, 'Anders Larsen', '2507402211', 'asdASD123', 4, 0);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `matbatch`
--
ALTER TABLE `matbatch`
  ADD CONSTRAINT `mbFk_1` FOREIGN KEY (`m_id`) REFERENCES `materials` (`m_id`);

--
-- Constraints for table `pbcomponent`
--
ALTER TABLE `pbcomponent`
  ADD CONSTRAINT `pbcomFk1` FOREIGN KEY (`pb_id`) REFERENCES `productbatch` (`pb_id`),
  ADD CONSTRAINT `pbcomFk2` FOREIGN KEY (`mb_id`) REFERENCES `matbatch` (`mb_id`),
  ADD CONSTRAINT `pbcomFk3` FOREIGN KEY (`u_id`) REFERENCES `user` (`u_id`);

--
-- Constraints for table `precomponent`
--
ALTER TABLE `precomponent`
  ADD CONSTRAINT `precFk1` FOREIGN KEY (`m_id`) REFERENCES `materials` (`m_id`),
  ADD CONSTRAINT `precFk2` FOREIGN KEY (`pre_id`) REFERENCES `prescription` (`pre_id`);

--
-- Constraints for table `productbatch`
--
ALTER TABLE `productbatch`
  ADD CONSTRAINT `probFk1` FOREIGN KEY (`pre_id`) REFERENCES `prescription` (`pre_id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
