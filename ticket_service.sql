CREATE DATABASE  IF NOT EXISTS `ticket_service` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `ticket_service`;
-- MySQL dump 10.13  Distrib 5.7.17, for Win64 (x86_64)
--
-- Host: localhost    Database: ticket_service
-- ------------------------------------------------------
-- Server version	5.7.21

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
-- Table structure for table `cities`
--

DROP TABLE IF EXISTS `cities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cities` (
  `idcity` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  PRIMARY KEY (`idcity`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cities`
--

LOCK TABLES `cities` WRITE;
/*!40000 ALTER TABLE `cities` DISABLE KEYS */;
INSERT INTO `cities` VALUES (1,'Beograd'),(2,'Novi Sad'),(3,'Niš'),(4,'Pančevo'),(7,'Leskovac'),(8,'Kovin'),(9,'Zrenjanin'),(10,'Valjevo'),(11,'Arandjelovac'),(12,'Loznica'),(13,'Kragujevac'),(14,'Kraljevo'),(15,'Zajecar'),(16,'Vranje'),(17,'Kikinda'),(18,'Jagodina');
/*!40000 ALTER TABLE `cities` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `first_questions`
--

DROP TABLE IF EXISTS `first_questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `first_questions` (
  `fk_id_questions` int(11) NOT NULL,
  `fk_idticket_type` int(11) NOT NULL,
  PRIMARY KEY (`fk_id_questions`,`fk_idticket_type`),
  KEY `fk_first_questions_questions1_idx` (`fk_id_questions`),
  KEY `fk_first_questions_ticket_type1_idx` (`fk_idticket_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `first_questions`
--

LOCK TABLES `first_questions` WRITE;
/*!40000 ALTER TABLE `first_questions` DISABLE KEYS */;
INSERT INTO `first_questions` VALUES (1,2),(6,1),(7,3);
/*!40000 ALTER TABLE `first_questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group`
--

DROP TABLE IF EXISTS `group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `group` (
  `idgroup` int(11) NOT NULL AUTO_INCREMENT,
  `subject` varchar(45) NOT NULL,
  PRIMARY KEY (`idgroup`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group`
--

LOCK TABLES `group` WRITE;
/*!40000 ALTER TABLE `group` DISABLE KEYS */;
INSERT INTO `group` VALUES (1,'No group'),(2,'Nema struje'),(4,'Kasni penzija');
/*!40000 ALTER TABLE `group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `operators`
--

DROP TABLE IF EXISTS `operators`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `operators` (
  `username` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `type` tinyint(4) NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `img` varchar(1024) DEFAULT 'https://i.imgur.com/BzhK6E6.png',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `operators`
--

LOCK TABLES `operators` WRITE;
/*!40000 ALTER TABLE `operators` DISABLE KEYS */;
INSERT INTO `operators` VALUES ('aca','123',0,1,'https://i.imgur.com/cj0sQzq.jpg'),('admin','123',1,2,'http://rti.etf.bg.ac.rs/rti/ir4pia/images/boskon.jpg'),('marko','123',0,3,'https://i.imgur.com/W0Yz7SR.jpg'),('darko','123',0,4,'https://i.imgur.com/dC9GVmZ.jpg'),('srdjan','123',0,7,'https://miro.medium.com/fit/c/240/240/1*3fX6dsMtgVRx4QwteA2bqg.jpeg');
/*!40000 ALTER TABLE `operators` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `question_associations`
--

DROP TABLE IF EXISTS `question_associations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `question_associations` (
  `answer` varchar(45) NOT NULL,
  `id_question1` int(11) NOT NULL,
  `id_question2` int(11) NOT NULL,
  PRIMARY KEY (`answer`,`id_question1`,`id_question2`),
  KEY `id_question1_idx` (`id_question1`),
  KEY `id_question2_idx` (`id_question2`),
  CONSTRAINT `id_question1` FOREIGN KEY (`id_question1`) REFERENCES `questions` (`id_questions`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `id_question2` FOREIGN KEY (`id_question2`) REFERENCES `questions` (`id_questions`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `question_associations`
--

LOCK TABLES `question_associations` WRITE;
/*!40000 ALTER TABLE `question_associations` DISABLE KEYS */;
INSERT INTO `question_associations` VALUES ('Maybe',1,2),('Yes',1,2),('Maybe',2,4),('No',2,4),('Yes',2,3),('Maybe',3,5),('No',3,5),('Yes',3,5),('Maybe',4,5),('No',4,5),('Yes',4,5),('Maybe',6,8),('No',6,10),('Yes',6,8),('Maybe',7,10),('No',7,10),('Yes',7,11),('Maybe',8,10),('No',8,10),('Yes',8,9),('Maybe',11,12),('No',11,12),('Yes',11,12),('Maybe',12,14),('No',12,14),('Yes',12,13);
/*!40000 ALTER TABLE `question_associations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `questions`
--

DROP TABLE IF EXISTS `questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `questions` (
  `id_questions` int(11) NOT NULL AUTO_INCREMENT,
  `question` varchar(256) NOT NULL,
  PRIMARY KEY (`id_questions`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questions`
--

LOCK TABLES `questions` WRITE;
/*!40000 ALTER TABLE `questions` DISABLE KEYS */;
INSERT INTO `questions` VALUES (1,'Is your computer turned on?'),(2,'Is light on modem on?'),(3,'Have you restarted modem?'),(4,'Is modem plugged in?'),(5,'Have you paid montly subscription?'),(6,'Is your TV plugged in?'),(7,'Is your phone plugged in?'),(8,'Is your screen turned on?'),(9,'Do you have all channels?'),(10,'Do you have electricity?'),(11,'Do you have signal?'),(12,'Can you receive phone calls?'),(13,'Can you call anyone?'),(14,'How old is your device?');
/*!40000 ALTER TABLE `questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `request_type`
--

DROP TABLE IF EXISTS `request_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `request_type` (
  `idrequest_type` int(11) NOT NULL AUTO_INCREMENT,
  `request_type` varchar(45) NOT NULL,
  PRIMARY KEY (`idrequest_type`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `request_type`
--

LOCK TABLES `request_type` WRITE;
/*!40000 ALTER TABLE `request_type` DISABLE KEYS */;
INSERT INTO `request_type` VALUES (1,'Phone'),(2,'E-mail'),(3,'SMS');
/*!40000 ALTER TABLE `request_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `status`
--

DROP TABLE IF EXISTS `status`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `status` (
  `idstatus` int(11) NOT NULL AUTO_INCREMENT,
  `status_type` varchar(45) NOT NULL,
  PRIMARY KEY (`idstatus`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `status`
--

LOCK TABLES `status` WRITE;
/*!40000 ALTER TABLE `status` DISABLE KEYS */;
INSERT INTO `status` VALUES (1,'Open'),(2,'Pending'),(3,'Closed');
/*!40000 ALTER TABLE `status` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket_conversation`
--

DROP TABLE IF EXISTS `ticket_conversation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ticket_conversation` (
  `id_conversation` int(11) NOT NULL AUTO_INCREMENT,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `question_answer` tinyint(4) NOT NULL,
  `ticket_id` int(11) NOT NULL,
  PRIMARY KEY (`id_conversation`),
  KEY `id_ticket_idx` (`ticket_id`),
  CONSTRAINT `id_ticket` FOREIGN KEY (`ticket_id`) REFERENCES `tickets` (`id_ticket`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket_conversation`
--

LOCK TABLES `ticket_conversation` WRITE;
/*!40000 ALTER TABLE `ticket_conversation` DISABLE KEYS */;
/*!40000 ALTER TABLE `ticket_conversation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket_type`
--

DROP TABLE IF EXISTS `ticket_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ticket_type` (
  `idticket_type` int(11) NOT NULL AUTO_INCREMENT,
  `ticket_type` varchar(45) NOT NULL,
  PRIMARY KEY (`idticket_type`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket_type`
--

LOCK TABLES `ticket_type` WRITE;
/*!40000 ALTER TABLE `ticket_type` DISABLE KEYS */;
INSERT INTO `ticket_type` VALUES (1,'TV problem'),(2,'Internet problem'),(3,'Phone problem');
/*!40000 ALTER TABLE `ticket_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tickets`
--

DROP TABLE IF EXISTS `tickets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tickets` (
  `id_ticket` int(11) NOT NULL AUTO_INCREMENT,
  `ticket_date` date NOT NULL,
  `fk_idstatus` int(11) DEFAULT NULL,
  `fk_idrequest_type` int(11) DEFAULT NULL,
  `comment` varchar(1024) NOT NULL,
  `fk_id_user` int(11) DEFAULT NULL,
  `fk_idoperators` int(11) DEFAULT NULL,
  `idgroup` int(11) DEFAULT NULL,
  `fk_idticket_type` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_ticket`),
  KEY `fk_tickets_users_idx` (`fk_id_user`),
  KEY `idgroup_idx` (`idgroup`),
  KEY `fk_tickets_ticket_type1_idx` (`fk_idticket_type`),
  KEY `fk_tickets_request_type1_idx` (`fk_idrequest_type`),
  KEY `fk_tickets_status1_idx` (`fk_idstatus`),
  KEY `fk_tickets_operators1_idx` (`fk_idoperators`),
  CONSTRAINT `fk_tickets_operators1` FOREIGN KEY (`fk_idoperators`) REFERENCES `operators` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_tickets_request_type1` FOREIGN KEY (`fk_idrequest_type`) REFERENCES `request_type` (`idrequest_type`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_tickets_status1` FOREIGN KEY (`fk_idstatus`) REFERENCES `status` (`idstatus`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_tickets_ticket_type1` FOREIGN KEY (`fk_idticket_type`) REFERENCES `ticket_type` (`idticket_type`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `idgroup` FOREIGN KEY (`idgroup`) REFERENCES `group` (`idgroup`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `tickets_users` FOREIGN KEY (`fk_id_user`) REFERENCES `users` (`id_user`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tickets`
--

LOCK TABLES `tickets` WRITE;
/*!40000 ALTER TABLE `tickets` DISABLE KEYS */;
INSERT INTO `tickets` VALUES (2,'2018-05-17',1,2,'',120,3,1,1),(3,'2018-05-17',2,2,'',120,3,2,1),(4,'2018-05-17',1,2,'',120,3,1,1),(12,'2018-05-22',1,1,'\n2018-05-27 00:06:34\n\n ',7,3,2,1),(13,'2018-05-22',2,1,'\n2018-05-26 11:06:51\n\nTicket closed\n2018-05-26 11:09:11\n\n \n2018-05-26 11:09:19\n\nTicket closed\n2018-05-26 12:47:23\n\n \n2018-05-26 12:47:49\nmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm\n \n2018-05-29 09:21:11\n\n \n2018-05-29 09:21:15\n\n ',5,3,NULL,2),(14,'2018-05-29',1,1,'\n2018-05-29 09:26:08\n\n \n2018-05-29 09:26:12\n\n ',5,3,1,1),(15,'2018-05-30',1,1,'',121,2,2,1),(16,'2018-06-01',1,1,'',120,7,1,1),(17,'2018-06-01',1,1,'',121,7,1,1),(18,'2018-06-01',1,1,'',121,7,1,1),(19,'2018-06-01',1,1,'',121,7,1,1),(20,'2018-06-01',1,1,'',121,7,1,1),(21,'2018-06-01',1,1,'',121,7,1,1),(22,'2018-06-01',1,1,'',123,7,1,1),(23,'2018-06-01',1,1,'',121,7,1,1),(24,'2018-06-01',1,1,'',123,7,1,1),(25,'2018-06-01',1,1,'',120,7,1,1),(26,'2018-06-01',1,1,'',9,7,1,1),(27,'2018-06-01',1,1,'',9,7,1,1),(28,'2018-06-01',1,1,'',120,7,1,1),(29,'2018-06-01',1,1,'',7,7,1,1),(30,'2018-06-01',1,1,'',7,7,1,1),(31,'2018-06-01',1,1,'',7,7,1,2),(32,'2018-06-01',1,1,'',120,7,1,1),(33,'2018-06-01',1,1,'',120,7,1,1),(34,'2018-06-01',1,1,'',123,7,1,1),(35,'2018-06-01',1,1,'',121,7,1,1),(36,'2018-06-01',1,1,'',9,7,1,1),(37,'2018-06-01',1,1,'',123,7,1,1),(38,'2018-06-01',1,1,'',121,7,1,1),(39,'2018-06-01',1,1,'',123,7,1,1),(40,'2018-06-01',1,1,'',121,7,1,1),(41,'2018-06-01',1,1,'',121,7,1,1),(42,'2018-06-01',1,1,'',123,7,1,1),(43,'2018-06-01',1,1,'',9,7,1,1),(44,'2018-06-01',1,1,'',121,7,1,1),(45,'2018-06-01',1,1,'',123,7,1,1),(46,'2018-06-01',1,1,'',120,7,1,1),(47,'2018-06-01',1,1,'',123,7,1,1),(48,'2018-06-01',1,1,'',123,7,1,1),(49,'2018-06-01',1,1,'',123,7,1,1),(50,'2018-06-01',1,1,'',123,7,1,1),(51,'2018-06-01',1,1,'',123,7,1,1),(52,'2018-06-01',1,1,'',123,7,1,1),(53,'2018-06-01',1,1,'',123,7,1,1),(54,'2018-06-01',1,1,'',123,7,1,1),(55,'2018-06-01',1,1,'',123,7,1,1),(56,'2018-06-01',1,1,'',123,7,1,1),(57,'2018-06-01',1,1,'',123,7,1,1),(58,'2018-06-01',1,1,'',123,7,1,1),(59,'2018-06-01',1,1,'',123,7,1,1),(60,'2018-06-01',1,1,'',123,7,1,1);
/*!40000 ALTER TABLE `tickets` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_answers`
--

DROP TABLE IF EXISTS `user_answers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_answers` (
  `id_user_answers` int(11) NOT NULL AUTO_INCREMENT,
  `user_answer` varchar(45) NOT NULL,
  `fk_id_user` int(11) NOT NULL,
  `fk_operators_id` int(11) NOT NULL,
  `fk_id_ticket` int(11) NOT NULL,
  PRIMARY KEY (`id_user_answers`),
  KEY `fk_user_answers_users1_idx` (`fk_id_user`),
  KEY `fk_user_answers_operators1_idx` (`fk_operators_id`),
  KEY `fk_user_answers_tickets1_idx` (`fk_id_ticket`),
  CONSTRAINT `fk_id_ticket` FOREIGN KEY (`fk_id_ticket`) REFERENCES `tickets` (`id_ticket`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_id_user` FOREIGN KEY (`fk_id_user`) REFERENCES `users` (`id_user`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_operators_id` FOREIGN KEY (`fk_operators_id`) REFERENCES `operators` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_answers`
--

LOCK TABLES `user_answers` WRITE;
/*!40000 ALTER TABLE `user_answers` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_answers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id_user` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(45) NOT NULL,
  `last_name` varchar(45) NOT NULL,
  `phone_number` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `address` varchar(256) NOT NULL,
  `id_city` int(11) NOT NULL,
  PRIMARY KEY (`id_user`),
  KEY `id_city_idx` (`id_city`),
  CONSTRAINT `id_city` FOREIGN KEY (`id_city`) REFERENCES `cities` (`idcity`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=124 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (5,'Marko','Markovic','064/111-222','fsfssf@com.com','Bulevar 33',1),(6,'Pera','Peric','064/111-222','fsfssf@com.com','Bulevar 33',1),(7,'d','f','g','h','j',1),(9,'Pera','Peric','02223544','sdjdsdl','csd',1),(64,'a','a','a','a','a',3),(120,'dsadasda','aasdasda','33333333','gg@gmail.com','sdadada',1),(121,'ddfd','gggggaaaaa','123456789','dddd@ksks.mmm','aaaaa',1),(122,'hhh','jjjjj','123456999','hjhj@xcxcx.com','ssssssss',2),(123,'perA','petrovic','555333','pera@gmail.com','Perovic',1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-06-01 12:46:26