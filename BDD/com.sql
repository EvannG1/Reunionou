-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Hôte : db
-- Généré le : mar. 23 mars 2021 à 15:56
-- Version du serveur :  10.5.9-MariaDB-1:10.5.9+maria~focal
-- Version de PHP : 7.4.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `com`
--

-- --------------------------------------------------------

--
-- Structure de la table `comments`
--

CREATE TABLE `comments` (
  `id` int(11) NOT NULL,
  `content` text NOT NULL,
  `user_id` int(11) NOT NULL,
  `event_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `comments`
--

INSERT INTO `comments` (`id`, `content`, `user_id`, `event_id`) VALUES
(1, 'Cela va être super bien ! :)', 1, 1),
(2, 'Cela va être super naze ! :(', 2, 2),
(3, 'On verra bien !', 1, 1);

-- --------------------------------------------------------

--
-- Structure de la table `events`
--

CREATE TABLE `events` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `date` datetime NOT NULL,
  `location_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `token` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `events`
--

INSERT INTO `events` (`id`, `title`, `description`, `date`, `location_id`, `user_id`, `token`) VALUES
(1, 'Anniversaire de tata', 'Superbe anniversaire de tata !', '2021-03-24 15:00:00', 1, 1, 'sss'),
(2, 'Anniversaire de tonton', 'Superbe anniversaire de tonton !', '2021-03-24 15:00:00', 2, 3, 'sss'),
(3, 'Anniversaire de mamy', 'Superbe anniversaire de mamy !', '2021-03-24 15:00:00', 2, 3, 'sss');

-- --------------------------------------------------------

--
-- Structure de la table `locations`
--

CREATE TABLE `locations` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `x` float NOT NULL,
  `y` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `locations`
--

INSERT INTO `locations` (`id`, `name`, `x`, `y`) VALUES
(1, 'Tour Eiffel', 48.8584, 2.29229),
(2, 'Pas la Tour Eiffel', 48.8584, 2.29229);

-- --------------------------------------------------------

--
-- Structure de la table `shared_events`
--

CREATE TABLE `shared_events` (
  `id` int(11) NOT NULL,
  `event_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `shared_events`
--

INSERT INTO `shared_events` (`id`, `event_id`, `user_id`) VALUES
(1, 2, 1),
(2, 1, 3),
(3, 2, 3),
(4, 1, 2),
(5, 3, 2);

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `fullname` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `token` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `fullname`, `email`, `password`, `token`) VALUES
(1, 'John Doe', 'john@local.dev', '$2y$10$7AmFGwyDNlTxcu4B5ezbwecw.yarZWxdAGZL6QvbYE2O5ZINudBh2', '1afc5824fa4a325d394d1425ecce0578'),
(2, 'Mr. Propre', 'propre@local.dev', '$2y$10$7AmFGwyDNlTxcu4B5ezbwecw.yarZWxdAGZL6QvbYE2O5ZINudBh2', 'c903a1e7cf45e4f39de69d5f1b66b575'),
(3, 'Cetelem', 'cetelem@local.dev', '$2y$10$7AmFGwyDNlTxcu4B5ezbwecw.yarZWxdAGZL6QvbYE2O5ZINudBh2', '822de381ffd398a9485f997931b67fa9');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `locations`
--
ALTER TABLE `locations`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `shared_events`
--
ALTER TABLE `shared_events`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `comments`
--
ALTER TABLE `comments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `events`
--
ALTER TABLE `events`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `locations`
--
ALTER TABLE `locations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `shared_events`
--
ALTER TABLE `shared_events`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
