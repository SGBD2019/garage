-- phpMyAdmin SQL Dump
-- version 4.8.4
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le :  mer. 27 mars 2019 à 18:44
-- Version du serveur :  5.7.24
-- Version de PHP :  7.2.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `sgbd_garage`
--

-- --------------------------------------------------------

--
-- Structure de la table `depot_vente`
--

DROP TABLE IF EXISTS `depot_vente`;
CREATE TABLE IF NOT EXISTS `depot_vente` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `km` int(11) DEFAULT NULL,
  `remarques` text,
  `garantie` varchar(255) DEFAULT NULL,
  `FK_acheteur` int(11) DEFAULT NULL,
  `FK_vendeur` int(11) DEFAULT NULL,
  `date_depot` date DEFAULT NULL,
  `date_sortie` date DEFAULT NULL,
  `prix_demande` float DEFAULT NULL,
  `commission` float DEFAULT NULL,
  `prix_vente` float DEFAULT NULL,
  `FK_vehicule` int(11) DEFAULT NULL,
  `etat_vehicule` int(11) DEFAULT NULL,
  `nbre_proprio` int(11) DEFAULT NULL,
  `carpass` int(11) DEFAULT NULL,
  `controle_technique` tinyint(1) DEFAULT NULL,
  `image` text,
  PRIMARY KEY (`id`),
  KEY `FK_acheteur` (`FK_acheteur`),
  KEY `FK_vendeur` (`FK_vendeur`),
  KEY `FK_vehicule` (`FK_vehicule`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `marque`
--

DROP TABLE IF EXISTS `marque`;
CREATE TABLE IF NOT EXISTS `marque` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `modele`
--

DROP TABLE IF EXISTS `modele`;
CREATE TABLE IF NOT EXISTS `modele` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `FK_marque` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_model` (`FK_marque`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `personne`
--

DROP TABLE IF EXISTS `personne`;
CREATE TABLE IF NOT EXISTS `personne` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(255) DEFAULT NULL,
  `prenom` varchar(255) DEFAULT NULL,
  `telephone` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `adresse` varchar(255) DEFAULT NULL,
  `code_postal` varchar(255) DEFAULT NULL,
  `date_naissance` date DEFAULT NULL,
  `remarques` text,
  `password` varchar(255) DEFAULT NULL,
  `salt` varchar(255) DEFAULT NULL,
  `login` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `login` (`login`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Structure de la table `vehicule`
--

DROP TABLE IF EXISTS `vehicule`;
CREATE TABLE IF NOT EXISTS `vehicule` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cylindree` int(11) DEFAULT NULL,
  `annee` int(11) DEFAULT NULL,
  `numero_chassis` varchar(255) DEFAULT NULL,
  `remarques` text,
  `carburant` varchar(255) DEFAULT NULL,
  `type_chassis` varchar(255) DEFAULT NULL,
  `premiere_immatriculation` date DEFAULT NULL,
  `boite` varchar(255) DEFAULT NULL,
  `nbre_portes` int(11) DEFAULT NULL,
  `nbre_sieges` int(11) DEFAULT NULL,
  `couleur` varchar(255) DEFAULT NULL,
  `puissance` int(11) DEFAULT NULL,
  `emission_co2` varchar(255) DEFAULT NULL,
  `FK_modele` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_modele` (`FK_modele`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `depot_vente`
--
ALTER TABLE `depot_vente`
  ADD CONSTRAINT `depot_vente_ibfk_1` FOREIGN KEY (`FK_acheteur`) REFERENCES `personne` (`id`),
  ADD CONSTRAINT `depot_vente_ibfk_2` FOREIGN KEY (`FK_vehicule`) REFERENCES `vehicule` (`id`),
  ADD CONSTRAINT `depot_vente_ibfk_3` FOREIGN KEY (`FK_vendeur`) REFERENCES `personne` (`id`);

--
-- Contraintes pour la table `modele`
--
ALTER TABLE `modele`
  ADD CONSTRAINT `modele_ibfk_1` FOREIGN KEY (`FK_marque`) REFERENCES `marque` (`id`);

--
-- Contraintes pour la table `vehicule`
--
ALTER TABLE `vehicule`
  ADD CONSTRAINT `vehicule_ibfk_1` FOREIGN KEY (`FK_modele`) REFERENCES `modele` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
