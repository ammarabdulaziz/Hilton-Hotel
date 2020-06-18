/*
SQLyog Community
MySQL - 5.7.19 : Database - hotel
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`hotel` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `hotel`;

/*Table structure for table `bank` */

DROP TABLE IF EXISTS `bank`;

CREATE TABLE `bank` (
  `bank_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(10) NOT NULL,
  `card_number` int(12) NOT NULL,
  `valid_thru` varchar(12) NOT NULL,
  `cvv` int(10) NOT NULL,
  `pin` int(10) DEFAULT NULL,
  `bal` bigint(10) DEFAULT NULL,
  PRIMARY KEY (`bank_id`)
) ENGINE=InnoDB AUTO_INCREMENT=123456790 DEFAULT CHARSET=latin1;

/*Data for the table `bank` */

insert  into `bank`(`bank_id`,`customer_id`,`card_number`,`valid_thru`,`cvv`,`pin`,`bal`) values 
(123456789,8,123456789,'12/24',123,1234,4993060);

/*Table structure for table `cart` */

DROP TABLE IF EXISTS `cart`;

CREATE TABLE `cart` (
  `cart_id` int(10) NOT NULL AUTO_INCREMENT,
  `food_id` int(10) DEFAULT NULL,
  `quantity` bigint(20) DEFAULT NULL,
  `cust_id` int(25) DEFAULT NULL,
  PRIMARY KEY (`cart_id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

/*Data for the table `cart` */

insert  into `cart`(`cart_id`,`food_id`,`quantity`,`cust_id`) values 
(4,2,6,8),
(5,1,5,8);

/*Table structure for table `category` */

DROP TABLE IF EXISTS `category`;

CREATE TABLE `category` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `category` */

insert  into `category`(`category_id`,`category_name`) values 
(1,'Breakfast'),
(2,'Lunch'),
(3,'Snacks'),
(4,'Dinner');

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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `complaint` */

insert  into `complaint`(`complaint_id`,`complaints`,`customer_id`,`date`,`reply`,`type`) values 
(1,'Good service',8,'2020-03-14','thanks','transport'),
(2,'hello',8,'2020-03-16','ok','manager'),
(3,'skn',8,'2020-03-16','jjdsj','admin'),
(4,'hhh',8,'2020-03-16','pending','manager');

/*Table structure for table `customer` */

DROP TABLE IF EXISTS `customer`;

CREATE TABLE `customer` (
  `customer_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_name` varchar(30) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `gender` varchar(30) DEFAULT NULL,
  `phone` bigint(20) DEFAULT NULL,
  `email` varchar(30) DEFAULT NULL,
  `login_id` int(11) DEFAULT NULL,
  `place` varchar(30) DEFAULT NULL,
  `landmark` varchar(30) DEFAULT NULL,
  `post` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`customer_id`),
  UNIQUE KEY `customer_id` (`customer_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `customer` */

insert  into `customer`(`customer_id`,`customer_name`,`dob`,`gender`,`phone`,`email`,`login_id`,`place`,`landmark`,`post`) values 
(3,'Ammar Abdul Aziz','0000-00-00','Male',9846704128,'ammar@gmail.com',8,'Mahe','Spinning Mill','Chokli'),
(4,'riss','2020-02-02','Male',9856436197,'riss@gmail.com',9,'riss','riss','riss');

/*Table structure for table `delay_message` */

DROP TABLE IF EXISTS `delay_message`;

CREATE TABLE `delay_message` (
  `delay_message_id` int(11) NOT NULL AUTO_INCREMENT,
  `order_master_id` int(11) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `message` varchar(100) DEFAULT NULL,
  `status` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`delay_message_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `delay_message` */

insert  into `delay_message`(`delay_message_id`,`order_master_id`,`date`,`message`,`status`) values 
(3,3,'2020-03-17','r','Preparing');

/*Table structure for table `feedbacks` */

DROP TABLE IF EXISTS `feedbacks`;

CREATE TABLE `feedbacks` (
  `feedback_id` int(11) NOT NULL AUTO_INCREMENT,
  `feedbacks` varchar(100) DEFAULT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `type` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`feedback_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `feedbacks` */

insert  into `feedbacks`(`feedback_id`,`feedbacks`,`customer_id`,`date`,`type`) values 
(1,'Full of confusion ',8,'2020-03-14','manager');

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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `food_items` */

insert  into `food_items`(`food_item_id`,`food_name`,`price`,`picture`,`description`,`category_id`) values 
(1,'Biriyani',90,'/static/food/biriyani.jpeg','Biryani With Goat Meat',2),
(2,'Tea',10,'/static/food/tea.jpg','Masala Chai',3);

/*Table structure for table `login` */

DROP TABLE IF EXISTS `login`;

CREATE TABLE `login` (
  `login_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(30) DEFAULT NULL,
  `password` varchar(8) DEFAULT NULL,
  `type` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`login_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

/*Data for the table `login` */

insert  into `login`(`login_id`,`username`,`password`,`type`) values 
(1,'admin','admin','admin'),
(2,'sergioarques@gmail.com','1102','manager'),
(3,'thiago@gmail.com','1313','transport'),
(4,'waitor','waitor','waitor'),
(5,'a@gmail.com','a12345','customer'),
(8,'ammar@gmail.com','ammar1','customer'),
(9,'riss@gmail.com','riss123','customer');

/*Table structure for table `order_master` */

DROP TABLE IF EXISTS `order_master`;

CREATE TABLE `order_master` (
  `order_master_id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) DEFAULT NULL,
  `total` int(11) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `status` varchar(30) DEFAULT NULL,
  `type` varchar(30) DEFAULT NULL,
  `table_hotel_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`order_master_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `order_master` */

insert  into `order_master`(`order_master_id`,`customer_id`,`total`,`date`,`status`,`type`,`table_hotel_id`) values 
(1,8,280,'2020-03-16','approved','Food',2),
(2,8,280,'2020-03-16','pending','Food',2),
(3,8,1080,'2020-03-17','approved','Special Food',2),
(4,8,180,'2020-03-17','pending','Special Food',2);

/*Table structure for table `order_table` */

DROP TABLE IF EXISTS `order_table`;

CREATE TABLE `order_table` (
  `order_table_id` int(11) NOT NULL AUTO_INCREMENT,
  `food_items_id` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `order_master_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`order_table_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `order_table` */

insert  into `order_table`(`order_table_id`,`food_items_id`,`quantity`,`order_master_id`) values 
(1,1,2,1),
(2,2,1,2),
(3,501,6,3),
(4,501,1,4);

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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `spl_food` */

insert  into `spl_food`(`special_food_id`,`spl_food_name`,`price`,`picture`,`description`,`category_id`,`week`) values 
(500,'Beef Shawarma',80,'/static/food/Beef Sharwarma.jpg','beef',3,'2'),
(501,'Mutton Mandhi',180,'/static/food/Mutton Mandhi.jpg','mutton',4,'3');

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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `staff` */

insert  into `staff`(`staff_id`,`staff_name`,`dob`,`photo`,`gender`,`place`,`post`,`pin`,`email`,`phone`,`login_id`,`type`) values 
(1,'Sergio Arques','1996-05-14','/static/food/Sergio.jpg','male','Delhi','Sri Nagar',670672,'sergioarques@gmail.com','9846778459',2,'manager'),
(2,'Thiago Robert','1994-02-09','/static/food/thiago.jpg','male','Chennai Central','Madurai',677899,'thiago@gmail.com','9847766554',3,'transport');

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

insert  into `table_booking`(`table_book_id`,`table_hotel_id`,`cust_id`,`date`,`time`,`status`) values 
(1,2,8,'2020-03-14','16:20:35','alloted'),
(2,2,8,'2020-03-14','16:21:05','alloted'),
(3,1,8,'2020-03-16','12:37:58','alloted'),
(4,1,8,'2020-03-17','12:38:54','alloted');

/*Table structure for table `table_hotel` */

DROP TABLE IF EXISTS `table_hotel`;

CREATE TABLE `table_hotel` (
  `table_hotel_id` int(11) NOT NULL AUTO_INCREMENT,
  `table_num` int(5) DEFAULT NULL,
  `picture` varchar(200) DEFAULT NULL,
  `charge` int(11) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`table_hotel_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `table_hotel` */

insert  into `table_hotel`(`table_hotel_id`,`table_num`,`picture`,`charge`,`status`) values 
(1,101,'/static/Table/a.jpg',1200,'alloted'),
(2,102,'/static/Table/table.jpg',1500,'alloted'),
(3,103,'/static/Table/PicsArt_03-17-09.14.41.jpg',500,'pending');

/*Table structure for table `vehicle` */

DROP TABLE IF EXISTS `vehicle`;

CREATE TABLE `vehicle` (
  `vehicle_id` int(11) NOT NULL AUTO_INCREMENT,
  `vehicle_name` varchar(30) DEFAULT NULL,
  `reg_no` varchar(11) DEFAULT NULL,
  `fare` int(11) DEFAULT NULL,
  `tid` int(20) DEFAULT NULL,
  PRIMARY KEY (`vehicle_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `vehicle` */

insert  into `vehicle`(`vehicle_id`,`vehicle_name`,`reg_no`,`fare`,`tid`) values 
(1,'Toyota Corolla','KL 7 F 9972',30,3),
(3,'Honda Accord','KL 10 A 778',50,3);

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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `vehicle_booking` */

insert  into `vehicle_booking`(`vehcile_booking_id`,`customer_id`,`vehcile_id`,`date`,`time`,`status`) values 
(1,8,3,'2020-03-14','16:22:14','pending');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
