-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               9.0.0 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             12.7.0.6850
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for tour_update
CREATE DATABASE IF NOT EXISTS `tour_update` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `tour_update`;

-- Dumping structure for table tour_update.booking
CREATE TABLE IF NOT EXISTS `booking` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `customer_id` bigint NOT NULL,
  `tour_schedule_id` bigint NOT NULL,
  `booked_slots` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `status` enum('PAID','CONFIRMED','COMPLETED','CANCELLED') NOT NULL DEFAULT 'PAID',
  PRIMARY KEY (`id`),
  KEY `customer_id` (`customer_id`),
  KEY `tour_schedule_id` (`tour_schedule_id`),
  CONSTRAINT `booking_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `users` (`id`),
  CONSTRAINT `booking_ibfk_2` FOREIGN KEY (`tour_schedule_id`) REFERENCES `tour_schedule` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table tour_update.booking: ~0 rows (approximately)
DELETE FROM `booking`;
INSERT INTO `booking` (`id`, `customer_id`, `tour_schedule_id`, `booked_slots`, `created_at`, `updated_at`, `status`) VALUES
	(1, 2, 1, 0, '2025-05-10 10:35:22', '2025-05-10 14:02:14', 'PAID'),
	(2, 1, 2, 5, '2025-05-10 10:35:45', '2025-05-10 14:02:16', 'PAID');

-- Dumping structure for table tour_update.booking_detail
CREATE TABLE IF NOT EXISTS `booking_detail` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `booking_id` bigint NOT NULL,
  `price_per_person` decimal(10,2) NOT NULL,
  `full_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `gender` enum('NAM','NU') DEFAULT NULL COMMENT '1: Nam, 2:nữ',
  `birth_date` date DEFAULT NULL,
  `age_group_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `booking_id` (`booking_id`),
  KEY `fk_age_group` (`age_group_id`),
  CONSTRAINT `booking_detail_ibfk_1` FOREIGN KEY (`booking_id`) REFERENCES `booking` (`id`),
  CONSTRAINT `fk_age_group` FOREIGN KEY (`age_group_id`) REFERENCES `tour_price_by_age` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table tour_update.booking_detail: ~0 rows (approximately)
DELETE FROM `booking_detail`;
INSERT INTO `booking_detail` (`id`, `booking_id`, `price_per_person`, `full_name`, `gender`, `birth_date`, `age_group_id`) VALUES
	(1, 1, 10000000.00, 'Ngô Thành Đạt', 'NAM', '2025-05-10', 3),
	(2, 2, 20000000.00, 'Phi', 'NU', '2025-05-10', 1);

-- Dumping structure for table tour_update.payment
CREATE TABLE IF NOT EXISTS `payment` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `amount` decimal(20,6) NOT NULL DEFAULT (0),
  `payment_method` varchar(50) NOT NULL,
  `payment_status` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'pending',
  `payment_date` timestamp NOT NULL DEFAULT (now()),
  `booking_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_payment_booking` (`booking_id`),
  CONSTRAINT `fk_payment_booking` FOREIGN KEY (`booking_id`) REFERENCES `booking` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table tour_update.payment: ~0 rows (approximately)
DELETE FROM `payment`;
INSERT INTO `payment` (`id`, `amount`, `payment_method`, `payment_status`, `payment_date`, `booking_id`) VALUES
	(2, 1000000.000000, 'momo', 'pending', '2025-05-10 13:22:36', 1),
	(3, 200000.000000, 'tiền mặt', 'pending', '2025-05-10 13:23:46', 2);

-- Dumping structure for table tour_update.roles
CREATE TABLE IF NOT EXISTS `roles` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table tour_update.roles: ~0 rows (approximately)
DELETE FROM `roles`;
INSERT INTO `roles` (`id`, `name`, `description`) VALUES
	(1, 'user', 'Khách hàng'),
	(2, 'admin', 'Admin');

-- Dumping structure for table tour_update.tour
CREATE TABLE IF NOT EXISTS `tour` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text,
  `price` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `status` enum('ACTIVE','INACTIVE') NOT NULL DEFAULT 'ACTIVE',
  `duration` int NOT NULL DEFAULT '1',
  `depature_location` varchar(255) NOT NULL,
  `image_header` longtext NOT NULL,
  `code` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table tour_update.tour: ~0 rows (approximately)
DELETE FROM `tour`;
INSERT INTO `tour` (`id`, `name`, `description`, `price`, `created_at`, `updated_at`, `status`, `duration`, `depature_location`, `image_header`, `code`) VALUES
	(1, 'Tour 2 đảo Phú Yên: Hòn Nưa và Hòn Chùa 2 ngày 1 đêm', 'Tour 2 đảo Phú Yên: Hòn Nưa và Hòn Chùa 2 ngày 1 đêm', 1765000.00, '2025-05-10 09:08:11', '2025-05-11 01:44:50', 'ACTIVE', 1, '', '', 'T-1'),
	(2, 'Tour Phú Yên – Quy Nhơn: Khám phá xứ Nẫu 4 ngày 3 đêm', 'Tour Phú Yên – Quy Nhơn: Khám phá xứ Nẫu 4 ngày 3 đêm', 3290000.00, '2025-05-10 09:08:41', '2025-05-11 01:44:50', 'ACTIVE', 3, '', '', 'T-2');

-- Dumping structure for table tour_update.tour_discount
CREATE TABLE IF NOT EXISTS `tour_discount` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `tour_schedule_id` bigint NOT NULL,
  `discount_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `discount_value` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `min_guests` int DEFAULT NULL,
  `description` text,
  `status` enum('ACTIVE','INACTIVE') NOT NULL DEFAULT 'ACTIVE',
  PRIMARY KEY (`id`),
  KEY `tour_id` (`tour_schedule_id`) USING BTREE,
  CONSTRAINT `fk_tour_discount_schedule` FOREIGN KEY (`tour_schedule_id`) REFERENCES `tour_schedule` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table tour_update.tour_discount: ~0 rows (approximately)
