-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 29. Okt 2020 um 16:09
-- Server-Version: 10.4.13-MariaDB
-- PHP-Version: 7.4.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `leichtathletik`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `athlet`
--

CREATE TABLE `athlet` (
  `athlet_id` int(11) NOT NULL,
  `athlet_name` varchar(30) NOT NULL,
  `birthdate` date DEFAULT '1990-01-01' COMMENT 'This is the date where the athlet is born' CHECK (`birthdate` <= '2004-01-01'),
  `nationality` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `athlet`
--

INSERT INTO `athlet` (`athlet_id`, `athlet_name`, `birthdate`, `nationality`) VALUES
(1, 'Hans', '2003-01-01', NULL),
(5, 'Sabine Ebner', '2000-07-08', 'AT');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `event`
--

CREATE TABLE `event` (
  `id` int(11) NOT NULL,
  `event_time` time NOT NULL,
  `discipline` text NOT NULL,
  `helper_id` int(11) DEFAULT NULL,
  `result_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `event`
--

INSERT INTO `event` (`id`, `event_time`, `discipline`, `helper_id`, `result_id`) VALUES
(200, '12:40:00', '400m', NULL, NULL),
(201, '13:40:00', '800m', NULL, NULL);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `helper`
--

CREATE TABLE `helper` (
  `id` int(11) NOT NULL,
  `helper_name` varchar(20) NOT NULL,
  `function` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `helper`
--

INSERT INTO `helper` (`id`, `helper_name`, `function`) VALUES
(1, 'Albert Pichler', 'Waterboy'),
(2, 'Celine Dior', 'Foodtruck');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `result`
--

CREATE TABLE `result` (
  `result_id` int(11) NOT NULL,
  `result` int(11) DEFAULT 100,
  `achievedby` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `result`
--

INSERT INTO `result` (`result_id`, `result`, `achievedby`) VALUES
(50, 45, NULL),
(51, 43, NULL);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `venue`
--

CREATE TABLE `venue` (
  `id` int(11) NOT NULL,
  `city` varchar(20) DEFAULT NULL,
  `adress` varchar(40) DEFAULT NULL,
  `event_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `venue`
--

INSERT INTO `venue` (`id`, `city`, `adress`, `event_id`) VALUES
(100, 'Linz', 'Hauptplatz 4', NULL),
(101, 'Graz', 'Schwanenstraße 5', NULL);

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `athlet`
--
ALTER TABLE `athlet`
  ADD PRIMARY KEY (`athlet_id`);

--
-- Indizes für die Tabelle `event`
--
ALTER TABLE `event`
  ADD PRIMARY KEY (`id`),
  ADD KEY `event_helper_id_fk` (`helper_id`),
  ADD KEY `event_result_result_id_fk` (`result_id`);

--
-- Indizes für die Tabelle `helper`
--
ALTER TABLE `helper`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `result`
--
ALTER TABLE `result`
  ADD PRIMARY KEY (`result_id`),
  ADD KEY `result_athlet_athlet_id_fk` (`achievedby`);

--
-- Indizes für die Tabelle `venue`
--
ALTER TABLE `venue`
  ADD PRIMARY KEY (`id`),
  ADD KEY `venue_event_id_fk` (`event_id`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `athlet`
--
ALTER TABLE `athlet`
  MODIFY `athlet_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT für Tabelle `event`
--
ALTER TABLE `event`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=202;

--
-- AUTO_INCREMENT für Tabelle `helper`
--
ALTER TABLE `helper`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT für Tabelle `result`
--
ALTER TABLE `result`
  MODIFY `result_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT für Tabelle `venue`
--
ALTER TABLE `venue`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=102;

--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle `event`
--
ALTER TABLE `event`
  ADD CONSTRAINT `event_helper_id_fk` FOREIGN KEY (`helper_id`) REFERENCES `helper` (`id`),
  ADD CONSTRAINT `event_result_result_id_fk` FOREIGN KEY (`result_id`) REFERENCES `result` (`result_id`) ON UPDATE CASCADE;

--
-- Constraints der Tabelle `result`
--
ALTER TABLE `result`
  ADD CONSTRAINT `result_athlet_athlet_id_fk` FOREIGN KEY (`achievedby`) REFERENCES `athlet` (`athlet_id`);

--
-- Constraints der Tabelle `venue`
--
ALTER TABLE `venue`
  ADD CONSTRAINT `venue_event_id_fk` FOREIGN KEY (`event_id`) REFERENCES `event` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
