-- phpMyAdmin SQL Dump
-- version 4.6.6deb5
-- https://www.phpmyadmin.net/
--
-- Client :  localhost:3306
-- Généré le :  Mer 16 Mai 2018 à 22:46
-- Version du serveur :  5.7.22-0ubuntu0.17.10.1
-- Version de PHP :  7.1.17-1+ubuntu17.10.1+deb.sury.org+1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `twttr`
--

-- --------------------------------------------------------

--
-- Structure de la table `favs`
--

CREATE TABLE `favs` (
  `id` int(11) NOT NULL,
  `twtt_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Contenu de la table `favs`
--

INSERT INTO `favs` (`id`, `twtt_id`, `user_id`) VALUES
(1, 3, 4),
(2, 4, 3),
(17, 1, 1),
(18, 95, 8),
(22, 123, 1),
(24, 127, 25),
(25, 130, 36),
(26, 133, 43),
(28, 139, 46),
(30, 241, 1);

-- --------------------------------------------------------

--
-- Structure de la table `follows`
--

CREATE TABLE `follows` (
  `id` int(11) NOT NULL,
  `follower` int(11) NOT NULL,
  `followed` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `follows`
--

INSERT INTO `follows` (`id`, `follower`, `followed`) VALUES
(53, 1, 2),
(57, 1, 4),
(58, 31, 1),
(59, 8, 1),
(60, 1, 8),
(61, 1, 10),
(62, 25, 1),
(63, 43, 1),
(64, 46, 1);

-- --------------------------------------------------------

--
-- Structure de la table `rtwtt`
--

CREATE TABLE `rtwtt` (
  `id` int(11) NOT NULL,
  `twtt_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Contenu de la table `rtwtt`
--

INSERT INTO `rtwtt` (`id`, `twtt_id`, `user_id`) VALUES
(1, 1, 3),
(3, 4, 3),
(4, 4, 4),
(41, 46, 3),
(40, 3, 1),
(42, 47, 3),
(48, 71, 1),
(47, 95, 8),
(53, 107, 10),
(54, 111, 10),
(55, 110, 10),
(56, 109, 10),
(57, 108, 10),
(58, 115, 10),
(59, 114, 10),
(60, 113, 10),
(61, 112, 10),
(62, 106, 1),
(66, 127, 25),
(68, 130, 36),
(69, 133, 43),
(70, 134, 43),
(71, 135, 43),
(72, 136, 43),
(83, 182, 43),
(84, 192, 43),
(97, 224, 47);

-- --------------------------------------------------------

--
-- Structure de la table `twtts`
--

CREATE TABLE `twtts` (
  `id` int(11) NOT NULL,
  `rt` tinyint(1) DEFAULT NULL,
  `rt_author` int(11) DEFAULT NULL,
  `original_twtt` int(11) DEFAULT NULL,
  `author` varchar(255) NOT NULL,
  `content` varchar(255) NOT NULL,
  `date` datetime NOT NULL,
  `post_time` datetime DEFAULT CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Contenu de la table `twtts`
--

INSERT INTO `twtts` (`id`, `rt`, `rt_author`, `original_twtt`, `author`, `content`, `date`, `post_time`) VALUES
(1, NULL, NULL, NULL, '1', 'coucou', '2018-05-08 20:45:09', '2018-05-08 20:45:09'),
(2, NULL, NULL, NULL, '1', 'Coucou @Louis', '2018-05-08 20:45:36', '2018-05-08 20:45:36'),
(3, NULL, NULL, NULL, '3', 'Coucou @Neil', '2018-05-08 22:11:02', '2018-05-08 22:11:02'),
(4, NULL, NULL, NULL, '4', 'Coucou', '2018-05-09 12:31:24', '2018-05-09 12:31:24'),
(5, NULL, NULL, NULL, '6', 'Wesh', '2018-05-09 17:21:34', '2018-05-09 17:21:34'),
(49, NULL, NULL, NULL, '8', 'hello\r\n', '2018-05-10 19:21:08', '2018-05-10 19:21:07'),
(48, 1, 3, NULL, '1', 'oups', '2018-05-10 17:46:22', '2018-05-10 18:14:50'),
(47, 1, 3, NULL, '1', 'oups', '2018-05-10 17:46:22', '2018-05-10 18:14:45'),
(39, 1, 1, NULL, '4', 'Coucou', '2018-05-09 12:31:24', '2018-05-10 16:39:17'),
(46, NULL, NULL, NULL, '1', 'oups', '2018-05-10 17:46:22', '2018-05-10 17:46:22'),
(45, 1, 1, NULL, '3', 'Coucou @Neil', '2018-05-08 22:11:02', '2018-05-10 17:14:56'),
(50, NULL, NULL, NULL, '8', 'Test #1\r\n', '2018-05-10 19:21:19', '2018-05-10 19:21:18'),
(51, NULL, NULL, NULL, '8', 'Test #2', '2018-05-10 19:21:26', '2018-05-10 19:21:25'),
(52, NULL, NULL, NULL, '8', 'Test #3', '2018-05-10 19:22:34', '2018-05-10 19:22:33'),
(53, NULL, NULL, NULL, '8', 'Test #4', '2018-05-10 19:22:40', '2018-05-10 19:22:39'),
(54, NULL, NULL, NULL, '8', 'Test #5', '2018-05-10 19:22:48', '2018-05-10 19:22:47'),
(55, NULL, NULL, NULL, '8', 'Test #6', '2018-05-10 19:22:55', '2018-05-10 19:22:54'),
(56, NULL, NULL, NULL, '8', 'Test #7', '2018-05-10 19:23:05', '2018-05-10 19:23:05'),
(57, NULL, NULL, NULL, '8', 'Test #1', '2018-05-10 19:31:03', '2018-05-10 19:31:02'),
(58, NULL, NULL, NULL, '8', 'Test #2', '2018-05-10 19:33:44', '2018-05-10 19:33:44'),
(59, NULL, NULL, NULL, '8', 'Test #3', '2018-05-10 19:33:51', '2018-05-10 19:33:50'),
(60, NULL, NULL, NULL, '8', 'Test #4', '2018-05-10 19:33:57', '2018-05-10 19:33:56'),
(61, NULL, NULL, NULL, '8', 'Test #5', '2018-05-10 19:34:04', '2018-05-10 19:34:03'),
(62, NULL, NULL, NULL, '8', 'Test #6', '2018-05-10 19:34:10', '2018-05-10 19:34:09'),
(63, NULL, NULL, NULL, '8', 'Test #7', '2018-05-10 19:34:21', '2018-05-10 19:34:20'),
(64, NULL, NULL, NULL, '8', 'Test #8', '2018-05-10 19:34:30', '2018-05-10 19:34:29'),
(65, NULL, NULL, NULL, '8', 'Test #9', '2018-05-10 19:34:38', '2018-05-10 19:34:37'),
(66, NULL, NULL, NULL, '8', 'Test #10', '2018-05-10 19:34:47', '2018-05-10 19:34:46'),
(67, NULL, NULL, NULL, '8', 'Test #11', '2018-05-10 19:35:52', '2018-05-10 19:35:52'),
(68, NULL, NULL, NULL, '8', 'Test #12', '2018-05-10 19:36:02', '2018-05-10 19:36:01'),
(69, NULL, NULL, NULL, '8', 'Test #13', '2018-05-10 19:36:09', '2018-05-10 19:36:08'),
(70, NULL, NULL, NULL, '8', 'Test #14', '2018-05-10 19:36:17', '2018-05-10 19:36:16'),
(71, NULL, NULL, NULL, '8', 'Test #15', '2018-05-10 19:36:27', '2018-05-10 19:36:26'),
(72, NULL, NULL, NULL, '8', 'Test #16', '2018-05-10 19:36:39', '2018-05-10 19:36:39'),
(73, NULL, NULL, NULL, '8', 'Test #17', '2018-05-10 19:36:47', '2018-05-10 19:36:46'),
(74, NULL, NULL, NULL, '8', 'Test #18', '2018-05-10 19:36:55', '2018-05-10 19:36:54'),
(75, NULL, NULL, NULL, '8', 'Test #19', '2018-05-10 19:37:02', '2018-05-10 19:37:01'),
(76, NULL, NULL, NULL, '8', 'Test #20', '2018-05-10 19:37:10', '2018-05-10 19:37:09'),
(77, NULL, NULL, NULL, '1', 'Test #1', '2018-05-10 19:39:17', '2018-05-10 19:39:17'),
(78, NULL, NULL, NULL, '1', 'Test #2', '2018-05-10 19:39:21', '2018-05-10 19:39:21'),
(79, NULL, NULL, NULL, '1', 'Test #3', '2018-05-10 19:39:26', '2018-05-10 19:39:26'),
(80, NULL, NULL, NULL, '1', 'Test #4', '2018-05-10 19:39:29', '2018-05-10 19:39:29'),
(81, NULL, NULL, NULL, '1', 'Test #5', '2018-05-10 19:39:33', '2018-05-10 19:39:33'),
(82, NULL, NULL, NULL, '1', 'Test #6', '2018-05-10 19:39:36', '2018-05-10 19:39:36'),
(83, NULL, NULL, NULL, '1', 'Test #7', '2018-05-10 19:39:39', '2018-05-10 19:39:39'),
(84, NULL, NULL, NULL, '1', 'Test #8', '2018-05-10 19:39:43', '2018-05-10 19:39:43'),
(85, NULL, NULL, NULL, '1', 'Test #9', '2018-05-10 19:39:46', '2018-05-10 19:39:46'),
(86, NULL, NULL, NULL, '1', 'Test #9', '2018-05-10 19:39:51', '2018-05-10 19:39:51'),
(87, NULL, NULL, NULL, '1', 'Test #10', '2018-05-10 19:39:55', '2018-05-10 19:39:55'),
(88, NULL, NULL, NULL, '1', 'Test #11', '2018-05-10 19:39:59', '2018-05-10 19:39:59'),
(89, NULL, NULL, NULL, '1', 'Test #12', '2018-05-10 19:40:02', '2018-05-10 19:40:02'),
(90, NULL, NULL, NULL, '1', 'Test #13', '2018-05-10 19:40:05', '2018-05-10 19:40:05'),
(91, NULL, NULL, NULL, '1', 'Test #14', '2018-05-10 19:40:09', '2018-05-10 19:40:09'),
(92, NULL, NULL, NULL, '1', 'Test #15', '2018-05-10 19:40:12', '2018-05-10 19:40:12'),
(93, NULL, NULL, NULL, '1', 'Test #16', '2018-05-10 19:40:16', '2018-05-10 19:40:16'),
(94, NULL, NULL, NULL, '1', 'Test #17', '2018-05-10 19:40:20', '2018-05-10 19:40:20'),
(95, NULL, NULL, NULL, '1', 'Test #18', '2018-05-10 19:40:25', '2018-05-10 19:40:25'),
(96, NULL, NULL, NULL, '1', 'Test #19', '2018-05-10 19:40:29', '2018-05-10 19:40:29'),
(97, NULL, NULL, NULL, '1', 'Test #20', '2018-05-10 19:40:34', '2018-05-10 19:40:34'),
(104, 1, 1, NULL, '8', 'Test #15', '2018-05-10 19:36:27', '2018-05-10 22:24:46'),
(100, NULL, NULL, NULL, '1', 'What time is it', '2018-05-10 22:06:43', '2018-05-10 20:06:43'),
(103, 1, 8, NULL, '1', 'Test #18', '2018-05-10 19:40:25', '2018-05-10 20:12:01'),
(105, NULL, NULL, NULL, '10', 'w\'aÃ©zqerstdyfugihoÃ¨-(\'\"Ã©&\"\'(-Ã¨_Ã§Ã _Ã§Ã¨-(\'(\"\'Ã©\"\'(-Ã¨_5135648945+9966+-*/+963\r\niugyftdrtyfguhijokp^Ã§u_Ã yÃ¨t-r(Ã¨e\'-', '2018-05-11 13:53:18', '2018-05-11 13:53:18'),
(106, NULL, NULL, NULL, '10', 'ijoooklnkjknk', '2018-05-11 13:53:30', '2018-05-11 13:53:30'),
(107, 1, 10, NULL, '10', 'w\'aÃ©zqerstdyfugihoÃ¨-(\'\"Ã©&\"\'(-Ã¨_Ã§Ã _Ã§Ã¨-(\'(\"\'Ã©\"\'(-Ã¨_5135648945+9966+-*/+963\r\niugyftdrtyfguhijokp^Ã§u_Ã yÃ¨t-r(Ã¨e\'-', '2018-05-11 13:53:18', '2018-05-11 13:53:34'),
(108, 1, 10, NULL, '10', 'w\'aÃ©zqerstdyfugihoÃ¨-(\'\"Ã©&\"\'(-Ã¨_Ã§Ã _Ã§Ã¨-(\'(\"\'Ã©\"\'(-Ã¨_5135648945+9966+-*/+963\r\niugyftdrtyfguhijokp^Ã§u_Ã yÃ¨t-r(Ã¨e\'-', '2018-05-11 13:53:18', '2018-05-11 13:53:56'),
(109, 1, 10, NULL, '10', 'w\'aÃ©zqerstdyfugihoÃ¨-(\'\"Ã©&\"\'(-Ã¨_Ã§Ã _Ã§Ã¨-(\'(\"\'Ã©\"\'(-Ã¨_5135648945+9966+-*/+963\r\niugyftdrtyfguhijokp^Ã§u_Ã yÃ¨t-r(Ã¨e\'-', '2018-05-11 13:53:18', '2018-05-11 13:54:06'),
(110, 1, 10, NULL, '10', 'w\'aÃ©zqerstdyfugihoÃ¨-(\'\"Ã©&\"\'(-Ã¨_Ã§Ã _Ã§Ã¨-(\'(\"\'Ã©\"\'(-Ã¨_5135648945+9966+-*/+963\r\niugyftdrtyfguhijokp^Ã§u_Ã yÃ¨t-r(Ã¨e\'-', '2018-05-11 13:53:18', '2018-05-11 13:54:06'),
(111, 1, 10, NULL, '10', 'w\'aÃ©zqerstdyfugihoÃ¨-(\'\"Ã©&\"\'(-Ã¨_Ã§Ã _Ã§Ã¨-(\'(\"\'Ã©\"\'(-Ã¨_5135648945+9966+-*/+963\r\niugyftdrtyfguhijokp^Ã§u_Ã yÃ¨t-r(Ã¨e\'-', '2018-05-11 13:53:18', '2018-05-11 13:54:10'),
(112, 1, 10, NULL, '10', 'w\'aÃ©zqerstdyfugihoÃ¨-(\'\"Ã©&\"\'(-Ã¨_Ã§Ã _Ã§Ã¨-(\'(\"\'Ã©\"\'(-Ã¨_5135648945+9966+-*/+963\r\niugyftdrtyfguhijokp^Ã§u_Ã yÃ¨t-r(Ã¨e\'-', '2018-05-11 13:53:18', '2018-05-11 13:54:23'),
(113, 1, 10, NULL, '10', 'w\'aÃ©zqerstdyfugihoÃ¨-(\'\"Ã©&\"\'(-Ã¨_Ã§Ã _Ã§Ã¨-(\'(\"\'Ã©\"\'(-Ã¨_5135648945+9966+-*/+963\r\niugyftdrtyfguhijokp^Ã§u_Ã yÃ¨t-r(Ã¨e\'-', '2018-05-11 13:53:18', '2018-05-11 13:54:25'),
(114, 1, 10, NULL, '10', 'w\'aÃ©zqerstdyfugihoÃ¨-(\'\"Ã©&\"\'(-Ã¨_Ã§Ã _Ã§Ã¨-(\'(\"\'Ã©\"\'(-Ã¨_5135648945+9966+-*/+963\r\niugyftdrtyfguhijokp^Ã§u_Ã yÃ¨t-r(Ã¨e\'-', '2018-05-11 13:53:18', '2018-05-11 13:54:26'),
(115, 1, 10, NULL, '10', 'w\'aÃ©zqerstdyfugihoÃ¨-(\'\"Ã©&\"\'(-Ã¨_Ã§Ã _Ã§Ã¨-(\'(\"\'Ã©\"\'(-Ã¨_5135648945+9966+-*/+963\r\niugyftdrtyfguhijokp^Ã§u_Ã yÃ¨t-r(Ã¨e\'-', '2018-05-11 13:53:18', '2018-05-11 13:54:29'),
(116, 1, 10, NULL, '10', 'w\'aÃ©zqerstdyfugihoÃ¨-(\'\"Ã©&\"\'(-Ã¨_Ã§Ã _Ã§Ã¨-(\'(\"\'Ã©\"\'(-Ã¨_5135648945+9966+-*/+963\r\niugyftdrtyfguhijokp^Ã§u_Ã yÃ¨t-r(Ã¨e\'-', '2018-05-11 13:53:18', '2018-05-11 13:55:11'),
(117, 1, 10, NULL, '10', 'w\'aÃ©zqerstdyfugihoÃ¨-(\'\"Ã©&\"\'(-Ã¨_Ã§Ã _Ã§Ã¨-(\'(\"\'Ã©\"\'(-Ã¨_5135648945+9966+-*/+963\r\niugyftdrtyfguhijokp^Ã§u_Ã yÃ¨t-r(Ã¨e\'-', '2018-05-11 13:53:18', '2018-05-11 13:55:12'),
(118, 1, 10, NULL, '10', 'w\'aÃ©zqerstdyfugihoÃ¨-(\'\"Ã©&\"\'(-Ã¨_Ã§Ã _Ã§Ã¨-(\'(\"\'Ã©\"\'(-Ã¨_5135648945+9966+-*/+963\r\niugyftdrtyfguhijokp^Ã§u_Ã yÃ¨t-r(Ã¨e\'-', '2018-05-11 13:53:18', '2018-05-11 13:55:14'),
(119, 1, 10, NULL, '10', 'w\'aÃ©zqerstdyfugihoÃ¨-(\'\"Ã©&\"\'(-Ã¨_Ã§Ã _Ã§Ã¨-(\'(\"\'Ã©\"\'(-Ã¨_5135648945+9966+-*/+963\r\niugyftdrtyfguhijokp^Ã§u_Ã yÃ¨t-r(Ã¨e\'-', '2018-05-11 13:53:18', '2018-05-11 13:55:15'),
(120, NULL, NULL, NULL, '11', 'Cc', '2018-05-11 16:32:03', '2018-05-11 16:32:03'),
(121, NULL, NULL, NULL, '11', 'Incroyable ', '2018-05-11 16:32:14', '2018-05-11 16:32:14'),
(122, 1, 1, NULL, '10', 'ijoooklnkjknk', '2018-05-11 13:53:30', '2018-05-11 17:39:13'),
(123, NULL, NULL, NULL, '1', 'popilop', '2018-05-11 17:47:34', '2018-05-11 17:47:34'),
(127, NULL, NULL, NULL, '25', 'cc', '2018-05-12 14:45:06', '2018-05-12 14:45:06'),
(128, 1, 25, 127, '25', 'cc', '2018-05-12 14:45:06', '2018-05-12 14:45:07'),
(129, NULL, NULL, NULL, '35', 'yalalal', '2018-05-12 16:29:46', '2018-05-12 16:29:46'),
(130, NULL, NULL, NULL, '36', 'rtyui', '2018-05-12 16:48:29', '2018-05-12 16:48:29'),
(132, 1, 36, 130, '36', 'rtyui', '2018-05-12 16:48:29', '2018-05-12 16:48:34'),
(163, NULL, NULL, NULL, '43', 'lol hey\n', '2018-05-15 20:58:17', '2018-05-15 22:58:17'),
(164, NULL, NULL, NULL, '43', 'Hey', '2018-05-15 21:00:15', '2018-05-15 23:00:15'),
(165, NULL, NULL, NULL, '43', 'dz', '2018-05-15 21:02:48', '2018-05-15 23:02:48'),
(166, NULL, NULL, NULL, '43', 'line', '2018-05-15 21:04:00', '2018-05-15 23:04:00'),
(167, NULL, NULL, NULL, '43', 'dzdzd', '2018-05-15 21:05:24', '2018-05-15 23:05:24'),
(168, NULL, NULL, NULL, '43', 'dzdzdz', '2018-05-15 21:06:05', '2018-05-15 23:06:04'),
(169, NULL, NULL, NULL, '43', 'ppppppppp', '2018-05-15 21:06:33', '2018-05-15 23:06:33'),
(170, NULL, NULL, NULL, '43', 'dzdz', '2018-05-15 21:07:31', '2018-05-15 23:07:31'),
(171, NULL, NULL, NULL, '43', 'a', '2018-05-15 21:08:02', '2018-05-15 23:08:01'),
(172, NULL, NULL, NULL, '43', 'z', '2018-05-15 21:09:03', '2018-05-15 23:09:03'),
(173, NULL, NULL, NULL, '43', 'e', '2018-05-15 21:09:55', '2018-05-15 23:09:55'),
(174, NULL, NULL, NULL, '43', 'r', '2018-05-15 21:11:14', '2018-05-15 23:11:13'),
(175, NULL, NULL, NULL, '43', 't', '2018-05-15 21:12:04', '2018-05-15 23:12:03'),
(176, NULL, NULL, NULL, '43', 'y', '2018-05-15 21:12:39', '2018-05-15 23:12:38'),
(177, NULL, NULL, NULL, '43', 'u', '2018-05-15 21:12:56', '2018-05-15 23:12:56'),
(178, NULL, NULL, NULL, '43', 'i', '2018-05-15 21:14:09', '2018-05-15 23:14:08'),
(179, NULL, NULL, NULL, '43', 'dz', '2018-05-15 21:14:58', '2018-05-15 23:14:58'),
(180, NULL, NULL, NULL, '43', 'dz', '2018-05-15 21:15:46', '2018-05-15 23:15:45'),
(181, NULL, NULL, NULL, '43', 'dzdzdzdz', '2018-05-15 21:15:54', '2018-05-15 23:15:53'),
(182, NULL, NULL, NULL, '43', 'WHatr\'atvydz&ugrave;d*', '2018-05-15 21:19:59', '2018-05-15 23:19:59'),
(183, NULL, NULL, NULL, '43', 'WHatr\'atvydz&ugrave;d*', '2018-05-15 21:20:00', '2018-05-15 23:20:00'),
(184, NULL, NULL, NULL, '43', '&egrave;&egrave;', '2018-05-15 21:21:09', '2018-05-15 23:21:08'),
(185, NULL, NULL, NULL, '43', 'dzdz', '2018-05-15 21:21:40', '2018-05-15 23:21:40'),
(186, NULL, NULL, NULL, '43', 'pppp', '2018-05-15 21:22:30', '2018-05-15 23:22:30'),
(187, NULL, NULL, NULL, '43', 'jj', '2018-05-15 21:23:04', '2018-05-15 23:23:03'),
(188, NULL, NULL, NULL, '43', 'ooo', '2018-05-15 21:23:55', '2018-05-15 23:23:55'),
(189, NULL, NULL, NULL, '43', 'dz', '2018-05-15 21:25:07', '2018-05-15 23:25:07'),
(190, NULL, NULL, NULL, '43', 'dzdzdz', '2018-05-15 21:25:13', '2018-05-15 23:25:12'),
(191, 1, 43, NULL, '43', 'WHatr\'atvydz&ugrave;d*', '2018-05-15 21:19:59', '2018-05-15 23:25:30'),
(192, NULL, NULL, NULL, '43', 'Hey what\'s up guys \n', '2018-05-15 21:29:51', '2018-05-15 23:29:51'),
(193, 1, 43, NULL, '43', 'Hey what\'s up guys \n', '2018-05-15 21:29:51', '2018-05-15 23:30:03'),
(194, NULL, NULL, NULL, '43', 'dzdzdzdzdz', '2018-05-15 21:40:58', '2018-05-15 23:40:58'),
(235, NULL, NULL, NULL, '1', 'ahhhh', '2018-05-16 20:33:59', '2018-05-16 20:33:59'),
(236, NULL, NULL, NULL, '1', 'bbbbbb', '2018-05-16 20:39:05', '2018-05-16 20:39:05'),
(226, NULL, NULL, NULL, '47', 'what\'up\n', '2018-05-16 12:39:43', '2018-05-16 14:39:41'),
(228, NULL, NULL, NULL, '47', 'zdzdzd', '2018-05-16 13:04:19', '2018-05-16 15:04:18'),
(229, NULL, NULL, NULL, '1', 'On va test la nouvelle version', '2018-05-16 15:09:20', '2018-05-16 15:09:20'),
(230, NULL, NULL, NULL, '48', 'muh dick', '2018-05-16 17:34:53', '2018-05-16 17:34:53'),
(231, NULL, NULL, NULL, '48', '&lt;hr&gt;', '2018-05-16 17:40:15', '2018-05-16 17:40:15'),
(232, NULL, NULL, NULL, '48', 'aaaa', '2018-05-16 17:40:26', '2018-05-16 17:40:26'),
(233, NULL, NULL, NULL, '57', 'What\'s up boyys', '2018-05-16 20:29:00', '2018-05-16 20:29:00'),
(238, NULL, NULL, NULL, '1', 'vvvvv', '2018-05-16 20:44:18', '2018-05-16 20:44:18'),
(240, NULL, NULL, NULL, '1', 'azeazeazeaze', '2018-05-16 20:51:23', '2018-05-16 20:51:23'),
(241, NULL, NULL, NULL, '1', 'gzeagazeraz', '2018-05-16 21:06:21', '2018-05-16 21:06:21');

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `last_login` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `pp_url` varchar(255) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Contenu de la table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `last_login`, `pp_url`) VALUES
(1, 'neilrichter', 'me@neilrichter.com', '$2y$10$HO4udjih73QNgiVmyfUIJe1CRQTvuOy/soVggyvKyoV/mRXsKbUjy', '2018-05-16 19:22:50', '/assets/pp/PP-Pro.jpg'),
(2, 'test', 'aaa@aaaa.fr', '$2y$10$tDR6nlAg0pjPw7QsFp1GUuHZAwNx4pn3br4v41WhavIh0FwI7KoHu', '2018-05-08 22:03:17', NULL),
(3, 'Louis', 'loiseaubillon@gmail.com', '$2y$10$kFi4hOlekcvhIP2nN7bDcOYm71og.zDT6nocFKgdra6N6Li59uWZW', '2018-05-11 09:59:37', '/assets/pp/r6-operator-buck_237593.png'),
(4, 'Krozakof', 'blabla@yopmail.fr', '$2y$10$SqvwW1IKtHEWk0z4RE0CX.Namv2mvp1HRP5UNrHgP.FmsMzr2B1Ta', '2018-05-09 12:30:54', '/assets/pp/4_pp.jpeg'),
(5, 'ivandeschaussettes', 'ivan.milosevic@supinternet.fr', '$2y$10$vjkqPyiF8NutimcYibRcReAUH/Wdf0HKPnHso557nvcIEs/6cpNue', '2018-05-09 15:57:22', NULL),
(6, 'Something', 'zya.nassuraly@gmail.com', '$2y$10$vQbpPDo6EVtte2SfZt42mO3GYWsDbQy4EfKuS1WaLIac5FXPapGS6', '2018-05-09 17:21:21', NULL),
(7, 'azeazeaze', 'azeazeaze@azeaze.aze', '$2y$10$27CVWY.dEFNvUbJbFvShyO4xn81fK79jRMsfF9dbzcOGmE1Jbl5CC', '2018-05-10 16:45:50', NULL),
(8, 'Papaya', 'sunny@papaya.toogood', '$2y$10$rrGyi/0jRrL1yR5tUxqnuepZx6WoBwP2jujxTH9r94tjnA/4Wpcfi', '2018-05-10 19:30:38', NULL),
(9, 'Zya', 'zya@zya.zya', '$2y$10$QbCd8mJCu.LQEG1GWEsJ9ezQn3cQ5IN2ty5kHiX3.AHHf9jiSoSLK', '2018-05-11 10:27:16', NULL),
(10, 'Ivan', 'ivan.truc@gmail.com', '$2y$10$kWmw/5HnNoWDMEllhn2XYOld9UImIgMoqziu04ikwfJP8w.RG/aQq', '2018-05-11 13:17:57', NULL),
(11, 'Cccccccc', 'morgane.bourcois@gmail.com', '$2y$10$I6G1WN8dLcFJVqk8B5EOze0/f3Qk51u55PNtzOffTjIj/wj40vGKO', '2018-05-11 14:31:42', NULL),
(36, 'azerty', 'azerty@gmail.com', '$2y$10$KCOa8isUGo99kK4z6VQwp.dOV1bjJdZ7LyzKxTctcGSGPr1/BH0HG', '2018-05-12 15:13:10', NULL),
(41, 'ddzdzdz', 'd@do.dd', '$2y$10$TiEJzRHFhmXjpZA4Rdw3xeYaLcMAD1GwsLo14bo2nPxTZoTwVOvt.', '2018-05-13 17:03:52', NULL),
(35, 'yuyuyu', 'yu@yu.fr', '$2y$10$NyM1hblukymSH2UjM10pguTJ6c6P/592SmG1C484/ASHl/vNlVm7K', '2018-05-12 14:29:40', NULL),
(25, 'Wood', 'wasb95@hotmail.fr', '$2y$10$VfCGiW0X2Mmrgw42Um0e..tYjbqcM6ILlpJgRZTYPSUry56gPjheC', '2018-05-12 12:44:56', NULL),
(43, 'line', 'line@line.fr', '$2y$10$ZMIfYlCvM9u4HMWyU8wdOuClUHBkV1LDvHf8tnv/oeTsyn/r8bhea', '2018-05-16 16:30:31', '/assets/pp/discor.png'),
(48, '3-25', 'tusaispascoder@xnuance.fr', '$2y$10$6inxHRBU7BrMYN1APeX7aeGqEuw.1aH08aZvCZPCqA5RZYnCU9ASG', '2018-05-16 15:34:13', NULL),
(47, 'zya', 'zya1999@hotmail.fr', '$2y$10$.VgZsbvQ6esW0RcrFSdJDeaAXJNw.pvVcMkGt3lW3a9CcV2/4MbeO', '2018-05-16 10:34:19', NULL),
(49, 'Testtest', 'test@test.frf', '$2y$10$5QBPiTOq6cYPl6yJyG8eKu04vqFtJeKAMmd0kP.lwF7khD7Z6Xd3i', '2018-05-16 16:33:57', NULL),
(50, '', '', '$2y$10$TcrAmoaNoX8vOT7GDp23TeQQtVJV7zZa2B/gCjtuf8DGPuLPr/3qG', '2018-05-16 18:09:19', NULL),
(51, 'azeaze', 'azeazea@ne', '$2y$10$sCdu1vrbcVnpFaakU1hQHuoUx7EEfV8BoXUl00T0UjVNkFSOcLdH6', '2018-05-16 17:42:48', NULL),
(52, 'azeaz', 'azeazeaze@azeaze.azeae', '$2y$10$/1IOnGmk.2Ke2SsSrFOW9.ArOdCGgqC98UWoDCpIWOxnoamlCZWqm', '2018-05-16 17:50:40', NULL),
(53, 'aze', 'me@neilrichter.comm', '$2y$10$wNeERwwaW9XRks.nSWxvr.osOg16V1t51le4YldMu2UvsOkt9smwy', '2018-05-16 17:58:33', NULL),
(54, 'azea', 'azeazeaze@azeaze.aaze', '$2y$10$NMCwIC.J4xY.SRU8JezkDeCVFYEIHJKqgvWZMnsXVv13pDSdGJy3G', '2018-05-16 18:00:25', NULL),
(55, 'azeaaa', 'azeazeaze@azeaze.azea', '$2y$10$MzfgWk5hUyXt8NcGz4PoleIw/wpOOWnHa35GdhOItGng/Zo8OcDIa', '2018-05-16 18:06:44', NULL),
(56, 'azeazeazeaze', 'azeazeaaaze@azeaze.aze', '$2y$10$e9hz/jKKAr6EpHC.uIzaVu4LPCrCnguHT.kPHLAp2H0Y4SXexnuXa', '2018-05-16 18:08:21', NULL),
(57, 'Mohammed Ali', 'mohammedali@gmail.com', '$2y$10$gNB6v8VyUBxfIImlPjXY0.NEQBdLdasA4rrNC6ba9rl6Fm2/Z3bAq', '2018-05-16 18:28:47', NULL);

--
-- Index pour les tables exportées
--

--
-- Index pour la table `favs`
--
ALTER TABLE `favs`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `follows`
--
ALTER TABLE `follows`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `rtwtt`
--
ALTER TABLE `rtwtt`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `twtts`
--
ALTER TABLE `twtts`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT pour les tables exportées
--

--
-- AUTO_INCREMENT pour la table `favs`
--
ALTER TABLE `favs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;
--
-- AUTO_INCREMENT pour la table `follows`
--
ALTER TABLE `follows`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;
--
-- AUTO_INCREMENT pour la table `rtwtt`
--
ALTER TABLE `rtwtt`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=105;
--
-- AUTO_INCREMENT pour la table `twtts`
--
ALTER TABLE `twtts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=245;
--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
