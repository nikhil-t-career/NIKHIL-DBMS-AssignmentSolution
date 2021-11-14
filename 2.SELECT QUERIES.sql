-- Write queries for the following:

-- 3)	How many females and how many male passengers travelled for a minimum distance of 600 KM s?
-- PASSENGER -> ROUTE GROUP BY GENDER
SELECT
	P.GENDER ,
	COUNT(P.PASSENGER_NAME)
FROM
	PASSENGER P
JOIN ROUTES R ON
	P.ROUTE_ID = R.ROUTE_ID
WHERE
	R.DISTANCE >= 600
GROUP BY
	P.GENDER ;

-- OUTPUT

-- |GENDER|COUNT(P.PASSENGER_NAME)|
-- |------|-----------------------|
-- |F     |2                      |
-- |M     |4                      |



-- 4)	Find the minimum ticket price for Sleeper Bus.
-- ASSUMPTION - I HAVE ADDED NEW VALUE AND ROWS IN PRICE TABLE AS PER ADDITIONAL COMMENTS IN PROBLEM STMT

-- SOLUTION 1  AND SOLUTION 2
SELECT
	MIN(PRICE)
FROM
	PRICE p
WHERE
	p.BUS_TYPE = 'Sleeper';

SELECT
	PRICE
FROM
	PRICE
ORDER BY
	PRICE ASC
LIMIT 1;

-- OUTPUT

-- |PRICE|
-- |-----|
-- |434  |



-- 5)	Select passenger names whose names start with character 'S'
SELECT
	PASSENGER_NAME
FROM
	PASSENGER p
WHERE
	p.PASSENGER_NAME like 'S%';

-- output
-- |PASSENGER_NAME|
-- |--------------|
-- |Sejal         |




-- 6)	Calculate price charged for each passenger displaying Passenger name, Boarding City, Destination City, Bus_Type, Price in the output
--  NOTE - I ADDED EXTRA COLUMN SEASON AS PER THE ADDITIONAL COMMENTS FOR PROBLEM STMT
-- NOTE - SO IN PRICE TABLE 2 PRICES  1 FOR FESTIVE AND 2ND FOR NORMAL SEASON ARE PRESENT.
-- Tables - PASSENGER -> ROUTES ON ROUTE_ID -> PRICE ON ROUTE_ID  -> 
SELECT
	PA.PASSENGER_NAME ,
	R.BOARDING_CITY ,
	R.DESTINATION_CITY ,
	PR.SEASON ,
	PR.BUS_TYPE ,
	PR.PRICE
FROM
	PASSENGER PA
JOIN ROUTES R ON
	PA.ROUTE_ID = R.ROUTE_ID
JOIN PRICE PR ON
	R.ROUTE_ID = PR.ROUTE_ID
WHERE
	PR.SEASON = 'Festive';

-- OUTPUT - WHEN FESTIVE SEASON IS MEANTIONED. 

-- |PASSENGER_NAME|BOARDING_CITY|DESTINATION_CITY|SEASON |BUS_TYPE|PRICE|
-- |--------------|-------------|----------------|-------|--------|-----|
-- |Sejal         |Bengaluru    |Chennai         |Festive|Sleeper |770  |
-- |Manish        |Hyderabad    |Bengaluru       |Festive|Sleeper |1100 |
-- |Ankur         |Nagpur       |Hyderabad       |Festive|Sleeper |1240 |
-- |Pallavi       |Panaji       |Bengaluru       |Festive|Sleeper |1320 |
-- |Hemant        |panaji       |Mumbai          |Festive|Sleeper |1540 |
-- |Piyush        |Pune         |Nagpur          |Festive|Sleeper |2640 |
-- |Udit          |Trivandrum   |panaji          |Festive|Sleeper |2200 |


SELECT
	PA.PASSENGER_NAME ,
	R.BOARDING_CITY ,
	R.DESTINATION_CITY ,
	PR.SEASON ,
	PR.BUS_TYPE ,
	PR.PRICE
