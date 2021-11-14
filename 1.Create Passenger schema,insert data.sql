create database if not exists PASSENGER_SCHEMA;

USE PASSENGER_SCHEMA;


CREATE TABLE IF NOT EXISTS `ROUTES` (
`ROUTE_ID` VARCHAR(10) PRIMARY KEY,
`BOARDING_CITY` VARCHAR(20) NOT NULL,
`DESTINATION_CITY` VARCHAR(20) NOT NULL,
`DISTANCE` INT NOT NULL
);

CREATE TABLE IF NOT EXISTS `PASSENGER`(
`PASSENGER_UID` VARCHAR(10) PRIMARY KEY,
`PASSENGER_NAME` VARCHAR(30) NOT NULL,
`BUS_CATEGORY` VARCHAR(10) NOT NULL,
`GENDER` CHAR NOT NULL,
`ROUTE_ID` VARCHAR(10) NOT NULL,
`BUS_TYPE` VARCHAR(10) NOT NULL,
FOREIGN KEY(`ROUTE_ID`) REFERENCES ROUTES(`ROUTE_ID`)
);

CREATE TABLE IF NOT EXISTS `PRICE`(
`ROUTE_ID` VARCHAR(10) NOT NULL,
`BUS_TYPE` VARCHAR(10) NOT NULL,
`SEASON` VARCHAR(10) NOT NULL,
`PRICE` INT NOT NULL,
FOREIGN KEY(`ROUTE_ID`) REFERENCES ROUTES(`ROUTE_ID`)
);

SET
FOREIGN_KEY_CHECKS = 0;



INSERT
	INTO
	`ROUTES`
VALUES
("Route1","Bengaluru","Chennai",350),
("Route2","Chennai","Mumbai",1500),
("Route3","Hyderabad","Bengaluru",500),
("Route4","Mumbai","Hyderabad",700),
("Route5","Nagpur","Hyderabad",500),
("Route6","Panaji","Bengaluru",600),
("Route7","panaji","Mumbai",700),
("Route8","Pune","Nagpur",700),
("Route9","Trivandrum","panaji",1000);

INSERT
	INTO
	PASSENGER
VALUES
("uid1","Sejal","AC","F","Route1","Sleeper"),
("uid2","Khusboo","AC","F","Route2","Sleeper"),
("uid3","Manish","Non-AC","M","Route3","Sitting"),
("uid4","Anmol","Non-AC","M","Route4","Sitting"),
("uid5","Ankur","AC","M","Route5","Sitting"),
("uid6","Pallavi","AC","F","Route6","Sleeper"),
("uid7","Hemant","Non-AC","M","Route7","Sleeper"),
("uid8","Piyush","AC","M","Route8","Sitting"),
("uid9","Udit","Non-AC","M","Route9","Sleeper");



INSERT
	INTO
	PRICE
VALUES
("Route1","Sleeper","Festive",770),
("Route1","Sleeper","Normal",434),
("Route3","Sitting","Normal",620),
("Route3","Sleeper","Festive",1100),
("Route5","Sitting","Normal",620),
("Route5","Sleeper","Festive",1240),
("Route6","Sleeper","Festive",1320),
("Route6","Sitting","Normal",744),
("Route7","Sleeper","Festive",1540),
("Route7","Sitting","Normal",1488),
("Route8","Sitting","Normal",868),
("Route8","Sleeper","Festive",2640),
("Route9","Sleeper","Festive",2200),
("Route9","Sitting","Normal",1860);

SET FOREIGN_KEY_CHECKS=1;