DROP TABLE IF EXISTS `log`;
CREATE TABLE `log` (
	  `id` int(11) NOT NULL AUTO_INCREMENT,
	  `timestamp` int(11) DEFAULT NULL,
	  `blinks` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=95573 DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `manualreading`;
CREATE TABLE `manualreading` (
	  `id` int(11) NOT NULL AUTO_INCREMENT,
	  `timestamp` int(11) DEFAULT NULL,
	  `kwh` int(11) DEFAULT NULL,
	  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;