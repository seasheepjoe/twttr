-- phpMyAdmin SQL Dump
-- version 4.7.7
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost:3306
-- Généré le :  mer. 02 mai 2018 à 17:30
-- Version du serveur :  5.6.38
-- Version de PHP :  7.2.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Base de données :  `twttr`
--

-- --------------------------------------------------------

--
-- Structure de la table `twtts`
--

CREATE TABLE `twtts` (
  `id` int(11) NOT NULL,
  `rt` tinyint(1) NOT NULL,
  `author` varchar(255) NOT NULL,
  `content` varchar(255) NOT NULL,
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `twtts`
--

INSERT INTO `twtts` (`id`, `rt`, `author`, `content`, `date`) VALUES
(11, 0, '35', 'Oh ! And this is my second !\r\n\r\nI returned to the line twice !', '2018-04-15 22:09:39'),
(10, 0, '35', 'Hey there, this is my first twtt', '2018-04-15 22:08:51');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `twtts`
--
ALTER TABLE `twtts`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `twtts`
--
ALTER TABLE `twtts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;