FROM
	PASSENGER PA
JOIN ROUTES R ON
	PA.ROUTE_ID = R.ROUTE_ID
JOIN PRICE PR ON
	R.ROUTE_ID = PR.ROUTE_ID
WHERE
	PR.SEASON = 'Normal';


-- |PASSENGER_NAME|BOARDING_CITY|DESTINATION_CITY|SEASON|BUS_TYPE|PRICE|
-- |--------------|-------------|----------------|------|--------|-----|
-- |Sejal         |Bengaluru    |Chennai         |Normal|Sleeper |434  |
-- |Manish        |Hyderabad    |Bengaluru       |Normal|Sitting |620  |
-- |Ankur         |Nagpur       |Hyderabad       |Normal|Sitting |620  |
-- |Pallavi       |Panaji       |Bengaluru       |Normal|Sitting |744  |
-- |Hemant        |panaji       |Mumbai          |Normal|Sitting |1488 |
-- |Piyush        |Pune         |Nagpur          |Normal|Sitting |868  |
-- |Udit          |Trivandrum   |panaji          |Normal|Sitting |1860 |



-- 7)	What is the passenger name and his/her ticket price who travelled in Sitting bus for a distance of 1000 KM s
-- TABLE PASSENGER -> ROUTE ON ROUTE_ID -> PRICE ON ROUTE_ID
SELECT
	PA.PASSENGER_NAME ,
	PR.PRICE
FROM
	PASSENGER PA
JOIN ROUTES R ON
	PA.ROUTE_ID = R.ROUTE_ID
JOIN PRICE PR ON
	R.ROUTE_ID = PR.ROUTE_ID
WHERE
	R.DISTANCE = 1000
	AND PR.BUS_TYPE = 'Sitting';

-- OUTPUT

-- |PASSENGER_NAME|PRICE|
-- |--------------|-----|
-- |Udit          |1860 |



-- 8)	What will be the Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to Panaji?
-- PASSENGER -> ROUTE -> PRICE -- ROUTE 
-- CURRENTLY IN SAMPLE DATA IS PANAJI TO BANGLORE CONSIDERING  INVERSION AND SAME PRICE
SELECT
	PA.PASSENGER_NAME ,
	R.DESTINATION_CITY AS `BOARDING CITY`,
	R.BOARDING_CITY AS `DESTINATION CITY`,
	R.DISTANCE ,
	PR.BUS_TYPE ,
	PR.PRICE
FROM
	PASSENGER PA
JOIN ROUTES R ON
	PA.ROUTE_ID = R.ROUTE_ID
JOIN PRICE PR ON
	R.ROUTE_ID = PR.ROUTE_ID
WHERE
	PA.PASSENGER_NAME = 'Pallavi' ;




-- OUTPUT  - IF INVERSION OF DESTINATION AND BOARDING IS CONSIDERED AND PRICES THE SAME
-- |PASSENGER_NAME|BOARDING CITY|DESTINATION CITY|DISTANCE|BUS_TYPE|PRICE|
-- |--------------|-------------|----------------|--------|--------|-----|
-- |Pallavi       |Bengaluru    |Panaji          |600     |Sleeper |1320 |
-- |Pallavi       |Bengaluru    |Panaji          |600     |Sitting |744  |


SELECT
	PA.PASSENGER_NAME ,
	R.BOARDING_CITY ,
	R.DESTINATION_CITY,
	R.DISTANCE ,
	PR.BUS_TYPE ,
	PR.PRICE
FROM
	PASSENGER PA
JOIN ROUTES R ON
	PA.ROUTE_ID = R.ROUTE_ID
JOIN PRICE PR ON
	R.ROUTE_ID = PR.ROUTE_ID
WHERE
	PA.PASSENGER_NAME = 'Pallavi' ;


