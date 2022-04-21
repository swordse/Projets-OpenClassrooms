CREATE DATABASE  IF NOT EXISTS `oc_pizza` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `oc_pizza`;
-- MySQL dump 10.13  Distrib 8.0.26, for macos11 (x86_64)
--
-- Host: 127.0.0.1    Database: oc_pizza
-- ------------------------------------------------------
-- Server version	8.0.26

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `address` (
  `idaddress` int NOT NULL,
  `street` varchar(45) DEFAULT NULL,
  `city` varchar(45) DEFAULT NULL,
  `zip` varchar(45) DEFAULT NULL,
  `pizzeria_idpizzeria` int NOT NULL,
  PRIMARY KEY (`idaddress`),
  KEY `fk_address_pizzeria1_idx` (`pizzeria_idpizzeria`),
  CONSTRAINT `fk_address_pizzeria1` FOREIGN KEY (`pizzeria_idpizzeria`) REFERENCES `pizzeria` (`idpizzeria`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `idUser` int NOT NULL,
  `email` varchar(45) DEFAULT NULL,
  `password` varchar(45) DEFAULT NULL,
  `phone` varchar(45) DEFAULT NULL,
  `address_idaddress` int NOT NULL,
  `firstName` varchar(45) DEFAULT NULL,
  `lastName` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idUser`),
  KEY `fk_user_address1_idx` (`address_idaddress`),
  CONSTRAINT `fk_user_address1` FOREIGN KEY (`address_idaddress`) REFERENCES `address` (`idaddress`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee` (
  `idemployee` int NOT NULL,
  `role` varchar(45) DEFAULT NULL,
  `password` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `pizzeria_idpizzeria` int NOT NULL,
  `firstName` varchar(45) DEFAULT NULL,
  `lastName` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idemployee`),
  KEY `fk_employee_pizzeria1_idx` (`pizzeria_idpizzeria`),
  CONSTRAINT `fk_employee_pizzeria1` FOREIGN KEY (`pizzeria_idpizzeria`) REFERENCES `pizzeria` (`idpizzeria`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ingredient`
--

DROP TABLE IF EXISTS `ingredient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ingredient` (
  `idingredient` int NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `price` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idingredient`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `order`
--

DROP TABLE IF EXISTS `order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `order` (
  `idorder` int NOT NULL,
  `pizzeria_idpizzeria` int NOT NULL,
  `payment` tinyint DEFAULT NULL,
  `state` tinyint DEFAULT NULL,
  `employee_idemployee` int NOT NULL,
  `customer_idUser` int NOT NULL,
  `price` int DEFAULT NULL,
  `date` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idorder`),
  KEY `fk_order_pizzeria1_idx` (`pizzeria_idpizzeria`),
  KEY `fk_order_employee1_idx` (`employee_idemployee`),
  KEY `fk_order_customer1_idx` (`customer_idUser`),
  CONSTRAINT `fk_order_customer1` FOREIGN KEY (`customer_idUser`) REFERENCES `customer` (`idUser`),
  CONSTRAINT `fk_order_employee1` FOREIGN KEY (`employee_idemployee`) REFERENCES `employee` (`idemployee`),
  CONSTRAINT `fk_order_pizzeria1` FOREIGN KEY (`pizzeria_idpizzeria`) REFERENCES `pizzeria` (`idpizzeria`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `orderLine`
--

DROP TABLE IF EXISTS `orderLine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `orderLine` (
  `product_idproduct` int NOT NULL,
  `order_idorder` int NOT NULL,
  `quantity` int DEFAULT NULL,
  PRIMARY KEY (`product_idproduct`,`order_idorder`),
  KEY `fk_product_has_order_order1_idx` (`order_idorder`),
  KEY `fk_product_has_order_product1_idx` (`product_idproduct`),
  CONSTRAINT `fk_product_has_order_order1` FOREIGN KEY (`order_idorder`) REFERENCES `order` (`idorder`),
  CONSTRAINT `fk_product_has_order_product1` FOREIGN KEY (`product_idproduct`) REFERENCES `product` (`idproduct`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pizzeria`
--

DROP TABLE IF EXISTS `pizzeria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pizzeria` (
  `idpizzeria` int NOT NULL,
  `phone` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idpizzeria`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `product` (
  `idproduct` int NOT NULL,
  `reference` int DEFAULT NULL,
  `prix` int DEFAULT NULL,
  `description` varchar(45) DEFAULT NULL,
  `picture` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idproduct`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `recipe`
--

DROP TABLE IF EXISTS `recipe`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `recipe` (
  `ingredient_idingredient` int NOT NULL,
  `product_idproduct` int NOT NULL,
  `quantity` int DEFAULT NULL,
  PRIMARY KEY (`ingredient_idingredient`,`product_idproduct`),
  KEY `fk_ingredient_has_product_product1_idx` (`product_idproduct`),
  KEY `fk_ingredient_has_product_ingredient1_idx` (`ingredient_idingredient`),
  CONSTRAINT `fk_ingredient_has_product_ingredient1` FOREIGN KEY (`ingredient_idingredient`) REFERENCES `ingredient` (`idingredient`),
  CONSTRAINT `fk_ingredient_has_product_product1` FOREIGN KEY (`product_idproduct`) REFERENCES `product` (`idproduct`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stock`
--

DROP TABLE IF EXISTS `stock`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stock` (
  `ingredient_idingredient` int NOT NULL,
  `pizzeria_idpizzeria` int NOT NULL,
  `quantity` int DEFAULT NULL,
  PRIMARY KEY (`ingredient_idingredient`,`pizzeria_idpizzeria`),
  KEY `fk_ingredient_has_pizzeria_pizzeria1_idx` (`pizzeria_idpizzeria`),
  KEY `fk_ingredient_has_pizzeria_ingredient1_idx` (`ingredient_idingredient`),
  CONSTRAINT `fk_ingredient_has_pizzeria_ingredient1` FOREIGN KEY (`ingredient_idingredient`) REFERENCES `ingredient` (`idingredient`),
  CONSTRAINT `fk_ingredient_has_pizzeria_pizzeria1` FOREIGN KEY (`pizzeria_idpizzeria`) REFERENCES `pizzeria` (`idpizzeria`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-10-26 18:16:52
