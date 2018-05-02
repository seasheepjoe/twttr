-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Apr 15, 2018 at 09:13 PM
-- Server version: 5.7.19
-- PHP Version: 7.1.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `twttr`
--

-- --------------------------------------------------------

--
-- Table structure for table `favs`
--

DROP TABLE IF EXISTS `favs`;
CREATE TABLE IF NOT EXISTS `favs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `twtt_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `followers`
--

DROP TABLE IF EXISTS `followers`;
CREATE TABLE IF NOT EXISTS `followers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `following`
--

DROP TABLE IF EXISTS `following`;
CREATE TABLE IF NOT EXISTS `following` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `rtwtt`
--

DROP TABLE IF EXISTS `rtwtt`;
CREATE TABLE IF NOT EXISTS `rtwtt` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `twtt_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `twtts`
--

DROP TABLE IF EXISTS `twtts`;
CREATE TABLE IF NOT EXISTS `twtts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rt` tinyint(1) NOT NULL,
  `author` varchar(255) NOT NULL,
  `content` varchar(255) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `twtts`
--

INSERT INTO `twtts` (`id`, `rt`, `author`, `content`, `date`) VALUES
(1, 0, '31', 'dzdzdz', '2018-04-15 15:33:29'),
(2, 0, '31', 'dzdzdzd', '2018-04-15 17:52:26'),
(3, 0, '31', 'dzzdz', '2018-04-15 17:56:23'),
(4, 0, '31', 'dzzdz', '2018-04-15 17:56:25'),
(5, 0, '31', 'Wesh la street', '2018-04-15 18:00:01'),
(6, 0, '31', 'Wesh la street', '2018-04-15 18:00:24'),
(7, 0, '31', 'WEHS DIZHDZIUDGZYDBPZ', '2018-04-15 18:03:46'),
(8, 0, '32', 'robinet wesh\r\n', '2018-04-15 18:07:17'),
(9, 0, '33', 'Salut Twttr je m\'appelle didier\r\n', '2018-04-15 18:10:22');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `last_login` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `pp_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=34 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `last_login`, `pp_url`) VALUES
(24, 'pppppppppppp', 'ppppppppppp@p.p', '$2y$10$dOepIKpNL/4da.OP/ml5yuDhE3UJOVzkmKJELIVy0WgsFonhV0cY6', '2018-04-11 15:50:59', NULL),
(23, 'Kevin', 'kevin@kevin.kevin', '$2y$10$T700joJUTbYAiM.KRLY4WOZ2tIhavPfU63xDr6b3YGVrHrQtwWwnS', '2018-04-11 15:43:42', NULL),
(25, 'Krozakof', 'loiseaubillonlouis@gmail.com', '$2y$10$hS92S19KM6hPXfELm/2fE.q17jTrbkYtvZtLMKD6x96eSGJwhK1pm', '2018-04-12 11:52:55', NULL),
(26, 'Neil', 'neilrichter@gmail.com', '$2y$10$rGfJM1BGUGPc.PhF3ngJS.RWdCydCNjDoTTkuDzVnWd5vr.ByGQ9G', '2018-04-12 11:53:49', NULL),
(27, 'Bennn', 'ebn@ben.neb', '$2y$10$FQeuD4kClSEEX.cnAjFwN.9K.8NN9eZpFT8PxvIqDFv6Zqvc/Cx6G', '2018-04-12 11:55:56', NULL),
(28, 'Pasaasa', 'asazdz@dkzzkd.Dz', '$2y$10$gKBw.qS1gyAOjsjuzz.rd.AX7jgQU58.VDL4SSq0MLvn0SZ2Re4/u', '2018-04-12 13:36:44', NULL),
(29, 'ANtoinzdzd', 'dzdzdzd@dzdz.czdzdz', '$2y$10$2Q8oDWZc/ElRrDzmkA6mI.Wlfjz5YJiOXlussWxvIVkGVmatKC1ji', '2018-04-12 14:42:29', NULL),
(30, 'zdzdzdzhdzudzudu', 'd@d.d', '$2y$10$GSiRJIOTg2qz5oSA7Tj9.eBzx7zistnK6b4W.p6p863mkWk2ujyx6', '2018-04-12 14:50:03', NULL),
(31, 'Papaya', 'sunny@papaya.toogood', '$2y$10$IO.sYwlzh0QeTKzk19gs8Om9Zawg/IPneFh/x7lkrFFPlbWUq88CG', '2018-04-15 17:48:41', './assets/pp/31_pp.jpeg'),
(32, 'Robert', 'rob@rob.rob', '$2y$10$gj0ZA7f5CWAwhlB4HuHDuu0/Jo/wF7tS/mzQQWCwoKD08WvLOb3Jy', '2018-04-15 18:07:04', './assets/pp/32_pp.png'),
(33, 'didier', 'di@di.di', '$2y$10$qXKriYxc6xyK3Zy8Fl1rou4iKHAm6Lnlv7E7G9ARZ.p/m0ECd.ilm', '2018-04-15 18:09:33', NULL);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
