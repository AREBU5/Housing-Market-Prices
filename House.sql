-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema house
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `house` ;

-- -----------------------------------------------------
-- Schema house
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `house` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `house` ;

-- -----------------------------------------------------
-- Table `house`.`house`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `house`.`house` (
  `bedroom_count` INT NULL DEFAULT NULL,
  `net_sqm` BIGINT NULL DEFAULT NULL,
  `center_distance` BIGINT NULL DEFAULT NULL,
  `metro_distance` BIGINT NULL DEFAULT NULL,
  `floor` INT NULL DEFAULT NULL,
  `age` INT NULL DEFAULT NULL,
  `price` DOUBLE NULL DEFAULT NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

USE house;

-- Average Property Price: 
-- The aveage price of properties in the market is $95,734.
SELECT CONCAT('$',FORMAT(ROUND(AVG(price),2),'C', 'en-US' )) AS Average_Price 
FROM house;

-- Maximum and Minimum Property Prices: 
-- The minimum market price is $84,153; while the maximum market price is $118,135.
SELECT CONCAT('$',FORMAT(ROUND(MIN(price),2),'C', 'en-US' )) AS Minumum_price,
		CONCAT('$',FORMAT(ROUND(MAX(price),2),'C', 'en-US' )) AS Maximum_price 
FROM house;

-- Properties with Two Bedroom:
-- There where 1,019 in the market 
SELECT FORMAT(count(bedroom_count), 'C', 'en-US') AS Two_Room_Apartment FROM house
WHERE bedroom_count = 2;

-- Average Price by Two Bedroom:
-- The total average price of a two bedroom apartment is 94,391
SELECT bedroom_count, CONCAT('$',FORMAT(AVG(price), 'C', 'en-US')) AS Total_Avg_price 
FROM house
GROUP BY bedroom_count;

SELECT CONCAT('$',FORMAT(AVG(price), 'C', 'en-US')) AS Avg_price_Two_Room_Apartment 
FROM house
WHERE bedroom_count = 2
GROUP BY bedroom_count;

-- Properties Older Than a 50 years:
-- The number of houses that are greater than 50 years is 1,917 that is 47.4% of the total houses.
SELECT count(age) AS property_age
FROM house
WHERE age > 50; 

SELECT
    (COUNT(CASE WHEN age > 50 THEN 1 ELSE NULL END) / COUNT(*)) * 100 AS percentage
FROM
    house;

-- Properties Closest to the Metro Station:
SELECT * FROM house
WHERE metro_distance = (SELECT MIN(metro_distance) FROM house);

-- Properties within $80,000 and $100,000 Price Range:
-- There are #3,552 properties within the price range of $80,000 and $100,000
SELECT count(*) FROM house
WHERE price BETWEEN 80000 AND 100000;

SELECT * FROM house
WHERE price BETWEEN 80000 AND 100000;

-- Properties with the Highest Net Square Meters:
-- The property with the highest net square meter is with 751, with 17 bedroom, and 80 years old; with a price of 118134.77118994546
SELECT * FROM house
WHERE net_sqm = (SELECT MAX(net_sqm) FROM house);

-- Properties Within a Certain Center of less than 500 meters Range:
-- 988 properties are less than 500 meters range
SELECT * FROM house
WHERE center_distance < 500;

-- Find the Oldest and Newest Apartments and Their Prices:

SELECT 
    CASE 
        WHEN age = (SELECT MAX(age) FROM house) THEN 'Newest'
        WHEN age = (SELECT MIN(age) FROM house) THEN 'Oldest'
        ELSE 'Other' 
    END AS age_category,
    age, price
FROM house
WHERE age = (SELECT MAX(age) FROM house) OR age = (SELECT MIN(age) FROM house);















