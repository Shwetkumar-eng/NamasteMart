--create DATABASE
CREATE DATABASE smart;

USE `smart`;
CREATE USER 'smart'@'localhost' IDENTIFIED BY 'smart';
GRANT ALL PRIVILEGES ON *.* TO 'smart'@'localhost'WITH GRANT OPTION;



DROP TABLE IF EXISTS `smart`.`product`;
CREATE TABLE IF NOT EXISTS `smart`.`product`(
`pid` VARCHAR(45)NOT NULL,
`pname` VARCHAR(100) null DEFAULT NULL,
`ptype` VARCHAR(200) null DEFAULT NULL,
`pinfo` VARCHAR(350) null DEFAULT NULL,
`pprice` DECIMAL(12,2) null DEFAULT NULL,
`pquantity` INT NULL DEFAULT NULL,
`image` LONGBLOB NULL DEFAULT null,
PRIMARY KEY(`pid`)
);

DROP TABLE IF EXISTS `smart`.`orders`;
CREATE TABLE IF NOT EXISTS `smart`.`orders`(
`orderid` VARCHAR(45)NOT NULL,
`prodid` VARCHAR(45)NOT NULL,
`quantity` INT NULL DEFAULT NULL,
`amount` DECIMAL(12,2) null DEFAULT NULL,
`shipped` INT NOT NULL DEFAULT 0,
`order_date` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
PRIMARY KEY(`orderid`,`prodid`),
INDEX `productid_idx`(`prodid` ASC),
CONSTANT `productid`
FOREIGN KEY(`prodid`)
REFERENCES`product`(`pid`)
ON DELETE CASCADE
on UPDATE CASCADE
);

DROP TABLE IF EXISTS `smart`.`user`;
CREATE TABLE IF NOT EXISTS `smart`.`user`(
`email` VARCHAR(60)NOT NULL,
`name` VARCHAR(60) null DEFAULT NULL,
`mobile` BIGINT NULL DEFAULT NULL,
`address` VARCHAR(250) null DEFAULT NULL,
`pincode` INT null DEFAULT NULL,
`password` VARCHAR(20) null DEFAULT NULL,
`userimage` LONGBLOB NULL DEFAULT null,
`is_active` BOOLEAN DEFAULT TRUE,
PRIMARY KEY(`email`)
);

DROP TABLE IF EXISTS `smart`.`transactions`;
CREATE TABLE IF NOT EXISTS `smart`.`transactions`(
`transid` VARCHAR(45)NOT NULL,
`username` VARCHAR(60)NOT NULL,
`time` DATETIME NULL DEFAULT NULL,

`amount` DECIMAL(10,2) null DEFAULT NULL,
`status` VARCHAR(20) NULL DEFAULT `paid`,
PRIMARY KEY(`transid`),
INDEX `truserid_idx`(`username`,ASC),
CONSTANT `truserid`
FOREIGN KEY(`username`)
REFERENCES`user`(`email`)
ON DELETE CASCADE
on UPDATE CASCADE

CONSTANT `transorderid`
FOREIGN KEY(`transid`)
REFERENCES`orders`(`orderid`)
ON DELETE CASCADE
on UPDATE CASCADE
);

DROP TABLE IF EXISTS `smart`.`user_demand`;
CREATE TABLE IF NOT EXISTS `smart`.`user_demand`(
`username` VARCHAR(60)NOT NULL,
`prodid` VARCHAR(45)NOT NULL,
`quantity` INT NULL DEFAULT NULL,
PRIMARY KEY(`username`,`prodid`),
INDEX `prodid_idx`(`prodid`,ASC),
CONSTANT `userdemailemail`
FOREIGN KEY(`username`)
REFERENCES`user`(`email`)
ON DELETE CASCADE
on UPDATE CASCADE

CONSTANT `prodid_fk`
FOREIGN KEY(`prodid`)
REFERENCES`product`(`pid`)
ON DELETE CASCADE
on UPDATE CASCADE
);


DROP TABLE IF EXISTS `smart`.`usercart`;
CREATE TABLE IF NOT EXISTS `smart`.`usercart`(
`username` VARCHAR(60)NOT NULL,
`prodid` VARCHAR(45)NOT NULL,
`quantity` INT NULL DEFAULT NULL,
PRIMARY KEY(`username`,`prodid`),
INDEX `useremail_idx`(`username`,ASC),
INDEX `prodidcart_idx`(`prodid`,ASC),
CONSTANT `useremail`
FOREIGN KEY(`username`)
REFERENCES`user`(`email`)
ON DELETE CASCADE
on UPDATE CASCADE

CONSTANT `prodidcart`
FOREIGN KEY(`prodid`)
REFERENCES`product`(`pid`)
ON DELETE CASCADE
on UPDATE CASCADE
);
