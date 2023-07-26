-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 26. Jul 2023 um 19:15
-- Server-Version: 10.4.21-MariaDB
-- PHP-Version: 8.0.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `db_lap_qrcode`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tbl_geschlechter`
--

CREATE TABLE `tbl_geschlechter` (
  `IDGeschlecht` int(10) UNSIGNED NOT NULL,
  `Geschlecht` varchar(16) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `tbl_geschlechter`
--

INSERT INTO `tbl_geschlechter` (`IDGeschlecht`, `Geschlecht`) VALUES
(3, 'divers'),
(2, 'männlich'),
(1, 'weiblich');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `tbl_user`
--

CREATE TABLE `tbl_user` (
  `IDUser` int(10) UNSIGNED NOT NULL,
  `Vorname` varchar(32) NOT NULL,
  `Nachname` varchar(32) NOT NULL,
  `SVNr` bigint(10) UNSIGNED ZEROFILL NOT NULL,
  `FIDGeschlecht` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `tbl_user`
--

INSERT INTO `tbl_user` (`IDUser`, `Vorname`, `Nachname`, `SVNr`, `FIDGeschlecht`) VALUES
(3, 'Uwe', 'Mutz', 3013171072, 2);

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `tbl_geschlechter`
--
ALTER TABLE `tbl_geschlechter`
  ADD PRIMARY KEY (`IDGeschlecht`),
  ADD UNIQUE KEY `Geschlecht` (`Geschlecht`);

--
-- Indizes für die Tabelle `tbl_user`
--
ALTER TABLE `tbl_user`
  ADD PRIMARY KEY (`IDUser`),
  ADD UNIQUE KEY `SVNr` (`SVNr`),
  ADD KEY `FIDGeschlecht` (`FIDGeschlecht`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `tbl_geschlechter`
--
ALTER TABLE `tbl_geschlechter`
  MODIFY `IDGeschlecht` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT für Tabelle `tbl_user`
--
ALTER TABLE `tbl_user`
  MODIFY `IDUser` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle `tbl_user`
--
ALTER TABLE `tbl_user`
  ADD CONSTRAINT `tbl_user_ibfk_1` FOREIGN KEY (`FIDGeschlecht`) REFERENCES `tbl_geschlechter` (`IDGeschlecht`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
