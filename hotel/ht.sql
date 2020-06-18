/*
SQLyog Community Edition- MySQL GUI v8.03 
MySQL - 5.6.12-log : Database - hotel
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

CREATE DATABASE /*!32312 IF NOT EXISTS*/`hotel` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `hotel`;

/*Table structure for table `bank` */

DROP TABLE IF EXISTS `bank`;

CREATE TABLE `bank` (
  `bid` int(11) NOT NULL AUTO_INCREMENT,
  `ac_no` varchar(55) DEFAULT NULL,
  `pwd` varchar(55) DEFAULT NULL,
  `amt` int(11) DEFAULT NULL,
  `login_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`bid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `bank` */

insert  into `bank`(`bid`,`ac_no`,`pwd`,`amt`,`login_id`) values (1,'aa','aa',9000,13),(2,'bb','bb',500,1);

/*Table structure for table `cart` */

DROP TABLE IF EXISTS `cart`;

CREATE TABLE `cart` (
  `cart_id` int(10) NOT NULL AUTO_INCREMENT,
  `food_id` int(10) DEFAULT NULL,
  `quantity` bigint(20) DEFAULT NULL,
  `cust_id` int(25) DEFAULT NULL,
  `fname` varchar(50) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`cart_id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Data for the table `cart` */

/*Table structure for table `category` */

DROP TABLE IF EXISTS `category`;

CREATE TABLE `category` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1892 DEFAULT CHARSET=latin1;

/*Data for the table `category` */

insert  into `category`(`category_id`,`category_name`) values (1891,'cat1');

/*Table structure for table `complaint` */

DROP TABLE IF EXISTS `complaint`;

CREATE TABLE `complaint` (
  `complaint_id` int(11) NOT NULL AUTO_INCREMENT,
  `complaints` varchar(200) DEFAULT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `reply` varchar(200) DEFAULT NULL,
  `type` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`complaint_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `complaint` */

insert  into `complaint`(`complaint_id`,`complaints`,`customer_id`,`date`,`reply`,`type`) values (1,'cnt',13,'2020-05-29','pending','admin'),(2,'fffffgg',13,'2020-05-29','pending','transport'),(3,'bbbbbb',13,'2020-05-29','pending','manager');

/*Table structure for table `customer` */

DROP TABLE IF EXISTS `customer`;

CREATE TABLE `customer` (
  `customer_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_name` varchar(30) DEFAULT NULL,
  `dob` varchar(55) DEFAULT NULL,
  `gender` varchar(30) DEFAULT NULL,
  `phone` bigint(20) DEFAULT NULL,
  `email` varchar(30) DEFAULT NULL,
  `login_id` int(11) DEFAULT NULL,
  `place` varchar(30) DEFAULT NULL,
  `landmark` varchar(30) DEFAULT NULL,
  `post` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`customer_id`),
  UNIQUE KEY `customer_id` (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `customer` */

insert  into `customer`(`customer_id`,`customer_name`,`dob`,`gender`,`phone`,`email`,`login_id`,`place`,`landmark`,`post`) values (1,'mridul','0000-00-00','Male',9632145698,'riss.staff@gmail.com',13,'pkc','lan','pos');

/*Table structure for table `delay_message` */

DROP TABLE IF EXISTS `delay_message`;

CREATE TABLE `delay_message` (
  `delay_message_id` int(11) NOT NULL AUTO_INCREMENT,
  `order_master_id` int(11) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `message` varchar(100) DEFAULT NULL,
  `status` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`delay_message_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `delay_message` */

/*Table structure for table `feedbacks` */

DROP TABLE IF EXISTS `feedbacks`;

CREATE TABLE `feedbacks` (
  `feedback_id` int(11) NOT NULL AUTO_INCREMENT,
  `feedbacks` varchar(100) DEFAULT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `type` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`feedback_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `feedbacks` */

insert  into `feedbacks`(`feedback_id`,`feedbacks`,`customer_id`,`date`,`type`) values (1,'ffffff',13,'2020-05-29','admin'),(2,'nnnn',13,'2020-05-29','transport'),(3,'rtgfc',13,'2020-05-29','manager');

/*Table structure for table `food_items` */

DROP TABLE IF EXISTS `food_items`;

CREATE TABLE `food_items` (
  `food_item_id` int(11) NOT NULL AUTO_INCREMENT,
  `food_name` varchar(30) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `picture` varchar(200) DEFAULT NULL,
  `description` varchar(70) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`food_item_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `food_items` */

insert  into `food_items`(`food_item_id`,`food_name`,`price`,`picture`,`description`,`category_id`) values (3,'fn',100,'/static/food/aa.jpg','dess',1891),(4,'fn99',333,'/static/food/bb.jpg','de',1891);

/*Table structure for table `login` */

DROP TABLE IF EXISTS `login`;

CREATE TABLE `login` (
  `login_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(30) DEFAULT NULL,
  `password` varchar(8) DEFAULT NULL,
  `type` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`login_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=latin1;

/*Data for the table `login` */

insert  into `login`(`login_id`,`username`,`password`,`type`) values (1,'admin','admin','admin'),(10,'riss.mridul@gmail.com','4379','manager'),(11,'ammarwtr@gmail.com','4926','waitor'),(12,'adharshtrn@gmail.com','3622','transport'),(13,'riss.staff@gmail.com','123456','customer');

/*Table structure for table `order_master` */

DROP TABLE IF EXISTS `order_master`;

CREATE TABLE `order_master` (
  `order_master_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) DEFAULT NULL,
  `total` int(11) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `status` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`order_master_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `order_master` */

insert  into `order_master`(`order_master_id`,`customer_id`,`total`,`date`,`status`) values (2,13,500,'2020-05-29','ok');

/*Table structure for table `order_table` */

DROP TABLE IF EXISTS `order_table`;

CREATE TABLE `order_table` (
  `order_table_id` int(11) NOT NULL AUTO_INCREMENT,
  `food_items` varchar(50) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `order_master_id` int(11) DEFAULT NULL,
  `type` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`order_table_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `order_table` */

insert  into `order_table`(`order_table_id`,`food_items`,`quantity`,`order_master_id`,`type`) values (1,'fn',3,2,'normal'),(2,'spna',1,2,'spcl');

/*Table structure for table `service` */

DROP TABLE IF EXISTS `service`;

CREATE TABLE `service` (
  `service_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) DEFAULT NULL,
  `description` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`service_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `service` */

/*Table structure for table `spl_food` */

DROP TABLE IF EXISTS `spl_food`;

CREATE TABLE `spl_food` (
  `special_food_id` int(11) NOT NULL AUTO_INCREMENT,
  `spl_food_name` varchar(30) DEFAULT NULL,
  `price` int(11) DEFAULT NULL,
  `picture` varchar(200) DEFAULT NULL,
  `description` varchar(70) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `week` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`special_food_id`)
) ENGINE=InnoDB AUTO_INCREMENT=503 DEFAULT CHARSET=latin1;

/*Data for the table `spl_food` */

insert  into `spl_food`(`special_food_id`,`spl_food_name`,`price`,`picture`,`description`,`category_id`,`week`) values (502,'spna',200,'/static/food/aa.jpg','deew',1891,'Sunday');

/*Table structure for table `staff` */

DROP TABLE IF EXISTS `staff`;

CREATE TABLE `staff` (
  `staff_id` int(11) NOT NULL AUTO_INCREMENT,
  `staff_name` varchar(30) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `photo` varchar(100) DEFAULT NULL,
  `gender` varchar(30) DEFAULT NULL,
  `place` varchar(30) DEFAULT NULL,
  `post` varchar(30) DEFAULT NULL,
  `pin` int(10) DEFAULT NULL,
  `email` varchar(30) DEFAULT NULL,
  `phone` varchar(10) DEFAULT NULL,
  `login_id` int(11) DEFAULT NULL,
  `type` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`staff_id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Data for the table `staff` */

insert  into `staff`(`staff_id`,`staff_name`,`dob`,`photo`,`gender`,`place`,`post`,`pin`,`email`,`phone`,`login_id`,`type`) values (3,'sn','2020-05-12','/static/food/biriyani.jpeg','male','plc','post',673317,'riss.mridul@gmail.com','9876432123',10,'manager'),(4,'Ammar','2020-05-12','/static/food/thiago.jpg','male','Kerala','Mahe',670672,'ammarwtr@gmail.com','9544101615',11,'waitor'),(5,'Adharsh T','2020-05-16','/static/food/Sergio.jpg','male','Kerala','Calicut',676844,'adharshtrn@gmail.com','9400888030',12,'transport');

/*Table structure for table `table_booking` */

DROP TABLE IF EXISTS `table_booking`;

CREATE TABLE `table_booking` (
  `table_book_id` int(10) NOT NULL AUTO_INCREMENT,
  `table_hotel_id` int(10) DEFAULT NULL,
  `cust_id` int(10) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `time` time DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`table_book_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `table_booking` */

/*Table structure for table `table_hotel` */

DROP TABLE IF EXISTS `table_hotel`;

CREATE TABLE `table_hotel` (
  `table_hotel_id` int(11) NOT NULL AUTO_INCREMENT,
  `table_num` int(5) DEFAULT NULL,
  `picture` varchar(200) DEFAULT NULL,
  `charge` int(11) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`table_hotel_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

/*Data for the table `table_hotel` */

insert  into `table_hotel`(`table_hotel_id`,`table_num`,`picture`,`charge`,`status`) values (5,102,'/static/Table/aa.jpg',250,'pending'),(9,1,'/static/Table/bb.jpg',120,'ok');

/*Table structure for table `vehicle` */

DROP TABLE IF EXISTS `vehicle`;

CREATE TABLE `vehicle` (
  `vehicle_id` int(11) NOT NULL AUTO_INCREMENT,
  `vehicle_name` varchar(30) DEFAULT NULL,
  `reg_no` varchar(11) DEFAULT NULL,
  `fare` int(11) DEFAULT NULL,
  `tid` int(20) DEFAULT NULL,
  PRIMARY KEY (`vehicle_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `vehicle` */

insert  into `vehicle`(`vehicle_id`,`vehicle_name`,`reg_no`,`fare`,`tid`) values (4,'Honda Accord','KL 10 A 778',50,12);

/*Table structure for table `vehicle_booking` */

DROP TABLE IF EXISTS `vehicle_booking`;

CREATE TABLE `vehicle_booking` (
  `vehcile_booking_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) DEFAULT NULL,
  `vehcile_id` int(11) DEFAULT NULL,
  `date` date NOT NULL,
  `time` time NOT NULL,
  `status` varchar(30) NOT NULL,
  PRIMARY KEY (`vehcile_booking_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `vehicle_booking` */

insert  into `vehicle_booking`(`vehcile_booking_id`,`customer_id`,`vehcile_id`,`date`,`time`,`status`) values (2,13,4,'2020-05-29','14:50:21','pending');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
