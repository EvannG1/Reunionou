-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost
-- Généré le : mar. 23 mars 2021 à 12:34
-- Version du serveur :  10.4.18-MariaDB
-- Version de PHP : 7.4.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `reunionou`
--

-- --------------------------------------------------------

--
-- Structure de la table `comments`
--

CREATE TABLE `comments` (
  `events_id` int(127) NOT NULL,
  `users_id` int(127) NOT NULL,
  `texte` text NOT NULL,
  `id_comments` int(127) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `comments`
--

INSERT INTO `comments` (`events_id`, `users_id`, `texte`, `id_comments`) VALUES
(2, 2, 'Putain je me souviens de rien, vous vous souvenez de quelque chose vous ?', 1),
(2, 3, 'Ouais t\'as montré ton cul à ma daronne mec..', 2),
(2, 5, 'Et t\'as vomi dans la piscine aussi avant de mettre ses poissons dedans pour qu\'ils \"nettoient\" mdr', 3),
(2, 1, 'On en parle de Vivien déchiré sur le canapé ? xd', 4),
(2, 4, 'Qu\'est ce que tu racontes gros, j\'étais juste bien t\'as capté', 5);

-- --------------------------------------------------------

--
-- Structure de la table `events`
--

CREATE TABLE `events` (
  `id_events` int(127) NOT NULL,
  `titre` varchar(127) NOT NULL,
  `date` date NOT NULL,
  `heure` time NOT NULL,
  `location_id` int(127) NOT NULL,
  `description` text NOT NULL,
  `token` text NOT NULL,
  `id_u` int(127) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `events`
--

INSERT INTO `events` (`id_events`, `titre`, `date`, `heure`, `location_id`, `description`, `token`, `id_u`) VALUES
(1, 'Anniversaire de mamie', '2021-03-23', '16:00:00', 1, 'On lui fait la surprise, venez déguisés, vous savez qu\'elle adore ça ! Bisous', '5aa713e41ecf71cb75a15d614fdb9d', 1),
(2, 'Grosse mine', '2021-04-01', '00:00:01', 2, 'On se met une grosse mine pour fêter.. ha bah non y a rien à fêter, blc on va boire quand même !', '6b1d01a215900c43c4fd0bd381c091', 3),
(3, 'Noël', '2021-12-24', '20:30:00', 3, 'Pour cette année, c\'est chez moi ! Je prépare tout ne vous inquiétez, venez simplement avec les enfants et n\'oubliez pas les cadeaux :p OhOhOh !', '68942c0cc3a9d946e0e40e3c76a469', 2),
(4, 'Enterrement de Pikachu', '2021-06-10', '09:00:00', 4, 'Comme vous le savez, mon hamster est mort il y a deux jours... Rendez-vous au Louvre pour la marche funèbre, merci à vous pour votre soutien.', '6e81fb9d31b4b90170016ba28b435c', 5);

-- --------------------------------------------------------

--
-- Structure de la table `guests`
--

CREATE TABLE `guests` (
  `e_id` int(127) NOT NULL,
  `u_id` int(127) NOT NULL,
  `status_id` int(127) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `guests`
--

INSERT INTO `guests` (`e_id`, `u_id`, `status_id`) VALUES
(2, 1, 1),
(2, 2, 1),
(2, 4, 1),
(2, 5, 1),
(3, 1, 1),
(3, 4, 1),
(4, 2, 1),
(3, 5, 2),
(1, 2, 3),
(1, 3, 3),
(4, 1, 3),
(4, 3, 3),
(4, 4, 3);

-- --------------------------------------------------------

--
-- Structure de la table `location`
--

CREATE TABLE `location` (
  `id_location` int(127) NOT NULL,
  `adresse` text NOT NULL,
  `code` int(5) NOT NULL,
  `ville` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `location`
--

INSERT INTO `location` (`id_location`, `adresse`, `code`, `ville`) VALUES
(1, 'Tour Eiffel, Champ de Mars, 5 Avenue Anatole France', 75007, 'Paris'),
(2, 'Arc de Triomphe, Place Charles de Gaulle', 75008, 'Paris'),
(3, 'Musée du Louvre, Rue de Rivoli', 75001, 'Paris'),
(4, 'Place de la Concorde', 75008, 'Paris');

-- --------------------------------------------------------

--
-- Structure de la table `status`
--

CREATE TABLE `status` (
  `id_status` int(127) NOT NULL,
  `libelle` varchar(127) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `status`
--

INSERT INTO `status` (`id_status`, `libelle`) VALUES
(1, 'disponible'),
(2, 'pas disponible'),
(3, 'a pas encore répondu');

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `id_users` int(127) NOT NULL,
  `mail` text NOT NULL,
  `password` text NOT NULL,
  `nom` varchar(127) NOT NULL,
  `prenom` varchar(127) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id_users`, `mail`, `password`, `nom`, `prenom`) VALUES
(1, 'ludovic.c30@outlook.com', 'p@ssw0rd', 'Caron', 'Ludovic'),
(2, 'portaro.lucas@gmail.com', 'p@ssw0rd', 'Portaro', 'Lucas'),
(3, 'evann@outlook.com', 'p@ssw0rd', 'Gehin', 'Evann'),
(4, 'viven@outlook.com', 'p@ssw0rd', 'Klopfenstein', 'Evan'),
(5, 'ozan@outlook.com', 'p@ssw0rd', 'Ozkok', 'Evan');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id_comments`),
  ADD KEY `FK_users` (`users_id`),
  ADD KEY `FK_events` (`events_id`);

--
-- Index pour la table `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`id_events`),
  ADD KEY `FK_location` (`location_id`),
  ADD KEY `u_FK` (`id_u`);

--
-- Index pour la table `guests`
--
ALTER TABLE `guests`
  ADD PRIMARY KEY (`e_id`,`u_id`),
  ADD KEY `FK_u` (`u_id`),
  ADD KEY `FK_e` (`e_id`),
  ADD KEY `FK_status` (`status_id`);

--
-- Index pour la table `location`
--
ALTER TABLE `location`
  ADD PRIMARY KEY (`id_location`);

--
-- Index pour la table `status`
--
ALTER TABLE `status`
  ADD PRIMARY KEY (`id_status`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id_users`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `comments`
--
ALTER TABLE `comments`
  MODIFY `id_comments` int(127) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT pour la table `events`
--
ALTER TABLE `events`
  MODIFY `id_events` int(127) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `location`
--
ALTER TABLE `location`
  MODIFY `id_location` int(127) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `status`
--
ALTER TABLE `status`
  MODIFY `id_status` int(127) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
  
--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `id_users` int(127) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `FK_events` FOREIGN KEY (`events_id`) REFERENCES `events` (`id_events`),
  ADD CONSTRAINT `FK_users` FOREIGN KEY (`users_id`) REFERENCES `users` (`id_users`);

--
-- Contraintes pour la table `events`
--
ALTER TABLE `events`
  ADD CONSTRAINT `FK_location` FOREIGN KEY (`location_id`) REFERENCES `location` (`id_location`),
  ADD CONSTRAINT `u_FK` FOREIGN KEY (`id_u`) REFERENCES `users` (`id_users`);

--
-- Contraintes pour la table `guests`
--
ALTER TABLE `guests`
  ADD CONSTRAINT `FK_e` FOREIGN KEY (`e_id`) REFERENCES `events` (`id_events`),
  ADD CONSTRAINT `FK_status` FOREIGN KEY (`status_id`) REFERENCES `status` (`id_status`),
  ADD CONSTRAINT `FK_u` FOREIGN KEY (`u_id`) REFERENCES `users` (`id_users`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
