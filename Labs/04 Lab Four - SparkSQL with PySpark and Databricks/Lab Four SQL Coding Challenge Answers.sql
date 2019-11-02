-- Databricks notebook source
--How many houses are in the dataset?
SELECT COUNT(*) 
FROM housing_data

-- COMMAND ----------

--What year were the oldest and youngest houses built?
SELECT MAX(YearBuilt) AS MostRecentYearBuilt, MIN(YearBuilt) AS OldestYearBuilt
FROM housing_data

-- COMMAND ----------

--How many houses does each neighborhood have?
SELEcT Neighborhood, COUNT(*) AS NumberOfHomes
FROM housing_data
GROUP BY Neighborhood

-- COMMAND ----------

--How many houses that have 3 bedrooms above ground were sold in 2008?
SELECT COUNT(*)
FROM housing_data
WHERE 1 = 1
AND YrSold = 2008
AND TotRmsAbvGrd = 3

-- COMMAND ----------

--What is the maximum number of years between a house being built and it being sold?
SELECT MAX(YrSold - YearBuilt)
FROM housing_data

-- COMMAND ----------

--What is the average sale price of houses with a total basement square footage between 1000 and 2000 sqft.?
SELECT AVG(SalePrice)
FROM housing_data
WHERE totalbsmtsf BETWEEN 1000 AND 2000

-- COMMAND ----------

--How many kinds of foundation are there?
SELECT DISTINCT foundation
FROM housing_data

-- COMMAND ----------

--How many houses have fireplaces, attached garages and can be found, in OldTown, BrkSide, or Veenker neighborhood?
SELECT COUNT(*)
FROM housing_data
WHERE 1 = 1
AND Fireplaces > 0
AND garagetype =  'Attchd'
AND neighborhood IN ('OldTown','BrkSide','Veenker')

-- COMMAND ----------

--What is the average sale price of a house if they have been on the market (MoSold), for the longest amount of time found in the dataset?
SELECT AVG(SalePrice)
FROM housing_data
WHERE MoSold = (SELECT MAX(MoSold) FROM housing_data)

-- COMMAND ----------

--How many houses fall within one standard deviation of the average house price? (Hint: Use SparkSQL standard, not ANSI!)
SELECT COUNT(*)
FROM housing_data
WHERE 1 = 1
AND SalePrice <= (SELECT AVG(SalePrice) + STD(SalePrice) FROM housing_data)
AND SalePrice >= (SELECT AVG(SalePrice) - STD(SalePrice) FROM housing_data)
