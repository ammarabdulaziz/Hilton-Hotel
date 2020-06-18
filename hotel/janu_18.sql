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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `bank` */

insert  into `bank`(`bank_id`,`customer_id`,`card_number`,`valid_thru`,`cvv`,`pin`,`bal`) values 
(1,7,2147483647,'22/20',666,1234,4602),
(2,2,2147483647,'33/54',565,1234,1250),
(3,3,919565616,'66/44',541,1234,35000);

/*Table structure for table `cart` */

DROP TABLE IF EXISTS `cart`;

CREATE TABLE `cart` (
  `cart_id` int(10) NOT NULL AUTO_INCREMENT,
  `food_id` int(10) DEFAULT NULL,
  `quantity` bigint(20) DEFAULT NULL,
  `cust_id` int(25) DEFAULT NULL,
  PRIMARY KEY (`cart_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `cart` */

/*Table structure for table `category` */

DROP TABLE IF EXISTS `category`;

CREATE TABLE `category` (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

/*Data for the table `category` */

insert  into `category`(`category_id`,`category_name`) values 
(1,'Dinner'),
(2,'Juice'),
(4,'Breakfast'),
(5,'Beverages'),
(6,'Snaks');

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

insert  into `complaint`(`complaint_id`,`complaints`,`customer_id`,`date`,`reply`,`type`) values 
(1,'jfghkku',1,'0000-00-00','pending','transport'),
(2,'fvfsvs',2,'2332-12-12','sdasd','Customer'),
(3,'gahah',7,'2020-03-10','pending','admin');

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
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Data for the table `customer` */

insert  into `customer`(`customer_id`,`customer_name`,`dob`,`gender`,`phone`,`email`,`login_id`,`place`,`landmark`,`post`) values 
(1,'ajay','2020-12-21','Male',9846466,'a@gmail.com',7,'Mahe','dsfsadf','6466'),
(2,'amal','2624-12-12','Male',5313513,'asfdcs@vd.com',2,'Mahe','dzcdzc','5656'),
(3,'fasdas','2020-03-09','Male',652626,'asdad@sgf.csdac',3,'sada','sdvs','5966'),
(4,'asfcd','2020-03-09','Male',56656,'Dsf@sgfvs.sd',4,'df','sdfcsd','5666'),
(5,'abc','1993-02-02','Male',8764954349,'abc@gmail.com',14,'abc','abc','abc');

/*Table structure for table `delay_message` */

DROP TABLE IF EXISTS `delay_message`;

CREATE TABLE `delay_message` (
  `delay_message_id` int(11) NOT NULL AUTO_INCREMENT,
  `order_master_id` int(11) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `message` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`delay_message_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

/*Data for the table `delay_message` */

insert  into `delay_message`(`delay_message_id`,`order_master_id`,`date`,`message`) values 
(1,1,'2020-03-10','preparing');

/*Table structure for table `feedbacks` */

DROP TABLE IF EXISTS `feedbacks`;

CREATE TABLE `feedbacks` (
  `feedback_id` int(11) NOT NULL AUTO_INCREMENT,
  `feedbacks` varchar(100) DEFAULT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `type` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`feedback_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `feedbacks` */

insert  into `feedbacks`(`feedback_id`,`feedbacks`,`customer_id`,`date`,`type`) values 
(1,'sdvbdfhftjfj',1,'0000-00-00','transport'),
(2,'sdfdsf',2,'2012-12-12','transport'),
(3,'dscd',3,'2012-12-12','transport'),
(4,'hi',7,'2020-03-10','admin');

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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

/*Data for the table `food_items` */

insert  into `food_items`(`food_item_id`,`food_name`,`price`,`picture`,`description`,`category_id`) values 
(6,'dfsasaas',12,'/static/food/Screenshot (2).png','super delicious',3),
(8,'efs',342,'/static/food/B612_20181228_071659_645.jpg','rewwwwwwwwwwww',5),
(11,'d',313,'/static/food/B612_20181228_071659_645.jpg','khkn',4);

/*Table structure for table `login` */

DROP TABLE IF EXISTS `login`;

CREATE TABLE `login` (
  `login_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(30) DEFAULT NULL,
  `password` varchar(8) DEFAULT NULL,
  `type` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`login_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;

/*Data for the table `login` */

insert  into `login`(`login_id`,`username`,`password`,`type`) values 
(1,'elhaloul','elhaloul','admin'),
(2,'ammar','ammar','manager'),
(3,'bbb','bbb','billing'),
(4,'aaa','aaa','waitor'),
(5,'adass@afeaf.asfd','2289','manager'),
(6,'ttt','ttt','transport'),
(7,'a@gmail.com','a','customer'),
(14,'abc','abc','customer');

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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;

/*Data for the table `order_master` */

insert  into `order_master`(`order_master_id`,`customer_id`,`total`,`date`,`status`,`type`,`table_hotel_id`) values 
(1,1,44,'0002-02-12','Approved','food',1),
(2,2,65146,'0000-00-00','Pending','food',2),
(3,3,48661,'0000-00-00','Pending','food',3),
(4,4,6456,'0000-00-00','Pending','food',4),
(6,7,342,'2020-03-10','success','food',6);

/*Table structure for table `order_table` */

DROP TABLE IF EXISTS `order_table`;

CREATE TABLE `order_table` (
  `order_table_id` int(11) NOT NULL AUTO_INCREMENT,
  `food_items_id` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `order_master_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`order_table_id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=latin1;

/*Data for the table `order_table` */

insert  into `order_table`(`order_table_id`,`food_items_id`,`quantity`,`order_master_id`) values 
(11,1,22,1),
(22,1,1,1),
(23,8,1,6);

/*Table structure for table `service` */

DROP TABLE IF EXISTS `service`;

CREATE TABLE `service` (
  `service_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) DEFAULT NULL,
  `description` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`service_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

/*Data for the table `service` */

insert  into `service`(`service_id`,`name`,`description`) values 
(3,'scs','scc'),
(4,'fghrh','jhgn'),
(5,'ergerhjk','rgrs'),
(6,'dsfdf','dsa'),
(7,'aaaaaa','wqrasd');

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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `spl_food` */

insert  into `spl_food`(`special_food_id`,`spl_food_name`,`price`,`picture`,`description`,`category_id`,`week`) values 
(1,'mangoo',60,'/static/food/Screenshot (7).png',NULL,2,'Sunday'),
(2,'mangoods',10055,'/static/food/Screenshot (5).png',NULL,4,'Friday'),
(3,'asdads',1233,'/static/food/B612_20181228_071659_645.jpg',NULL,6,'Wednesday');

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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

/*Data for the table `staff` */

insert  into `staff`(`staff_id`,`staff_name`,`dob`,`photo`,`gender`,`place`,`post`,`pin`,`email`,`phone`,`login_id`,`type`) values 
(2,'aed','2015-08-15',NULL,'radio',NULL,NULL,NULL,'awd','213',NULL,'waitor'),
(3,'fd','2019-12-15',NULL,'radio2',NULL,NULL,NULL,'sf','3',NULL,'transport'),
(4,'vd','2019-12-15',NULL,'female',NULL,NULL,NULL,'er','233223',NULL,'waitor'),
(5,'asdas','2020-01-29','/static/food/B612_20181228_071659_645.jpg','male',NULL,NULL,NULL,'sdf@ad.gyh','1111111111',NULL,'transport'),
(6,'adfsa','2018-10-20',NULL,'female',NULL,NULL,NULL,'edfsef@sefs.rgfds','4824266565',NULL,'waitor'),
(7,'asdas','2020-01-27',NULL,'male',NULL,NULL,NULL,'asdsa@sfe.com','1111111111',NULL,'manager'),
(8,'dsfdf','2020-01-29','/static/food/Screenshot (1).png','male',NULL,NULL,NULL,'sdf@ad.gyh','1111111111',NULL,'waitor'),
(9,'sadsad','2020-02-12','/static/food/B612_20181227_212748_372.jpg','male',NULL,NULL,NULL,'adass@afeaf.asfd','9999999999',4,'manager'),
(11,'ammmar','2020-02-11','/static/food/B612_20181227_212646_509.jpg','male','mma','adas',12122,'aaa','9999999999',6,'transport');

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
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

/*Data for the table `table_booking` */

insert  into `table_booking`(`table_book_id`,`table_hotel_id`,`cust_id`,`date`,`time`,`status`) values 
(9,6,7,'2020-03-10','09:20:01','alloted');

/*Table structure for table `table_hotel` */

DROP TABLE IF EXISTS `table_hotel`;

CREATE TABLE `table_hotel` (
  `table_hotel_id` int(11) NOT NULL AUTO_INCREMENT,
  `table_num` int(5) DEFAULT NULL,
  `picture` varchar(200) DEFAULT NULL,
  `charge` int(11) DEFAULT NULL,
  PRIMARY KEY (`table_hotel_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;

/*Data for the table `table_hotel` */

insert  into `table_hotel`(`table_hotel_id`,`table_num`,`picture`,`charge`) values 
(3,199,'/static/table/Screenshot (7).png',56),
(5,100,'/static/table/Screenshot (5).png',56),
(6,156,'/static/table/Screenshot (6).png',56),
(8,100,'/static/table/Screenshot (5).png',56),
(9,23,'/static/table/B612_20181228_071659_645.jpg',132123);

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
(1,'Maruthi','KL 35 B 356',3647,NULL),
(2,'Bike','65dc654dc',65464654,NULL),
(3,'dcd','ds5435sdc',5433546,6);

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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

/*Data for the table `vehicle_booking` */

insert  into `vehicle_booking`(`vehcile_booking_id`,`customer_id`,`vehcile_id`,`date`,`time`,`status`) values 
(1,1,1,'2012-12-12','12:12:12','pending'),
(2,2,2,'2012-12-12','12:12:12','pending'),
(3,3,3,'2012-12-12','12:12:12','pending'),
(4,7,3,'2020-03-10','00:38:56','pending');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
