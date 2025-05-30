-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: localhost    Database: Crypton
-- ------------------------------------------------------
-- Server version	11.5.0-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientes` (
  `client_ID` int(11) NOT NULL AUTO_INCREMENT,
  `client_fname` varchar(100) NOT NULL,
  `client_lname` varchar(100) NOT NULL,
  `client_email` varchar(255) NOT NULL,
  `client_phone` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`client_ID`),
  UNIQUE KEY `client_email` (`client_email`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` VALUES (10,'balls','balls','balls@gmail.com','8142069420'),(11,'miku','hatune','miku@gmail.com','8112543447'),(12,'luz','Colunga','luzdanielacol12@gmail.com','8112543447'),(13,'bolas','bolas','bolas@gmail.com','843516824');
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clienteslogins`
--

DROP TABLE IF EXISTS `clienteslogins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clienteslogins` (
  `client_ID` int(11) NOT NULL,
  `client_user` varchar(50) NOT NULL,
  `client_password` varchar(64) DEFAULT NULL,
  PRIMARY KEY (`client_ID`),
  CONSTRAINT `clienteslogins_ibfk_1` FOREIGN KEY (`client_ID`) REFERENCES `clientes` (`client_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clienteslogins`
--

LOCK TABLES `clienteslogins` WRITE;
/*!40000 ALTER TABLE `clienteslogins` DISABLE KEYS */;
INSERT INTO `clienteslogins` VALUES (10,'balls','348d77e943a990e64b08bd3bafc7c1b3fde497e92670f78cd8e9eb27529706f2'),(11,'miku','5a9e67380adf22a6d0766b17fd607c4be780a50333aebeb2471538b464148e90'),(12,'luz','123'),(13,'bolas','bolas');
/*!40000 ALTER TABLE `clienteslogins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detallespedidos`
--

DROP TABLE IF EXISTS `detallespedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detallespedidos` (
  `detail_ID` int(11) NOT NULL AUTO_INCREMENT,
  `product_ID` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  PRIMARY KEY (`detail_ID`),
  KEY `product_ID` (`product_ID`),
  KEY `order_id` (`order_id`),
  CONSTRAINT `detallespedidos_ibfk_1` FOREIGN KEY (`product_ID`) REFERENCES `productos` (`product_ID`),
  CONSTRAINT `detallespedidos_ibfk_2` FOREIGN KEY (`order_id`) REFERENCES `pedidos` (`order_id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detallespedidos`
--

LOCK TABLES `detallespedidos` WRITE;
/*!40000 ALTER TABLE `detallespedidos` DISABLE KEYS */;
INSERT INTO `detallespedidos` VALUES (5,19,1),(6,19,1),(7,19,1),(8,20,1),(9,21,1),(10,21,1),(11,18,1),(12,17,1),(33,31,5),(34,30,6);
/*!40000 ALTER TABLE `detallespedidos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pagos`
--

DROP TABLE IF EXISTS `pagos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pagos` (
  `payment_ID` int(11) NOT NULL AUTO_INCREMENT,
  `order_id` int(11) NOT NULL,
  `payment_date` date NOT NULL,
  `payment_amount` decimal(10,2) NOT NULL,
  `payment_method` varchar(50) NOT NULL,
  PRIMARY KEY (`payment_ID`),
  KEY `order_id` (`order_id`),
  CONSTRAINT `pagos_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `pedidos` (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pagos`
--

LOCK TABLES `pagos` WRITE;
/*!40000 ALTER TABLE `pagos` DISABLE KEYS */;
/*!40000 ALTER TABLE `pagos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedidos`
--

DROP TABLE IF EXISTS `pedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedidos` (
  `order_id` int(11) NOT NULL AUTO_INCREMENT,
  `client_ID` int(11) NOT NULL,
  `order_date` date NOT NULL,
  `order_total` decimal(10,2) NOT NULL,
  PRIMARY KEY (`order_id`),
  KEY `client_ID` (`client_ID`),
  CONSTRAINT `pedidos_ibfk_1` FOREIGN KEY (`client_ID`) REFERENCES `clientes` (`client_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidos`
--

LOCK TABLES `pedidos` WRITE;
/*!40000 ALTER TABLE `pedidos` DISABLE KEYS */;
INSERT INTO `pedidos` VALUES (1,10,'2024-12-09',0.00),(2,12,'2024-12-09',12458.17),(3,12,'2024-12-09',2325.57),(4,12,'2024-12-09',0.00),(5,13,'2024-12-09',1803.11),(6,13,'2024-12-09',2307.98),(7,13,'2024-12-09',0.00);
/*!40000 ALTER TABLE `pedidos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productos`
--

DROP TABLE IF EXISTS `productos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `productos` (
  `product_ID` int(11) NOT NULL AUTO_INCREMENT,
  `product_name` varchar(255) NOT NULL,
  `product_price` decimal(10,2) NOT NULL,
  `product_category` varchar(100) DEFAULT NULL,
  `product_discount` decimal(5,2) DEFAULT 0.00,
  PRIMARY KEY (`product_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productos`
--

LOCK TABLES `productos` WRITE;
/*!40000 ALTER TABLE `productos` DISABLE KEYS */;
INSERT INTO `productos` VALUES (1,'XV Series',9146.56,'Bibliotecas de Efectos Especiales',0.00),(2,'Flash EFX',2143.72,'Bibliotecas de Efectos Especiales',0.00),(3,'Larger Than Life',8003.24,'Bibliotecas de Efectos Especiales',0.00),(4,'Disney Ideas',2143.72,'Bibliotecas de Efectos Especiales',0.00),(5,'Turner Entertainment Co SFX Library',4859.11,'Bibliotecas de Efectos Especiales',0.00),(6,'Sonicwire01',691.86,'CDs de Muestra',0.00),(7,'Sonicwire02 Techno',691.86,'CDs de Muestra',0.00),(8,'Sonicwire03 Hip Hop Mayor',691.86,'CDs de Muestra',0.00),(9,'Sonicwire04 Jazz',691.86,'CDs de Muestra',0.00),(10,'Sonicwire05 R&B',691.86,'CDs de Muestra',0.00),(11,'Shimmer & Shake',1803.11,'CDs de Muestra',0.00),(12,'Hatsune Miku NT',2596.48,'Fuentes de Sonido',0.00),(13,'EZ Bass',2884.98,'Fuentes de Sonido',0.00),(14,'EZKey MIDI 6PACK',1857.89,'Fuentes de Sonido',0.00),(15,'Acou6tics',7431.58,'Fuentes de Sonido',0.00),(16,'Electri6ity',7431.58,'Fuentes de Sonido',0.00),(17,'Garritan Instant Orchestra',2621.06,'Fuentes de Sonido',0.00),(18,'Superior Drummer 3',6491.21,'Fuentes de Sonido',0.00),(19,'VOCALOID 4 Rin and Len',2325.57,'Vocaloid',0.00),(20,'VOCALOID 4 Megurine Luka',2325.57,'Vocaloid',0.00),(21,'VOCALOID 4 Hatsune Miku',2325.57,'Vocaloid',0.00),(22,'VOCALOID 3 KAITO',2325.57,'Vocaloid',0.00),(23,'VOCALOID 3 MEIKO',2325.57,'Vocaloid',0.00),(24,'MOJO Horn Section',9289.47,'Fuentes de Sonido',0.00),(25,'Orchestral Essentials',3572.87,'Fuentes de Sonido',0.00),(26,'Orchestral Essentials 2',3572.87,'Fuentes de Sonido',0.00),(27,'Orchestral Essentials Pack',6288.26,'Fuentes de Sonido',0.00),(28,'Piapro Characters Super Pack',3029.23,'Vocaloid',0.00),(29,'Historic Presidential Speeches',4144.53,'Bibliotecas de Efectos Especiales',0.00),(30,'SPIRITOSO LIVE CELLO PHRASES',2307.98,'CDs de Muestra',0.00),(31,'PERPETUO LIVE FLUTE PHRASES',1803.11,'CDs de Muestra',0.00);
/*!40000 ALTER TABLE `productos` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-09 13:42:22
