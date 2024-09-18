# World Life Expectancy Project 

################
# Data Cleaning
################

# When SQL Safe Updates is turned ON, the DELETE query won't run. 
# Ensure Safe Updates is turned off, or set to 0.
SET SQL_SAFE_UPDATES = 0;

SELECT *
FROM world_life_expectancy;


# 1. Removing Duplicates
# Creating Unique IDs for each country per year entry
SELECT 
Country, 
Year, 
Concat(Country,Year), 
COUNT(Concat(Country,Year)) AS cnt
FROM world_life_expectancy
GROUP BY Country, Year, Concat(Country,Year)
HAVING cnt >1;

#Selecting Duplicates
SELECT *
FROM(
	SELECT Row_ID, 
	Concat(Country,Year),
	ROW_NUMBER() OVER( PARTITION BY Concat(Country,Year) ORDER BY Concat(Country,Year)) AS row_num
	FROM world_life_expectancy
    ) AS row_table
WHERE row_num >1
    ;
    
#Deleting Duplicates
DELETE FROM world_life_expectancy
WHERE 
	Row_ID IN (
    SELECT Row_ID
FROM(
	SELECT Row_ID, 
	Concat(Country,Year),
	ROW_NUMBER() OVER( PARTITION BY Concat(Country,Year) ORDER BY Concat(Country,Year)) AS row_num
	FROM world_life_expectancy
    ) AS row_table
WHERE row_num >1)
;


# 2. Populating Empty Statuses
SELECT DISTINCT(Status)
FROM world_life_expectancy
WHERE Status <>'';

SELECT DISTINCT(Country)
FROM world_life_expectancy
WHERE Status ='Developing';

# Update Query. Cannot Specify Target Table
UPDATE world_life_expectancy
SET Status = 'Developing'
WHERE Country IN (SELECT DISTINCT(Country)
					FROM world_life_expectancy
					WHERE Status ='Developing');
                    
# Updating Developing Countries' Status
JOIN world_life_expectancy t2
	ON t1.Country = t2.Country
SET t1.Status = 'Developing'
WHERE t1.Status = ''
AND t2.Status <> ''
AND t2.Status = 'Developing'
;

# Updating Developed Countries' Status
UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
	ON t1.Country = t2.Country
SET t1.Status = 'Developed'
WHERE t1.Status = ''
AND t2.Status <> ''
AND t2.Status = 'Developed'
;

# Final Check
SELECT * FROM world_life_expectancy
WHERE Status IS NULL;


# 3. Replacing Life Expectancy with Averages
# Finding out entries with blank life expectancy - Afghanistan and Albania - and finding the average
SELECT 
t1.Country, t1.Year, t1.`Lifeexpectancy`, 
t2.Country, t2.Year, t2.`Lifeexpectancy`,
t3.Country, t3.Year, t3.`Lifeexpectancy`,
ROUND((t2.Lifeexpectancy + t3.Lifeexpectancy)/2, 1) as average
FROM world_life_expectancy t1
JOIN world_life_expectancy t2
    ON t1.Country = t2.Country
    AND t1.Year = t2.Year - 1
JOIN world_life_expectancy t3
    ON t1.Country = t3.Country
    AND t1.Year = t3.Year + 1
WHERE t1.Lifeexpectancy = ''
;

# Updating the Table
UPDATE world_life_expectancy t1
JOIN world_life_expectancy t2
    ON t1.Country = t2.Country
    AND t1.Year = t2.Year - 1
JOIN world_life_expectancy t3
    ON t1.Country = t3.Country
    AND t1.Year = t3.Year + 1
SET t1.Lifeexpectancy = ROUND((t2.Lifeexpectancy + t3.Lifeexpectancy)/2, 1)
WHERE t1.Lifeexpectancy = ''
;

# Final Check
SELECT * FROM world_life_expectancy
WHERE Lifeexpectancy IS NULL;


################
# EDA
################

# NOT ZERO Minimum and Maximum Life Expectancy
SELECT Country,
MIN(`Lifeexpectancy`),
MAX(`Lifeexpectancy`),
ROUND(MAX(`Lifeexpectancy`) - MIN(`Lifeexpectancy`), 1) AS Life_Increase_15_Yrs
FROM world_life_expectancy
GROUP BY Country
HAVING MIN(`Lifeexpectancy`) <> 0
AND MAX(`Lifeexpectancy`) <> 0
ORDER BY Life_Increase_15_Yrs DESC;

# Average Life Expectancy By Country
SELECT Country,
ROUND(AVG(Lifeexpectancy),2) AS Average
FROM world_life_expectancy
GROUP BY Country
HAVING MIN(`Lifeexpectancy`) <> 0
AND MAX(`Lifeexpectancy`) <> 0
ORDER BY Average DESC;

# Average Life Expectancy By Year
SELECT Year,
ROUND(AVG(Lifeexpectancy),2) AS Average
FROM world_life_expectancy
WHERE `Lifeexpectancy` <> 0
AND `Lifeexpectancy` <> 0
GROUP BY Year
ORDER BY Year ASC;

# Joint Statement for Average Life Expectancy and Average GDP
SELECT Country, 
ROUND(AVG(`Lifeexpectancy`),2) AS Average_Life, 
ROUND(AVG(GDP),2) AS Average_GDP
FROM world_life_expectancy
GROUP BY Country
HAVING Average_Life > 0
AND Average_GDP > 0
ORDER BY Average_GDP ASC;

# Top/Bottom 50% Countries' GDP and Life Expectancy
SELECT
SUM(CASE WHEN GDP >= 1500 THEN 1 ELSE 0 END) High_GDP_Count,
AVG(CASE WHEN GDP >= 1500 THEN `Lifeexpectancy` ELSE NULL END) High_GDP_Life,
SUM(CASE WHEN GDP < 1500 THEN 1 ELSE 0 END) Low_GDP_Count,
AVG(CASE WHEN GDP < 1500 THEN `Lifeexpectancy` ELSE NULL END) Low_GDP_Life
FROM world_life_expectancy;

# Developing/Developed Status
SELECT Status, 
COUNT(DISTINCT(Country)) AS Count,
ROUND(AVG(`Lifeexpectancy`),1)
FROM world_life_expectancy
GROUP BY Status;

# BMI
SELECT Country,
       ROUND(AVG(Lifeexpectancy), 2) AS Average_Life, 
       ROUND(AVG(BMI), 2) AS Average_BMI
FROM world_life_expectancy
GROUP BY Country
HAVING AVG(Lifeexpectancy) > 0
   AND AVG(BMI) > 0
ORDER BY Average_BMI;

# Adult Mortality for Developed? Countries
SELECT Country,
Year,
`Lifeexpectancy`,
`AdultMortality`,
SUM(`AdultMortality`) OVER(PARTITION BY Country ORDER BY Year) AS Rolling_Total
FROM world_life_expectancy
WHERE Country LIKE '%United%';