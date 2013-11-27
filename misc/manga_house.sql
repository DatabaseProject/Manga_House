-- MySQL dump 10.13  Distrib 5.5.32, for debian-linux-gnu (i686)
--
-- Host: localhost    Database: mydb
-- ------------------------------------------------------
-- Server version	5.5.32-0ubuntu0.12.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Artist`
--

DROP TABLE IF EXISTS `Artist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Artist` (
  `artist_id` int(11) NOT NULL AUTO_INCREMENT,
  `People_people_id` int(11) NOT NULL,
  PRIMARY KEY (`artist_id`,`People_people_id`),
  KEY `fk_Artist_People1_idx` (`People_people_id`),
  CONSTRAINT `fk_Artist_People1` FOREIGN KEY (`People_people_id`) REFERENCES `People` (`people_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Artist`
--

LOCK TABLES `Artist` WRITE;
/*!40000 ALTER TABLE `Artist` DISABLE KEYS */;
/*!40000 ALTER TABLE `Artist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Author`
--

DROP TABLE IF EXISTS `Author`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Author` (
  `author_id` int(11) NOT NULL AUTO_INCREMENT,
  `People_people_id` int(11) NOT NULL,
  PRIMARY KEY (`author_id`,`People_people_id`),
  KEY `fk_Author_People1_idx` (`People_people_id`),
  CONSTRAINT `fk_Author_People1` FOREIGN KEY (`People_people_id`) REFERENCES `People` (`people_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Author`
--

LOCK TABLES `Author` WRITE;
/*!40000 ALTER TABLE `Author` DISABLE KEYS */;
/*!40000 ALTER TABLE `Author` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Chapter`
--

DROP TABLE IF EXISTS `Chapter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Chapter` (
  `chapter_id` int(11) NOT NULL AUTO_INCREMENT,
  `number` int(11) DEFAULT NULL,
  `volumn` int(11) DEFAULT NULL,
  `Manga_manga_id` int(11) NOT NULL,
  `Release_release_id` int(11) NOT NULL,
  PRIMARY KEY (`chapter_id`,`Manga_manga_id`,`Release_release_id`),
  KEY `fk_Chapter_Manga1_idx` (`Manga_manga_id`),
  KEY `fk_Chapter_Release1_idx` (`Release_release_id`),
  CONSTRAINT `fk_Chapter_Manga1` FOREIGN KEY (`Manga_manga_id`) REFERENCES `Manga` (`manga_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Chapter_Release1` FOREIGN KEY (`Release_release_id`) REFERENCES `Release` (`release_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Chapter`
--

LOCK TABLES `Chapter` WRITE;
/*!40000 ALTER TABLE `Chapter` DISABLE KEYS */;
/*!40000 ALTER TABLE `Chapter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Favourite_Artist`
--

DROP TABLE IF EXISTS `Favourite_Artist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Favourite_Artist` (
  `User_user_id` int(11) NOT NULL,
  `Artist_artist_id` int(11) NOT NULL,
  PRIMARY KEY (`User_user_id`,`Artist_artist_id`),
  KEY `fk_Favourite_Artist_Artist1_idx` (`Artist_artist_id`),
  CONSTRAINT `fk_Favourite_Artist_User1` FOREIGN KEY (`User_user_id`) REFERENCES `User` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Favourite_Artist_Artist1` FOREIGN KEY (`Artist_artist_id`) REFERENCES `Artist` (`artist_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Favourite_Artist`
--

LOCK TABLES `Favourite_Artist` WRITE;
/*!40000 ALTER TABLE `Favourite_Artist` DISABLE KEYS */;
/*!40000 ALTER TABLE `Favourite_Artist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Favourite_Author`
--

DROP TABLE IF EXISTS `Favourite_Author`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Favourite_Author` (
  `User_user_id` int(11) NOT NULL,
  `Author_author_id` int(11) NOT NULL,
  PRIMARY KEY (`User_user_id`,`Author_author_id`),
  KEY `fk_Favourite_Author_Author1_idx` (`Author_author_id`),
  CONSTRAINT `fk_Favourite_Author_User1` FOREIGN KEY (`User_user_id`) REFERENCES `User` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Favourite_Author_Author1` FOREIGN KEY (`Author_author_id`) REFERENCES `Author` (`author_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Favourite_Author`
--

LOCK TABLES `Favourite_Author` WRITE;
/*!40000 ALTER TABLE `Favourite_Author` DISABLE KEYS */;
/*!40000 ALTER TABLE `Favourite_Author` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Favourite_Genre`
--

DROP TABLE IF EXISTS `Favourite_Genre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Favourite_Genre` (
  `User_user_id` int(11) NOT NULL,
  `Genre_genre_id` int(11) NOT NULL,
  PRIMARY KEY (`User_user_id`,`Genre_genre_id`),
  KEY `fk_Favourite_Genre_Genre1_idx` (`Genre_genre_id`),
  CONSTRAINT `fk_Favourite_Genre_User1` FOREIGN KEY (`User_user_id`) REFERENCES `User` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Favourite_Genre_Genre1` FOREIGN KEY (`Genre_genre_id`) REFERENCES `Genre` (`genre_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Favourite_Genre`
--

LOCK TABLES `Favourite_Genre` WRITE;
/*!40000 ALTER TABLE `Favourite_Genre` DISABLE KEYS */;
/*!40000 ALTER TABLE `Favourite_Genre` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Genre`
--

DROP TABLE IF EXISTS `Genre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Genre` (
  `genre_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `description` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`genre_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Genre`
--

LOCK TABLES `Genre` WRITE;
/*!40000 ALTER TABLE `Genre` DISABLE KEYS */;
/*!40000 ALTER TABLE `Genre` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Manga`
--

DROP TABLE IF EXISTS `Manga`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Manga` (
  `manga_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `description` varchar(45) DEFAULT NULL,
  `image_directory` varchar(45) DEFAULT NULL,
  `Genere_User_user_id` int(11) NOT NULL,
  `Author_author_id` int(11) NOT NULL,
  `Artist_artist_id` int(11) NOT NULL,
  `Publisher_publisher_id` int(11) NOT NULL,
  PRIMARY KEY (`manga_id`,`Genere_User_user_id`,`Author_author_id`,`Artist_artist_id`,`Publisher_publisher_id`),
  KEY `fk_Manga_Genere1_idx` (`Genere_User_user_id`),
  KEY `fk_Manga_Author1_idx` (`Author_author_id`),
  KEY `fk_Manga_Artist1_idx` (`Artist_artist_id`),
  KEY `fk_Manga_Publisher1_idx` (`Publisher_publisher_id`),
  CONSTRAINT `fk_Manga_Genere1` FOREIGN KEY (`Genere_User_user_id`) REFERENCES `Genre` (`genre_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Manga_Author1` FOREIGN KEY (`Author_author_id`) REFERENCES `Author` (`author_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Manga_Artist1` FOREIGN KEY (`Artist_artist_id`) REFERENCES `Artist` (`artist_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Manga_Publisher1` FOREIGN KEY (`Publisher_publisher_id`) REFERENCES `Publisher` (`publisher_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Manga`
--

LOCK TABLES `Manga` WRITE;
/*!40000 ALTER TABLE `Manga` DISABLE KEYS */;
/*!40000 ALTER TABLE `Manga` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `People`
--

DROP TABLE IF EXISTS `People`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `People` (
  `people_id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(45) DEFAULT NULL,
  `last_name` varchar(45) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  PRIMARY KEY (`people_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `People`
--

LOCK TABLES `People` WRITE;
/*!40000 ALTER TABLE `People` DISABLE KEYS */;
/*!40000 ALTER TABLE `People` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Publisher`
--

DROP TABLE IF EXISTS `Publisher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Publisher` (
  `publisher_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `description` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`publisher_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Publisher`
--

LOCK TABLES `Publisher` WRITE;
/*!40000 ALTER TABLE `Publisher` DISABLE KEYS */;
/*!40000 ALTER TABLE `Publisher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `User`
--

DROP TABLE IF EXISTS `User`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `User` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `password` varchar(45) DEFAULT NULL,
  `People_people_id` int(11) NOT NULL,
  PRIMARY KEY (`user_id`,`People_people_id`),
  KEY `fk_User_People1_idx` (`People_people_id`),
  CONSTRAINT `fk_User_People1` FOREIGN KEY (`People_people_id`) REFERENCES `People` (`people_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User`
--

LOCK TABLES `User` WRITE;
/*!40000 ALTER TABLE `User` DISABLE KEYS */;
/*!40000 ALTER TABLE `User` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-11-27 12:28:51
