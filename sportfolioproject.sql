-- Creating and using the database portfolioproject
CREATE database portfolioproject

USE portfolioproject
SHOW tables;

-- Select data we are going to use `suicide m` table

SELECT *
FROM `suicide m`;

 -- Data cleaning of suicide dataset
 -- Adding id column 

ALTER TABLE `suicide m`
ADD COLUMN id int NOT NULL auto_increment Primary Key;
 
 -- checking for distinct number of users

 SELECT COUNT(DISTINCT(id))
 FROM `suicide m`;
 -- `suicide m` has 30556 users
 
 -- checking missing data

SELECT *
 FROM `suicide m`
 WHERE id IS NULL;
 
 -- deleting column HDI for year which will not use in analysis

 ALTER TABLE `suicide m`
 DROP COLUMN `HDI for year`

 --  Preview of the cleaned data 

 SELECT *
 FROM `suicide m`;

 -- ANALYZING OF DATA
 -- suicide no in russian federation
 
 SELECT country,SUM(suicides_no)
 FROM `suicide m`
 WHERE country LIKE'r%'
 GROUP BY 1
 ORDER BY 2 DESC;
 
 -- age with highest suicide cases
 
 SELECT age,SUM(suicides_no)
 FROM `suicide m`
 GROUP BY 1
 ORDER BY 2 DESC;
-- age with highest rate of suicide case is 35-54

-- gender with highest suicide cases
 
 SELECT sex,SUM(suicides_no)
 FROM `suicide m`
 GROUP BY sex
 ORDER BY 2 DESC;
 -- males have a high rate of suicide than female
 
 -- country with highest suicide numbers
 
 SELECT country,`gdp_for_year ($)`,SUM(suicides_no)
 FROM `suicide m`
 GROUP BY 1,2
 ORDER BY 3 DESC;
 -- Russian federation has highest suicide cases

 -- Looking at total suicides vs population
 -- shows what percentage of population has committed suicide
 
 SELECT country,year,population,SUM(suicides_no) AS total_suicidecases,(suicides_no/population)*100 AS suicide_percent
 FROM `suicide m`
 GROUP BY 1,2,3,5
 ORDER BY 5 DESC;

 -- Looking at countries with highest suicide rate as compared to the population
 -- Using CTE
 
 WITH t1 AS(
  SELECT country,population,SUM(suicides_no) AS sum_scases,(SUM(suicides_no)/population)*100 AS suicide_percent
 FROM `suicide m`
 GROUP BY 1,2)
 SELECT country,population,MAX(sum_scases),MAX(suicide_percent)
 FROM t1
 GROUP BY 1,2
 ORDER BY 4 DESC;
 -- Republic of Korea has the highest suicide rate as compared to the population
 
 -- Looking at population vs suicide_no 
 
 SELECT SUM(population),SUM(suicides_no),SUM(suicides_no)/SUM(population)*100 AS suicide_percent
 FROM `suicide m`
 ORDER BY 3;
 --  world suicide percent is 0.0048
 
 -- suicides vs GDP per capita
 
 SELECT country,SUM(suicides_no),SUM(`gdp_per_capita ($)`)
 FROM `suicide m`
 GROUP BY 1
 ORDER BY 3 DESC;
 -- Luxembourg has the highest sum per capita
 
 -- suicides vs generation
 
 SELECT SUM(suicides_no),generation
 FROM `suicide m`
 GROUP BY 2
 ORDER BY 1 DESC;
 -- generation boomers have  high suicide numbers
 
 -- age group with high suicide numbers
 
 SELECT SUM(suicides_no),age
 FROM `suicide m`
 GROUP BY 2
 ORDER BY 1 DESC;
-- 35-54 age group have high suicide_no

-- Creating View to store data for later visualization 
CREATE VIEW countrysuicides_no  AS
 SELECT country,SUM(suicides_no)
 FROM `suicide m`
 WHERE country LIKE'r%'
 -- GROUP BY 1
 -- ORDER BY 2 DESC;
 

 
 
 