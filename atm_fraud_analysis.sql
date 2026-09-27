CREATE DATABASE  IF NOT EXISTS `atm_fraud_analysis` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `atm_fraud_analysis`;
-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: localhost    Database: atm_fraud_analysis
-- ------------------------------------------------------
-- Server version	8.0.39

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
-- Table structure for table `account`
--

DROP TABLE IF EXISTS `account`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `account` (
  `account_id` int NOT NULL AUTO_INCREMENT,
  `customer_id` int NOT NULL,
  `account_number` varchar(20) NOT NULL,
  `account_type` enum('SAVINGS','CURRENT') NOT NULL,
  `balance` decimal(12,2) NOT NULL DEFAULT '0.00',
  `daily_limit` decimal(12,2) NOT NULL DEFAULT '50000.00',
  `account_status` enum('ACTIVE','BLOCKED','CLOSED') DEFAULT 'ACTIVE',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`account_id`),
  UNIQUE KEY `account_number` (`account_number`),
  KEY `fk_account_customer` (`customer_id`),
  CONSTRAINT `fk_account_customer` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account`
--

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;
INSERT INTO `account` VALUES (1,1,'ACC10001','SAVINGS',85000.00,50000.00,'ACTIVE','2026-09-26 21:06:13'),(2,2,'ACC10002','SAVINGS',120000.00,60000.00,'ACTIVE','2026-09-26 21:06:13'),(3,3,'ACC10003','CURRENT',250000.00,100000.00,'ACTIVE','2026-09-26 21:06:13'),(4,4,'ACC10004','SAVINGS',45000.00,40000.00,'ACTIVE','2026-09-26 21:06:13'),(5,5,'ACC10005','SAVINGS',95000.00,50000.00,'ACTIVE','2026-09-26 21:06:13'),(6,6,'ACC10006','CURRENT',180000.00,100000.00,'ACTIVE','2026-09-26 21:06:13'),(7,7,'ACC10007','SAVINGS',65000.00,50000.00,'ACTIVE','2026-09-26 21:06:13'),(8,8,'ACC10008','SAVINGS',150000.00,75000.00,'ACTIVE','2026-09-26 21:06:13'),(9,9,'ACC10009','SAVINGS',70000.00,50000.00,'ACTIVE','2026-09-26 21:06:13'),(10,10,'ACC10010','CURRENT',300000.00,100000.00,'ACTIVE','2026-09-26 21:06:13');
/*!40000 ALTER TABLE `account` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `account_risk_analysis`
--

DROP TABLE IF EXISTS `account_risk_analysis`;
/*!50001 DROP VIEW IF EXISTS `account_risk_analysis`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `account_risk_analysis` AS SELECT 
 1 AS `account_id`,
 1 AS `total_alerts`,
 1 AS `risk_score`,
 1 AS `high_alerts`,
 1 AS `medium_alerts`,
 1 AS `open_alerts`,
 1 AS `risk_level`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `atm`
--

DROP TABLE IF EXISTS `atm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `atm` (
  `atm_id` int NOT NULL AUTO_INCREMENT,
  `atm_location` varchar(150) NOT NULL,
  `city` varchar(50) NOT NULL,
  `state` varchar(50) NOT NULL,
  `status` enum('ACTIVE','INACTIVE','MAINTENANCE') DEFAULT 'ACTIVE',
  PRIMARY KEY (`atm_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `atm`
--

LOCK TABLES `atm` WRITE;
/*!40000 ALTER TABLE `atm` DISABLE KEYS */;
INSERT INTO `atm` VALUES (1,'MG Road ATM','Bangalore','Karnataka','ACTIVE'),(2,'Electronic City ATM','Bangalore','Karnataka','ACTIVE'),(3,'Banjara Hills ATM','Hyderabad','Telangana','ACTIVE'),(4,'Hitech City ATM','Hyderabad','Telangana','ACTIVE'),(5,'T Nagar ATM','Chennai','Tamil Nadu','ACTIVE'),(6,'Anna Nagar ATM','Chennai','Tamil Nadu','ACTIVE'),(7,'RTC Bus Stand ATM','Tirupati','Andhra Pradesh','ACTIVE'),(8,'Railway Station ATM','Tirupati','Andhra Pradesh','ACTIVE'),(9,'Andheri ATM','Mumbai','Maharashtra','ACTIVE'),(10,'Connaught Place ATM','Delhi','Delhi','ACTIVE');
/*!40000 ALTER TABLE `atm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `atm_transaction`
--

DROP TABLE IF EXISTS `atm_transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `atm_transaction` (
  `transaction_id` bigint NOT NULL AUTO_INCREMENT,
  `account_id` int NOT NULL,
  `card_id` int NOT NULL,
  `atm_id` int NOT NULL,
  `transaction_type` enum('WITHDRAWAL','BALANCE_INQUIRY','PIN_CHANGE') NOT NULL,
  `amount` decimal(12,2) NOT NULL DEFAULT '0.00',
  `transaction_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `transaction_status` enum('SUCCESS','FAILED') NOT NULL,
  `failure_reason` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`transaction_id`),
  KEY `fk_transaction_account` (`account_id`),
  KEY `fk_transaction_card` (`card_id`),
  KEY `fk_transaction_atm` (`atm_id`),
  CONSTRAINT `fk_transaction_account` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`),
  CONSTRAINT `fk_transaction_atm` FOREIGN KEY (`atm_id`) REFERENCES `atm` (`atm_id`),
  CONSTRAINT `fk_transaction_card` FOREIGN KEY (`card_id`) REFERENCES `card` (`card_id`),
  CONSTRAINT `chk_transaction_amount` CHECK ((`amount` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `atm_transaction`
--

LOCK TABLES `atm_transaction` WRITE;
/*!40000 ALTER TABLE `atm_transaction` DISABLE KEYS */;
INSERT INTO `atm_transaction` VALUES (1,1,1,1,'WITHDRAWAL',5000.00,'2026-09-20 10:15:00','SUCCESS',NULL),(2,1,1,1,'WITHDRAWAL',3000.00,'2026-09-20 12:20:00','SUCCESS',NULL),(3,2,2,3,'WITHDRAWAL',10000.00,'2026-09-20 11:00:00','SUCCESS',NULL),(4,3,3,5,'WITHDRAWAL',25000.00,'2026-09-20 14:30:00','SUCCESS',NULL),(5,4,4,2,'WITHDRAWAL',5000.00,'2026-09-20 09:15:00','SUCCESS',NULL),(6,5,5,7,'WITHDRAWAL',7000.00,'2026-09-20 18:30:00','SUCCESS',NULL),(7,6,6,4,'WITHDRAWAL',15000.00,'2026-09-20 16:00:00','SUCCESS',NULL),(8,7,7,5,'WITHDRAWAL',8000.00,'2026-09-20 13:20:00','SUCCESS',NULL),(9,8,8,9,'WITHDRAWAL',20000.00,'2026-09-20 15:40:00','SUCCESS',NULL),(10,9,9,10,'WITHDRAWAL',12000.00,'2026-09-20 17:10:00','SUCCESS',NULL),(11,1,1,9,'WITHDRAWAL',30000.00,'2026-09-21 02:15:00','SUCCESS',NULL),(12,2,2,3,'WITHDRAWAL',10000.00,'2026-09-21 01:10:00','FAILED','Incorrect PIN'),(13,2,2,3,'WITHDRAWAL',10000.00,'2026-09-21 01:11:00','FAILED','Incorrect PIN'),(14,2,2,3,'WITHDRAWAL',10000.00,'2026-09-21 01:12:00','FAILED','Incorrect PIN'),(15,2,2,3,'WITHDRAWAL',10000.00,'2026-09-21 01:13:00','FAILED','Incorrect PIN'),(16,3,3,5,'WITHDRAWAL',60000.00,'2026-09-21 10:00:00','SUCCESS',NULL),(17,3,3,5,'WITHDRAWAL',50000.00,'2026-09-21 11:00:00','SUCCESS',NULL),(18,4,4,2,'WITHDRAWAL',5000.00,'2026-09-21 14:00:00','SUCCESS',NULL),(19,4,4,2,'WITHDRAWAL',5000.00,'2026-09-21 14:03:00','SUCCESS',NULL),(20,4,4,2,'WITHDRAWAL',5000.00,'2026-09-21 14:06:00','SUCCESS',NULL),(21,5,5,7,'WITHDRAWAL',10000.00,'2026-09-21 15:00:00','SUCCESS',NULL),(22,5,5,3,'WITHDRAWAL',15000.00,'2026-09-21 15:20:00','SUCCESS',NULL),(23,6,6,4,'WITHDRAWAL',65000.00,'2026-09-21 16:30:00','SUCCESS',NULL),(24,1,1,1,'WITHDRAWAL',30000.00,'2026-09-26 21:50:00','SUCCESS',NULL),(25,1,1,1,'WITHDRAWAL',5000.00,'2026-09-26 21:55:00','SUCCESS',NULL),(26,1,1,1,'WITHDRAWAL',5000.00,'2026-09-26 21:55:30','SUCCESS',NULL),(27,5,5,1,'WITHDRAWAL',5000.00,'2026-09-26 22:05:00','SUCCESS',NULL),(28,5,5,2,'WITHDRAWAL',5000.00,'2026-09-26 22:20:00','SUCCESS',NULL),(29,5,5,1,'WITHDRAWAL',5000.00,'2026-09-26 22:30:00','FAILED',NULL),(30,5,5,1,'WITHDRAWAL',5000.00,'2026-09-26 22:35:00','FAILED',NULL),(31,5,5,1,'WITHDRAWAL',5000.00,'2026-09-26 22:40:00','FAILED',NULL),(32,1,1,1,'WITHDRAWAL',20000.00,'2026-09-27 10:00:00','SUCCESS',NULL),(33,1,1,1,'WITHDRAWAL',35000.00,'2026-09-27 15:00:00','SUCCESS',NULL),(34,3,3,1,'WITHDRAWAL',5000.00,'2026-09-27 02:30:00','SUCCESS',NULL),(36,1,1,1,'WITHDRAWAL',40000.00,'2026-09-26 22:40:42','SUCCESS',NULL),(37,1,1,2,'WITHDRAWAL',5000.00,'2026-09-26 22:42:25','SUCCESS',NULL);
/*!40000 ALTER TABLE `atm_transaction` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_large_withdrawal` AFTER INSERT ON `atm_transaction` FOR EACH ROW BEGIN

    DECLARE v_daily_limit DECIMAL(12,2);

    SELECT daily_limit
    INTO v_daily_limit
    FROM account
    WHERE account_id = NEW.account_id;

    IF NEW.transaction_type = 'WITHDRAWAL'
       AND NEW.transaction_status = 'SUCCESS'
       AND NEW.amount >= v_daily_limit * 0.50
    THEN

        INSERT INTO fraud_alert
        (
            transaction_id,
            account_id,
            alert_type,
            severity,
            description
        )
        VALUES
        (
            NEW.transaction_id,
            NEW.account_id,
            'LARGE WITHDRAWAL',
            'HIGH',
            CONCAT(
                'Automatic alert: withdrawal of ₹',
                NEW.amount,
                ' detected.'
            )
        );

    END IF;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_rapid_transactions` AFTER INSERT ON `atm_transaction` FOR EACH ROW BEGIN
    DECLARE previous_transaction_time DATETIME;
    DECLARE previous_atm_id INT;

    SELECT transaction_time, atm_id
    INTO previous_transaction_time, previous_atm_id
    FROM atm_transaction
    WHERE account_id = NEW.account_id
      AND transaction_id < NEW.transaction_id
    ORDER BY transaction_id DESC
    LIMIT 1;

    IF previous_transaction_time IS NOT NULL
       AND previous_atm_id <> NEW.atm_id
       AND TIMESTAMPDIFF(MINUTE, previous_transaction_time, NEW.transaction_time) <= 60
    THEN

        INSERT INTO fraud_alert
        (
            account_id,
            transaction_id,
            alert_type,
            severity,
            description,
            alert_status,
            detected_at
        )
        VALUES
        (
            NEW.account_id,
            NEW.transaction_id,
            'RAPID TRANSACTION',
            'HIGH',
            'Transactions detected at different ATMs within 60 minutes',
            'OPEN',
            NOW()
        );

    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_failed_transactions` AFTER INSERT ON `atm_transaction` FOR EACH ROW BEGIN
    DECLARE failed_count INT;

    IF NEW.transaction_status = 'FAILED' THEN

        SELECT COUNT(*)
        INTO failed_count
        FROM atm_transaction
        WHERE account_id = NEW.account_id
          AND transaction_status = 'FAILED'
          AND transaction_time >= DATE_SUB(NEW.transaction_time, INTERVAL 30 MINUTE);

        IF failed_count >= 3 THEN

            INSERT INTO fraud_alert
            (
                account_id,
                transaction_id,
                alert_type,
                severity,
                description,
                alert_status,
                detected_at
            )
            VALUES
            (
                NEW.account_id,
                NEW.transaction_id,
                'MULTIPLE FAILED ATTEMPTS',
                'HIGH',
                'Three or more failed transactions detected within 30 minutes',
                'OPEN',
                NOW()
            );

        END IF;

    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_daily_withdrawal_limit` AFTER INSERT ON `atm_transaction` FOR EACH ROW BEGIN
    DECLARE daily_limit_amount DECIMAL(12,2);
    DECLARE total_withdrawal DECIMAL(12,2);

    IF NEW.transaction_type = 'WITHDRAWAL'
       AND NEW.transaction_status = 'SUCCESS' THEN

        SELECT daily_limit
        INTO daily_limit_amount
        FROM account
        WHERE account_id = NEW.account_id;

        SELECT COALESCE(SUM(amount), 0)
        INTO total_withdrawal
        FROM atm_transaction
        WHERE account_id = NEW.account_id
          AND transaction_type = 'WITHDRAWAL'
          AND transaction_status = 'SUCCESS'
          AND DATE(transaction_time) = DATE(NEW.transaction_time);

        IF total_withdrawal > daily_limit_amount
           AND NOT EXISTS
           (
               SELECT 1
               FROM fraud_alert
               WHERE account_id = NEW.account_id
                 AND alert_type = 'DAILY LIMIT EXCEEDED'
                 AND DATE(detected_at) = DATE(NEW.transaction_time)
           )
        THEN

            INSERT INTO fraud_alert
            (
                account_id,
                transaction_id,
                alert_type,
                severity,
                description,
                alert_status,
                detected_at
            )
            VALUES
            (
                NEW.account_id,
                NEW.transaction_id,
                'DAILY LIMIT EXCEEDED',
                'HIGH',
                'Total successful withdrawals exceeded the account daily withdrawal limit',
                'OPEN',
                NOW()
            );

        END IF;

    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_late_night_withdrawal` AFTER INSERT ON `atm_transaction` FOR EACH ROW BEGIN

    IF NEW.transaction_type = 'WITHDRAWAL'
       AND NEW.transaction_status = 'SUCCESS'
       AND (
            TIME(NEW.transaction_time) >= '00:00:00'
            AND TIME(NEW.transaction_time) < '05:00:00'
       )
    THEN

        INSERT INTO fraud_alert
        (
            account_id,
            transaction_id,
            alert_type,
            severity,
            description,
            alert_status,
            detected_at
        )
        VALUES
        (
            NEW.account_id,
            NEW.transaction_id,
            'LATE NIGHT WITHDRAWAL',
            'MEDIUM',
            'Successful withdrawal detected during late-night hours',
            'OPEN',
            NOW()
        );

    END IF;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_failed_attempts` AFTER INSERT ON `atm_transaction` FOR EACH ROW BEGIN

    DECLARE failed_count INT;

    SELECT COUNT(*)
    INTO failed_count
    FROM atm_transaction
    WHERE account_id = NEW.account_id
      AND transaction_status = 'FAILED';

    IF NEW.transaction_status = 'FAILED'
       AND failed_count >= 3
    THEN

        INSERT INTO fraud_alert
        (
            account_id,
            transaction_id,
            alert_type,
            severity,
            description,
            alert_status,
            detected_at
        )
        VALUES
        (
            NEW.account_id,
            NEW.transaction_id,
            'MULTIPLE FAILED ATTEMPTS',
            'HIGH',
            CONCAT(
                'Three or more failed transactions detected within the account. Total failed attempts: ',
                failed_count
            ),
            'OPEN',
            NOW()
        );

    END IF;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_repeated_amount` AFTER INSERT ON `atm_transaction` FOR EACH ROW BEGIN

    DECLARE same_amount_count INT;

    SELECT COUNT(*)
    INTO same_amount_count
    FROM atm_transaction
    WHERE account_id = NEW.account_id
      AND transaction_type = 'WITHDRAWAL'
      AND amount = NEW.amount
      AND transaction_id <> NEW.transaction_id;

    IF NEW.transaction_type = 'WITHDRAWAL'
       AND same_amount_count >= 2
    THEN

        INSERT INTO fraud_alert
        (
            account_id,
            transaction_id,
            alert_type,
            severity,
            description,
            alert_status,
            detected_at
        )
        VALUES
        (
            NEW.account_id,
            NEW.transaction_id,
            'REPEATED WITHDRAWAL AMOUNT',
            'MEDIUM',
            CONCAT(
                'Repeated withdrawal amount detected: ₹',
                NEW.amount,
                '. Previous occurrences: ',
                same_amount_count
            ),
            'OPEN',
            NOW()
        );

    END IF;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_high_frequency_transactions` AFTER INSERT ON `atm_transaction` FOR EACH ROW BEGIN

    DECLARE transaction_count INT;

    SELECT COUNT(*)
    INTO transaction_count
    FROM atm_transaction
    WHERE account_id = NEW.account_id
      AND transaction_status = 'SUCCESS'
      AND transaction_time >= DATE_SUB(
          NEW.transaction_time,
          INTERVAL 5 MINUTE
      )
      AND transaction_id <> NEW.transaction_id;

    IF NEW.transaction_status = 'SUCCESS'
       AND transaction_count >= 2
    THEN

        INSERT INTO fraud_alert
        (
            account_id,
            transaction_id,
            alert_type,
            severity,
            description,
            alert_status,
            detected_at
        )
        VALUES
        (
            NEW.account_id,
            NEW.transaction_id,
            'HIGH FREQUENCY TRANSACTIONS',
            'HIGH',
            CONCAT(
                'Three or more successful transactions detected within 5 minutes. Previous transactions: ',
                transaction_count
            ),
            'OPEN',
            NOW()
        );

    END IF;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_new_atm_usage` AFTER INSERT ON `atm_transaction` FOR EACH ROW BEGIN

    DECLARE previous_usage INT;

    SELECT COUNT(*)
    INTO previous_usage
    FROM atm_transaction
    WHERE account_id = NEW.account_id
      AND atm_id = NEW.atm_id
      AND transaction_id <> NEW.transaction_id;

    IF previous_usage = 0
    THEN

        INSERT INTO fraud_alert
        (
            account_id,
            transaction_id,
            alert_type,
            severity,
            description,
            alert_status,
            detected_at
        )
        VALUES
        (
            NEW.account_id,
            NEW.transaction_id,
            'NEW ATM USAGE',
            'MEDIUM',
            CONCAT(
                'Account used a previously unused ATM. ATM ID: ',
                NEW.atm_id
            ),
            'OPEN',
            NOW()
        );

    END IF;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trg_atm_location_change` AFTER INSERT ON `atm_transaction` FOR EACH ROW BEGIN
    DECLARE previous_atm_id INT;
    DECLARE previous_transaction_time DATETIME;
    DECLARE previous_location VARCHAR(150);
    DECLARE current_location VARCHAR(150);

    -- Find the previous transaction of the same account
    SELECT
        atm_id,
        transaction_time
    INTO
        previous_atm_id,
        previous_transaction_time
    FROM atm_transaction
    WHERE account_id = NEW.account_id
      AND transaction_id < NEW.transaction_id
    ORDER BY transaction_id DESC
    LIMIT 1;

    -- Continue only if a previous transaction exists
    IF previous_atm_id IS NOT NULL THEN

        -- Get the two ATM locations
        SELECT atm_location
        INTO previous_location
        FROM atm
        WHERE atm_id = previous_atm_id;

        SELECT atm_location
        INTO current_location
        FROM atm
        WHERE atm_id = NEW.atm_id;

        -- Detect different ATM locations within 30 minutes
        IF previous_location <> current_location
           AND TIMESTAMPDIFF(
               MINUTE,
               previous_transaction_time,
               NEW.transaction_time
           ) BETWEEN 0 AND 30 THEN

            INSERT INTO fraud_alert
            (
                account_id,
                transaction_id,
                alert_type,
                severity,
                description,
                alert_status,
                detected_at
            )
            VALUES
            (
                NEW.account_id,
                NEW.transaction_id,
                'ATM LOCATION CHANGE',
                'HIGH',
                CONCAT(
                    'Transaction occurred at a different ATM within 30 minutes. Previous location: ',
                    previous_location,
                    ', Current location: ',
                    current_location
                ),
                'OPEN',
                NOW()
            );

        END IF;

    END IF;

END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `card`
--

DROP TABLE IF EXISTS `card`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `card` (
  `card_id` int NOT NULL AUTO_INCREMENT,
  `account_id` int NOT NULL,
  `card_number` varchar(20) NOT NULL,
  `card_type` enum('DEBIT','CREDIT') NOT NULL,
  `issue_date` date NOT NULL,
  `expiry_date` date NOT NULL,
  `card_status` enum('ACTIVE','BLOCKED','EXPIRED') DEFAULT 'ACTIVE',
  PRIMARY KEY (`card_id`),
  UNIQUE KEY `card_number` (`card_number`),
  KEY `fk_card_account` (`account_id`),
  CONSTRAINT `fk_card_account` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `card`
--

LOCK TABLES `card` WRITE;
/*!40000 ALTER TABLE `card` DISABLE KEYS */;
INSERT INTO `card` VALUES (1,1,'CARD10001','DEBIT','2025-01-10','2030-01-10','ACTIVE'),(2,2,'CARD10002','DEBIT','2025-02-15','2030-02-15','ACTIVE'),(3,3,'CARD10003','DEBIT','2025-03-20','2030-03-20','ACTIVE'),(4,4,'CARD10004','DEBIT','2025-04-05','2030-04-05','ACTIVE'),(5,5,'CARD10005','DEBIT','2025-05-12','2030-05-12','ACTIVE'),(6,6,'CARD10006','DEBIT','2025-06-18','2030-06-18','ACTIVE'),(7,7,'CARD10007','DEBIT','2025-07-22','2030-07-22','ACTIVE'),(8,8,'CARD10008','DEBIT','2025-08-10','2030-08-10','ACTIVE'),(9,9,'CARD10009','DEBIT','2025-09-14','2030-09-14','ACTIVE'),(10,10,'CARD10010','DEBIT','2025-10-01','2030-10-01','ACTIVE');
/*!40000 ALTER TABLE `card` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `customer_id` int NOT NULL AUTO_INCREMENT,
  `customer_name` varchar(100) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`customer_id`),
  UNIQUE KEY `phone` (`phone`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES (1,'Hruday reddy','9000000001','rahul@example.com','Bangalore','2026-09-26 21:05:41'),(2,'Sai Sreehas','9000000002','arjun@example.com','Hyderabad','2026-09-26 21:05:41'),(3,'Nidharshan','9000000003','priya@example.com','Chennai','2026-09-26 21:05:41'),(4,'Manohar Reddy','9000000004','kiran@example.com','Bangalore','2026-09-26 21:05:41'),(5,'Mahathi Reddy','9000000005','sneha@example.com','Tirupati','2026-09-26 21:05:41'),(6,'Anisha','9000000006','vijay@example.com','Hyderabad','2026-09-26 21:05:41'),(7,'Srujana','9000000007','anjali@example.com','Chennai','2026-09-26 21:05:41'),(8,'Adinarayana Reddy','9000000008','rohit@example.com','Mumbai','2026-09-26 21:05:41'),(9,'Chandra kala','9000000009','neha@example.com','Delhi','2026-09-26 21:05:41'),(10,'Sadasiva Reddy','9000000010','suresh@example.com','Bangalore','2026-09-26 21:05:41');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `final_dashboard_summary`
--

DROP TABLE IF EXISTS `final_dashboard_summary`;
/*!50001 DROP VIEW IF EXISTS `final_dashboard_summary`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `final_dashboard_summary` AS SELECT 
 1 AS `total_transactions`,
 1 AS `total_fraud_alerts`,
 1 AS `high_alerts`,
 1 AS `medium_alerts`,
 1 AS `open_alerts`,
 1 AS `affected_accounts`,
 1 AS `critical_accounts`,
 1 AS `high_risk_accounts`,
 1 AS `medium_risk_accounts`,
 1 AS `low_risk_accounts`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `fraud_alert`
--

DROP TABLE IF EXISTS `fraud_alert`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fraud_alert` (
  `alert_id` bigint NOT NULL AUTO_INCREMENT,
  `transaction_id` bigint DEFAULT NULL,
  `account_id` int NOT NULL,
  `alert_type` varchar(100) NOT NULL,
  `severity` enum('LOW','MEDIUM','HIGH','CRITICAL') NOT NULL,
  `description` varchar(500) DEFAULT NULL,
  `detected_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `alert_status` enum('OPEN','INVESTIGATING','RESOLVED','FALSE_POSITIVE') DEFAULT 'OPEN',
  PRIMARY KEY (`alert_id`),
  KEY `fk_alert_transaction` (`transaction_id`),
  KEY `fk_alert_account` (`account_id`),
  CONSTRAINT `fk_alert_account` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`),
  CONSTRAINT `fk_alert_transaction` FOREIGN KEY (`transaction_id`) REFERENCES `atm_transaction` (`transaction_id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `fraud_alert`
--

LOCK TABLES `fraud_alert` WRITE;
/*!40000 ALTER TABLE `fraud_alert` DISABLE KEYS */;
INSERT INTO `fraud_alert` VALUES (1,15,2,'MULTIPLE FAILED ATTEMPTS','HIGH','Account recorded 4 failed transactions.','2026-09-26 21:33:27','OPEN'),(2,11,1,'LATE NIGHT WITHDRAWAL','MEDIUM','Successful withdrawal of ₹30000.00 occurred at 02:15:00.','2026-09-26 21:33:49','OPEN'),(3,17,3,'DAILY LIMIT EXCEEDED','HIGH','Daily withdrawal total of ₹110000.00 exceeded the limit of ₹100000.00.','2026-09-26 21:34:02','OPEN'),(4,13,2,'RAPID TRANSACTIONS','MEDIUM','Multiple transactions detected within a short time period.','2026-09-26 21:34:57','OPEN'),(5,14,2,'RAPID TRANSACTIONS','MEDIUM','Multiple transactions detected within a short time period.','2026-09-26 21:34:57','OPEN'),(6,15,2,'RAPID TRANSACTIONS','MEDIUM','Multiple transactions detected within a short time period.','2026-09-26 21:34:57','OPEN'),(7,19,4,'RAPID TRANSACTIONS','MEDIUM','Multiple transactions detected within a short time period.','2026-09-26 21:34:57','OPEN'),(8,20,4,'RAPID TRANSACTIONS','MEDIUM','Multiple transactions detected within a short time period.','2026-09-26 21:34:57','OPEN'),(11,11,1,'LARGE WITHDRAWAL','HIGH','Withdrawal of ₹30000.00 is unusually large compared with the daily limit.','2026-09-26 21:35:22','OPEN'),(12,16,3,'LARGE WITHDRAWAL','HIGH','Withdrawal of ₹60000.00 is unusually large compared with the daily limit.','2026-09-26 21:35:22','OPEN'),(13,17,3,'LARGE WITHDRAWAL','HIGH','Withdrawal of ₹50000.00 is unusually large compared with the daily limit.','2026-09-26 21:35:22','OPEN'),(14,23,6,'LARGE WITHDRAWAL','HIGH','Withdrawal of ₹65000.00 is unusually large compared with the daily limit.','2026-09-26 21:35:22','OPEN'),(18,22,5,'ATM LOCATION CHANGE','HIGH','Transaction occurred at a different ATM within 60 minutes.','2026-09-26 21:35:48','OPEN'),(19,24,1,'LARGE WITHDRAWAL','HIGH','Automatic alert: withdrawal of ₹30000.00 detected.','2026-09-26 21:47:07','OPEN'),(20,28,5,'RAPID TRANSACTION','HIGH','Transactions detected at different ATMs within 60 minutes','2026-09-26 22:00:57','OPEN'),(21,29,5,'RAPID TRANSACTION','HIGH','Transactions detected at different ATMs within 60 minutes','2026-09-26 22:03:40','OPEN'),(22,31,5,'MULTIPLE FAILED ATTEMPTS','HIGH','Three or more failed transactions detected within 30 minutes','2026-09-26 22:03:40','OPEN'),(23,33,1,'LARGE WITHDRAWAL','HIGH','Automatic alert: withdrawal of ₹35000.00 detected.','2026-09-26 22:06:10','OPEN'),(24,33,1,'DAILY LIMIT EXCEEDED','HIGH','Total successful withdrawals exceeded the account daily withdrawal limit','2026-09-26 22:06:10','OPEN'),(25,34,3,'LATE NIGHT WITHDRAWAL','MEDIUM','Successful withdrawal detected during late-night hours','2026-09-26 22:07:48','OPEN'),(27,36,1,'LARGE WITHDRAWAL','HIGH','Automatic alert: withdrawal of ₹40000.00 detected.','2026-09-26 22:40:42','OPEN'),(28,36,1,'HIGH FREQUENCY TRANSACTIONS','HIGH','Three or more successful transactions detected within 5 minutes. Previous transactions: 2','2026-09-26 22:40:42','OPEN'),(29,37,1,'RAPID TRANSACTION','HIGH','Transactions detected at different ATMs within 60 minutes','2026-09-26 22:42:25','OPEN'),(30,37,1,'REPEATED WITHDRAWAL AMOUNT','MEDIUM','Repeated withdrawal amount detected: ₹5000.00. Previous occurrences: 3','2026-09-26 22:42:25','OPEN'),(31,37,1,'HIGH FREQUENCY TRANSACTIONS','HIGH','Three or more successful transactions detected within 5 minutes. Previous transactions: 3','2026-09-26 22:42:25','OPEN'),(32,37,1,'NEW ATM USAGE','MEDIUM','Account used a previously unused ATM. ATM ID: 2','2026-09-26 22:42:25','OPEN'),(33,37,1,'ATM LOCATION CHANGE','HIGH','Transaction occurred at a different ATM within 30 minutes. Previous location: MG Road ATM, Current location: Electronic City ATM','2026-09-26 22:42:25','OPEN');
/*!40000 ALTER TABLE `fraud_alert` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `fraud_dashboard_summary`
--

DROP TABLE IF EXISTS `fraud_dashboard_summary`;
/*!50001 DROP VIEW IF EXISTS `fraud_dashboard_summary`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `fraud_dashboard_summary` AS SELECT 
 1 AS `total_alerts`,
 1 AS `affected_accounts`,
 1 AS `high_alerts`,
 1 AS `medium_alerts`,
 1 AS `open_alerts`,
 1 AS `closed_alerts`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `fraud_monitoring_view`
--

DROP TABLE IF EXISTS `fraud_monitoring_view`;
/*!50001 DROP VIEW IF EXISTS `fraud_monitoring_view`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `fraud_monitoring_view` AS SELECT 
 1 AS `alert_id`,
 1 AS `account_id`,
 1 AS `transaction_id`,
 1 AS `account_number`,
 1 AS `atm_id`,
 1 AS `card_id`,
 1 AS `transaction_type`,
 1 AS `amount`,
 1 AS `transaction_status`,
 1 AS `transaction_time`,
 1 AS `alert_type`,
 1 AS `severity`,
 1 AS `description`,
 1 AS `alert_status`,
 1 AS `detected_at`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `fraud_risk_dashboard`
--

DROP TABLE IF EXISTS `fraud_risk_dashboard`;
/*!50001 DROP VIEW IF EXISTS `fraud_risk_dashboard`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `fraud_risk_dashboard` AS SELECT 
 1 AS `account_id`,
 1 AS `account_number`,
 1 AS `daily_limit`,
 1 AS `transaction_id`,
 1 AS `atm_id`,
 1 AS `card_id`,
 1 AS `transaction_type`,
 1 AS `amount`,
 1 AS `transaction_status`,
 1 AS `transaction_time`,
 1 AS `alert_id`,
 1 AS `alert_type`,
 1 AS `severity`,
 1 AS `description`,
 1 AS `alert_status`,
 1 AS `detected_at`,
 1 AS `total_alerts`,
 1 AS `high_alerts`,
 1 AS `medium_alerts`,
 1 AS `open_alerts`,
 1 AS `risk_score`,
 1 AS `risk_level`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `transaction_audit`
--

DROP TABLE IF EXISTS `transaction_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transaction_audit` (
  `audit_id` bigint NOT NULL AUTO_INCREMENT,
  `transaction_id` bigint NOT NULL,
  `action_type` varchar(50) NOT NULL,
  `old_status` varchar(30) DEFAULT NULL,
  `new_status` varchar(30) DEFAULT NULL,
  `action_time` datetime DEFAULT CURRENT_TIMESTAMP,
  `description` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`audit_id`),
  KEY `fk_audit_transaction` (`transaction_id`),
  CONSTRAINT `fk_audit_transaction` FOREIGN KEY (`transaction_id`) REFERENCES `atm_transaction` (`transaction_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transaction_audit`
--

LOCK TABLES `transaction_audit` WRITE;
/*!40000 ALTER TABLE `transaction_audit` DISABLE KEYS */;
/*!40000 ALTER TABLE `transaction_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'atm_fraud_analysis'
--

--
-- Dumping routines for database 'atm_fraud_analysis'
--
/*!50003 DROP PROCEDURE IF EXISTS `fraud_report_by_date` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `fraud_report_by_date`(
    IN p_start_date DATE,
    IN p_end_date DATE
)
BEGIN

    SELECT
        alert_id,
        account_number,
        customer_name,
        transaction_id,
        amount,
        alert_type,
        severity,
        description,
        detected_at
    FROM fraud_monitoring_view
    WHERE DATE(detected_at)
          BETWEEN p_start_date AND p_end_date
    ORDER BY detected_at;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `fraud_summary_report` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `fraud_summary_report`()
BEGIN

    SELECT
        COUNT(*) AS total_alerts,

        SUM(
            CASE
                WHEN severity = 'HIGH' THEN 1
                ELSE 0
            END
        ) AS high_alerts,

        SUM(
            CASE
                WHEN severity = 'MEDIUM' THEN 1
                ELSE 0
            END
        ) AS medium_alerts,

        SUM(
            CASE
                WHEN severity = 'LOW' THEN 1
                ELSE 0
            END
        ) AS low_alerts

    FROM fraud_alert;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_account_fraud_report` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_account_fraud_report`(
    IN p_account_id INT
)
BEGIN

    SELECT
        alert_id,
        account_number,
        customer_name,
        transaction_id,
        transaction_type,
        amount,
        transaction_status,
        transaction_time,
        atm_location,
        city,
        alert_type,
        severity,
        description,
        alert_status,
        detected_at
    FROM fraud_monitoring_view
    WHERE account_number = (
        SELECT account_number
        FROM account
        WHERE account_id = p_account_id
    )
    ORDER BY detected_at DESC;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_get_account_alerts` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_account_alerts`(IN p_account_id INT)
BEGIN

    SELECT
        alert_id,
        account_id,
        transaction_id,
        alert_type,
        severity,
        description,
        alert_status,
        detected_at
    FROM fraud_alert
    WHERE account_id = p_account_id
    ORDER BY detected_at DESC;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_get_account_fraud_summary` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_account_fraud_summary`(IN p_account_id INT)
BEGIN

    SELECT
        account_id,
        COUNT(*) AS total_alerts,

        SUM(
            CASE
                WHEN severity = 'HIGH' THEN 1
                ELSE 0
            END
        ) AS high_alerts,

        SUM(
            CASE
                WHEN severity = 'MEDIUM' THEN 1
                ELSE 0
            END
        ) AS medium_alerts,

        SUM(
            CASE
                WHEN alert_status = 'OPEN' THEN 1
                ELSE 0
            END
        ) AS open_alerts,

        (
            SUM(
                CASE
                    WHEN severity = 'HIGH' THEN 10
                    WHEN severity = 'MEDIUM' THEN 5
                    ELSE 0
                END
            )
        ) AS risk_score,

        CASE
            WHEN SUM(
                CASE
                    WHEN severity = 'HIGH' THEN 10
                    WHEN severity = 'MEDIUM' THEN 5
                    ELSE 0
                END
            ) >= 80 THEN 'CRITICAL'

            WHEN SUM(
                CASE
                    WHEN severity = 'HIGH' THEN 10
                    WHEN severity = 'MEDIUM' THEN 5
                    ELSE 0
                END
            ) >= 40 THEN 'HIGH'

            WHEN SUM(
                CASE
                    WHEN severity = 'HIGH' THEN 10
                    WHEN severity = 'MEDIUM' THEN 5
                    ELSE 0
                END
            ) >= 20 THEN 'MEDIUM'

            ELSE 'LOW'
        END AS risk_level

    FROM fraud_alert
    WHERE account_id = p_account_id
    GROUP BY account_id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_get_account_risk` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_account_risk`(IN p_account_id INT)
BEGIN

    SELECT
        account_id,
        total_alerts,
        risk_score,
        high_alerts,
        medium_alerts,
        open_alerts,
        risk_level
    FROM account_risk_analysis
    WHERE account_id = p_account_id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_get_account_risk_details` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_account_risk_details`(IN p_account_id INT)
BEGIN

    SELECT
        a.account_id,
        a.account_number,
        a.daily_limit,
        r.total_alerts,
        r.risk_score,
        r.high_alerts,
        r.medium_alerts,
        r.open_alerts,
        r.risk_level

    FROM account a

    INNER JOIN account_risk_analysis r
        ON a.account_id = r.account_id

    WHERE a.account_id = p_account_id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_get_account_transactions` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_account_transactions`(IN p_account_id INT)
BEGIN

    SELECT
        transaction_id,
        account_id,
        atm_id,
        card_id,
        transaction_type,
        amount,
        transaction_status,
        transaction_time
    FROM atm_transaction
    WHERE account_id = p_account_id
    ORDER BY transaction_time DESC;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_get_all_risk_accounts` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_all_risk_accounts`()
BEGIN

    SELECT
        r.account_id,
        a.account_number,
        a.daily_limit,
        r.total_alerts,
        r.risk_score,
        r.high_alerts,
        r.medium_alerts,
        r.open_alerts,
        r.risk_level

    FROM account_risk_analysis r

    JOIN account a
        ON a.account_id = r.account_id

    ORDER BY r.risk_score DESC;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_get_critical_accounts` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_critical_accounts`()
BEGIN

    SELECT
        r.account_id,
        a.account_number,
        a.daily_limit,
        r.total_alerts,
        r.risk_score,
        r.high_alerts,
        r.medium_alerts,
        r.open_alerts,
        r.risk_level

    FROM account_risk_analysis r

    JOIN account a
        ON a.account_id = r.account_id

    WHERE r.risk_level = 'CRITICAL'

    ORDER BY r.risk_score DESC;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_get_critical_risk_accounts` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_critical_risk_accounts`()
BEGIN

    SELECT
        r.account_id,
        a.account_number,
        a.daily_limit,
        r.total_alerts,
        r.risk_score,
        r.high_alerts,
        r.medium_alerts,
        r.open_alerts,
        r.risk_level

    FROM account_risk_analysis r

    JOIN account a
        ON a.account_id = r.account_id

    WHERE r.risk_level = 'CRITICAL'

    ORDER BY r.risk_score DESC;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_get_high_risk_accounts` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_high_risk_accounts`()
BEGIN

    SELECT
        r.account_id,
        a.account_number,
        a.daily_limit,
        r.total_alerts,
        r.risk_score,
        r.high_alerts,
        r.medium_alerts,
        r.open_alerts,
        r.risk_level

    FROM account_risk_analysis r

    JOIN account a
        ON a.account_id = r.account_id

    WHERE r.risk_level = 'HIGH'

    ORDER BY r.risk_score DESC;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_get_high_severity_alerts` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_high_severity_alerts`()
BEGIN

    SELECT
        alert_id,
        account_id,
        transaction_id,
        alert_type,
        severity,
        description,
        alert_status,
        detected_at

    FROM fraud_alert

    WHERE severity = 'HIGH'

    ORDER BY detected_at DESC;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_get_low_risk_accounts` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_low_risk_accounts`()
BEGIN

    SELECT
        r.account_id,
        a.account_number,
        a.daily_limit,
        r.total_alerts,
        r.risk_score,
        r.high_alerts,
        r.medium_alerts,
        r.open_alerts,
        r.risk_level

    FROM account_risk_analysis r

    JOIN account a
        ON a.account_id = r.account_id

    WHERE r.risk_level = 'LOW'

    ORDER BY r.risk_score DESC;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_get_medium_risk_accounts` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_medium_risk_accounts`()
BEGIN

    SELECT
        r.account_id,
        a.account_number,
        a.daily_limit,
        r.total_alerts,
        r.risk_score,
        r.high_alerts,
        r.medium_alerts,
        r.open_alerts,
        r.risk_level

    FROM account_risk_analysis r

    JOIN account a
        ON a.account_id = r.account_id

    WHERE r.risk_level = 'MEDIUM'

    ORDER BY r.risk_score DESC;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_get_medium_severity_alerts` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_medium_severity_alerts`()
BEGIN

    SELECT
        alert_id,
        account_id,
        transaction_id,
        alert_type,
        severity,
        description,
        alert_status,
        detected_at

    FROM fraud_alert

    WHERE severity = 'MEDIUM'

    ORDER BY detected_at DESC;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_get_open_alerts` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_open_alerts`()
BEGIN

    SELECT
        alert_id,
        account_id,
        transaction_id,
        alert_type,
        severity,
        description,
        alert_status,
        detected_at

    FROM fraud_alert

    WHERE alert_status = 'OPEN'

    ORDER BY detected_at DESC;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_get_recent_alerts` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_recent_alerts`(IN p_limit INT)
BEGIN

    SELECT
        alert_id,
        account_id,
        transaction_id,
        alert_type,
        severity,
        description,
        alert_status,
        detected_at

    FROM fraud_alert

    ORDER BY detected_at DESC

    LIMIT p_limit;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `sp_get_recent_fraud` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_get_recent_fraud`(IN p_limit INT)
BEGIN

    SELECT
        f.alert_id,
        f.account_id,
        f.transaction_id,
        f.alert_type,
        f.severity,
        f.alert_status,
        f.detected_at,
        t.atm_id,
        t.card_id,
        t.transaction_type,
        t.amount,
        t.transaction_status,
        t.transaction_time
    FROM fraud_alert f
    JOIN atm_transaction t
        ON f.transaction_id = t.transaction_id
    ORDER BY f.detected_at DESC
    LIMIT p_limit;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `account_risk_analysis`
--

/*!50001 DROP VIEW IF EXISTS `account_risk_analysis`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `account_risk_analysis` AS select `fraud_alert`.`account_id` AS `account_id`,count(0) AS `total_alerts`,sum((case when (`fraud_alert`.`severity` = 'HIGH') then 10 when (`fraud_alert`.`severity` = 'MEDIUM') then 5 else 0 end)) AS `risk_score`,sum((case when (`fraud_alert`.`severity` = 'HIGH') then 1 else 0 end)) AS `high_alerts`,sum((case when (`fraud_alert`.`severity` = 'MEDIUM') then 1 else 0 end)) AS `medium_alerts`,sum((case when (`fraud_alert`.`alert_status` = 'OPEN') then 1 else 0 end)) AS `open_alerts`,(case when (sum((case when (`fraud_alert`.`severity` = 'HIGH') then 10 when (`fraud_alert`.`severity` = 'MEDIUM') then 5 else 0 end)) >= 50) then 'CRITICAL' when (sum((case when (`fraud_alert`.`severity` = 'HIGH') then 10 when (`fraud_alert`.`severity` = 'MEDIUM') then 5 else 0 end)) >= 30) then 'HIGH' when (sum((case when (`fraud_alert`.`severity` = 'HIGH') then 10 when (`fraud_alert`.`severity` = 'MEDIUM') then 5 else 0 end)) >= 15) then 'MEDIUM' else 'LOW' end) AS `risk_level` from `fraud_alert` group by `fraud_alert`.`account_id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `final_dashboard_summary`
--

/*!50001 DROP VIEW IF EXISTS `final_dashboard_summary`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `final_dashboard_summary` AS select (select count(0) from `atm_transaction`) AS `total_transactions`,(select count(0) from `fraud_alert`) AS `total_fraud_alerts`,(select count(0) from `fraud_alert` where (`fraud_alert`.`severity` = 'HIGH')) AS `high_alerts`,(select count(0) from `fraud_alert` where (`fraud_alert`.`severity` = 'MEDIUM')) AS `medium_alerts`,(select count(0) from `fraud_alert` where (`fraud_alert`.`alert_status` = 'OPEN')) AS `open_alerts`,(select count(distinct `fraud_alert`.`account_id`) from `fraud_alert`) AS `affected_accounts`,(select count(0) from `account_risk_analysis` where (`account_risk_analysis`.`risk_level` = 'CRITICAL')) AS `critical_accounts`,(select count(0) from `account_risk_analysis` where (`account_risk_analysis`.`risk_level` = 'HIGH')) AS `high_risk_accounts`,(select count(0) from `account_risk_analysis` where (`account_risk_analysis`.`risk_level` = 'MEDIUM')) AS `medium_risk_accounts`,(select count(0) from `account_risk_analysis` where (`account_risk_analysis`.`risk_level` = 'LOW')) AS `low_risk_accounts` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `fraud_dashboard_summary`
--

/*!50001 DROP VIEW IF EXISTS `fraud_dashboard_summary`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `fraud_dashboard_summary` AS select count(0) AS `total_alerts`,count(distinct `fraud_alert`.`account_id`) AS `affected_accounts`,sum((case when (`fraud_alert`.`severity` = 'HIGH') then 1 else 0 end)) AS `high_alerts`,sum((case when (`fraud_alert`.`severity` = 'MEDIUM') then 1 else 0 end)) AS `medium_alerts`,sum((case when (`fraud_alert`.`alert_status` = 'OPEN') then 1 else 0 end)) AS `open_alerts`,sum((case when (`fraud_alert`.`alert_status` = 'CLOSED') then 1 else 0 end)) AS `closed_alerts` from `fraud_alert` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `fraud_monitoring_view`
--

/*!50001 DROP VIEW IF EXISTS `fraud_monitoring_view`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `fraud_monitoring_view` AS select `f`.`alert_id` AS `alert_id`,`f`.`account_id` AS `account_id`,`f`.`transaction_id` AS `transaction_id`,`a`.`account_number` AS `account_number`,`t`.`atm_id` AS `atm_id`,`t`.`card_id` AS `card_id`,`t`.`transaction_type` AS `transaction_type`,`t`.`amount` AS `amount`,`t`.`transaction_status` AS `transaction_status`,`t`.`transaction_time` AS `transaction_time`,`f`.`alert_type` AS `alert_type`,`f`.`severity` AS `severity`,`f`.`description` AS `description`,`f`.`alert_status` AS `alert_status`,`f`.`detected_at` AS `detected_at` from ((`fraud_alert` `f` join `account` `a` on((`f`.`account_id` = `a`.`account_id`))) join `atm_transaction` `t` on((`f`.`transaction_id` = `t`.`transaction_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `fraud_risk_dashboard`
--

/*!50001 DROP VIEW IF EXISTS `fraud_risk_dashboard`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `fraud_risk_dashboard` AS select `a`.`account_id` AS `account_id`,`a`.`account_number` AS `account_number`,`a`.`daily_limit` AS `daily_limit`,`t`.`transaction_id` AS `transaction_id`,`t`.`atm_id` AS `atm_id`,`t`.`card_id` AS `card_id`,`t`.`transaction_type` AS `transaction_type`,`t`.`amount` AS `amount`,`t`.`transaction_status` AS `transaction_status`,`t`.`transaction_time` AS `transaction_time`,`f`.`alert_id` AS `alert_id`,`f`.`alert_type` AS `alert_type`,`f`.`severity` AS `severity`,`f`.`description` AS `description`,`f`.`alert_status` AS `alert_status`,`f`.`detected_at` AS `detected_at`,`r`.`total_alerts` AS `total_alerts`,`r`.`high_alerts` AS `high_alerts`,`r`.`medium_alerts` AS `medium_alerts`,`r`.`open_alerts` AS `open_alerts`,`r`.`risk_score` AS `risk_score`,`r`.`risk_level` AS `risk_level` from (((`account` `a` join `atm_transaction` `t` on((`a`.`account_id` = `t`.`account_id`))) left join `fraud_alert` `f` on((`t`.`transaction_id` = `f`.`transaction_id`))) join `account_risk_analysis` `r` on((`a`.`account_id` = `r`.`account_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-09-27 10:00:01