DELETE FROM `tour_discount`;
INSERT INTO `tour_discount` (`id`, `tour_schedule_id`, `discount_type`, `discount_value`, `created_at`, `updated_at`, `min_guests`, `description`, `status`) VALUES
	(1, 1, NULL, 10.00, '2025-05-10 10:15:51', '2025-05-10 10:15:51', 5, NULL, 'ACTIVE'),
	(2, 2, NULL, 10.00, '2025-05-10 10:16:03', '2025-05-10 10:16:10', 5, NULL, 'ACTIVE');

-- Dumping structure for table tour_update.tour_image
CREATE TABLE IF NOT EXISTS `tour_image` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `tour_id` bigint NOT NULL,
  `image_url` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `tour_id` (`tour_id`),
  CONSTRAINT `tour_image_ibfk_1` FOREIGN KEY (`tour_id`) REFERENCES `tour` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table tour_update.tour_image: ~0 rows (approximately)
DELETE FROM `tour_image`;
INSERT INTO `tour_image` (`id`, `tour_id`, `image_url`, `created_at`) VALUES
	(1, 1, '15140c95-5ec3-45a7-8177-40ac709f6369_31714421_1952017624810918_8634264946621808640_n-1024x767.jpg', '2025-05-10 13:24:49'),
	(2, 2, '15140c95-5ec3-45a7-8177-40ac709f6369_31714421_1952017624810918_8634264946621808640_n-1024x767.jpg', '2025-05-10 13:25:05');

-- Dumping structure for table tour_update.tour_price_by_age
CREATE TABLE IF NOT EXISTS `tour_price_by_age` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `describe` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `price_rate` int NOT NULL DEFAULT (0),
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table tour_update.tour_price_by_age: ~0 rows (approximately)
DELETE FROM `tour_price_by_age`;
INSERT INTO `tour_price_by_age` (`id`, `describe`, `price_rate`, `created_at`, `updated_at`) VALUES
	(1, '< 2 tuổi', 0, '2025-05-10 10:13:11', '2025-05-10 10:32:14'),
	(2, '2-10 tuổi', 20, '2025-05-10 10:13:39', '2025-05-10 10:32:15'),
	(3, '> 10 tuổi', 0, '2025-05-10 10:14:12', '2025-05-10 10:32:16');

-- Dumping structure for table tour_update.tour_schedule
CREATE TABLE IF NOT EXISTS `tour_schedule` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `tour_id` bigint NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `total_slots` int NOT NULL,
  `available_slots` int NOT NULL,
  `booked_slots` int DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `status` enum('ACTIVE','COMPLETED') NOT NULL DEFAULT 'ACTIVE',
  PRIMARY KEY (`id`),
  KEY `tour_id` (`tour_id`),
  CONSTRAINT `tour_schedule_ibfk_1` FOREIGN KEY (`tour_id`) REFERENCES `tour` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table tour_update.tour_schedule: ~0 rows (approximately)
DELETE FROM `tour_schedule`;
INSERT INTO `tour_schedule` (`id`, `tour_id`, `start_date`, `end_date`, `total_slots`, `available_slots`, `booked_slots`, `created_at`, `updated_at`, `status`) VALUES
	(1, 1, '2025-05-10', '2025-05-11', 20, 20, 0, '2025-05-10 09:09:36', '2025-05-10 09:09:36', 'ACTIVE'),
	(2, 1, '2025-05-10', '2025-05-13', 20, 20, 0, '2025-05-10 09:09:58', '2025-05-10 09:10:01', 'ACTIVE');

-- Dumping structure for table tour_update.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `gender` enum('NAM','NU') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `status` enum('ACTIVE','INACTIVE') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `name` varchar(50) DEFAULT NULL,
  `address` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table tour_update.users: ~0 rows (approximately)
DELETE FROM `users`;
INSERT INTO `users` (`id`, `gender`, `password`, `email`, `phone`, `status`, `created_at`, `updated_at`, `name`, `address`) VALUES
	(1, '', '123', NULL, '0337782955', 'ACTIVE', '2025-05-10 10:17:48', '2025-05-10 10:33:11', NULL, NULL),
	(2, '', '123', NULL, '0984357324', 'ACTIVE', '2025-05-10 10:33:27', '2025-05-10 10:33:27', NULL, NULL);

-- Dumping structure for table tour_update.user_roles
CREATE TABLE IF NOT EXISTS `user_roles` (
  `user_id` bigint NOT NULL,
  `role_id` bigint NOT NULL,
  PRIMARY KEY (`user_id`,`role_id`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `user_roles_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `user_roles_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table tour_update.user_roles: ~0 rows (approximately)
DELETE FROM `user_roles`;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