-- OUTPUT -IF ABOVE INVERSION OF BOARDING AND DESTINATION IS NOT CONSIDERED
-- |PASSENGER_NAME|BOARDING_CITY|DESTINATION_CITY|DISTANCE|BUS_TYPE|PRICE|
-- |--------------|-------------|----------------|--------|--------|-----|
-- |Pallavi       |Panaji       |Bengaluru       |600     |Sleeper |1320 |
-- |Pallavi       |Panaji       |Bengaluru       |600     |Sitting |744  |



-- 9)		List the distances from the "Passenger" table which are unique (non-repeated distances) in descending order.
-- PASSENGER -> ROUTES 
-- THIS -> SOLUTION 1 - DISTANCES THAT ARE NOT REPEATED i.e. APPEAR ONLY ONCE IN TABLE CATALOGUE
SELECT
	R.DISTANCE
FROM
	PASSENGER P
JOIN ROUTES R ON
	P.ROUTE_ID = R.ROUTE_ID
GROUP BY
	R.DISTANCE
HAVING
	COUNT(R.ROUTE_ID) = 1
ORDER BY
	R.DISTANCE DESC;

-- |DISTANCE|
-- |--------|
-- |1500    |
-- |1000    |
-- |600     |
-- |350     |



-- SOLUTION 2 - DIFFERENT THAN ABOVE. SIMPLY UNIQUE DISTANCE THAT ARE REPEATITIVE FOR ROUTES
SELECT
	DISTINCT DISTANCE
FROM
	PASSENGER P
JOIN ROUTES R ON
	P.ROUTE_ID = R.ROUTE_ID
ORDER BY
	R.DISTANCE DESC;

-- |DISTANCE|
-- |--------|
-- |1500    |
-- |1000    |
-- |700     |
-- |600     |
-- |500     |
-- |350     |




-- 10)	Display the passenger name and percentage of distance travelled by that passenger from 
-- the total distance travelled by all passengers without using user variables
SELECT
	P.PASSENGER_NAME ,
	R.DISTANCE ,
	((R.DISTANCE / SUM(R.DISTANCE)) * 100)
FROM
	PASSENGER P
LEFT JOIN ROUTES R on
	P.ROUTE_ID = R.ROUTE_ID
GROUP BY
	R.DISTANCE ;


-- 11)	Display the distance, price in three categories in table Price
-- a)	Expensive if the cost is more than 1000
-- b)	Average Cost if the cost is less than 1000 and greater than 500
-- c)	Cheap otherwise
-- ASSUMPTION I HAVE ADDED  <=1000 FOR NOT MISSING OUT ON VALUE 1000
SELECT
	R.DISTANCE ,
	P.SEASON ,
	P.PRICE,
	CASE
		WHEN P.PRICE > 1000 THEN 'Expensive'
		WHEN P.PRICE <= 1000 AND P.PRICE > 500 THEN 'Average Cost'
		ELSE 'Cheap'
	END AS `VERDICT`
FROM
	ROUTES R
JOIN PRICE P ON
	R.ROUTE_ID = P.ROUTE_ID;

-- OUTPUT

-- |DISTANCE|SEASON |PRICE|VERDICT     |
-- |--------|-------|-----|------------|
-- |350     |Festive|770  |Average Cost|
-- |350     |Normal |434  |Cheap       |
-- |500     |Normal |620  |Average Cost|
-- |500     |Festive|1100 |Expensive   |
-- |500     |Normal |620  |Average Cost|
-- |500     |Festive|1240 |Expensive   |
-- |600     |Festive|1320 |Expensive   |
-- |600     |Normal |744  |Average Cost|
-- |700     |Festive|1540 |Expensive   |
-- |700     |Normal |1488 |Expensive   |
-- |700     |Normal |868  |Average Cost|
-- |700     |Festive|2640 |Expensive   |
-- |1000    |Festive|2200 |Expensive   |
-- |1000    |Normal |1860 |Expensive   |
