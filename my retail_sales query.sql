SHOW DATABASES;
USE SQL_PROJECT_P1;

CREATE TABLE RETAIL_SALES(
transactions_id INT PRIMARY KEY,
sale_date DATE,
sale_time TIME,
customer_id INT,
gender VARCHAR(15),
age INT,
category VARCHAR (30),
quantiy INT,
price_per_unit FLOAT,
cogs FLOAT,
total_sale FLOAT);

--DATA CLEANING

SELECT * FROM RETAIL_SALES LIMIT 10;

SELECT COUNT(*) FROM RETAIL_SALES;

SELECT * FROM RETAIL_SALES WHERE TRANSACTIONS_ID IS NULL;

SELECT
	*
FROM
	RETAIL_SALES
WHERE
	TRANSACTIONS_ID IS NULL
	OR SALE_DATE IS NULL
	OR SALE_TIME IS NULL
	OR GENDER IS NULL
	OR CATEGORY IS NULL
	OR QUANTIY IS NULL
	OR COGS IS NULL
	OR TOTAL_SALE IS NULL;

DELETE FROM RETAIL_SALES WHERE
	TRANSACTIONS_ID IS NULL
	OR SALE_DATE IS NULL
	OR SALE_TIME IS NULL
	OR GENDER IS NULL
	OR CATEGORY IS NULL
	OR QUANTIY IS NULL
	OR COGS IS NULL
	OR TOTAL_SALE IS NULL;

SELECT
	*
FROM
	RETAIL_SALES
WHERE
	TRANSACTIONS_ID IS NULL
	OR SALE_DATE IS NULL
	OR SALE_TIME IS NULL
	OR GENDER IS NULL
	OR CATEGORY IS NULL
	OR QUANTIY IS NULL
	OR COGS IS NULL
	OR TOTAL_SALE IS NULL;


SELECT COUNT(*) FROM RETAIL_SALES;


--DATA EXPLORATION

-- HOW MANY SALES WE HAVE

SELECT
	COUNT(*) AS TOTAL_SALES
FROM
	RETAIL_SALES;

-- HOW MANY UNIQUE CUSTOMERS WE HAVE

SELECT
	COUNT(DISTINCT CUSTOMER_ID) AS TOTAL_SALES
FROM
	RETAIL_SALES;

-- HOW MANY UNIQUE CATEGORY

SELECT
	DISTINCT CATEGORY
FROM
	RETAIL_SALES;


----- DATA ANALYSIS AND BUSINESS KEY PROBLEMS AND ANSWERS



-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)



-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05

SELECT
	*
FROM
	RETAIL_SALES
WHERE
	SALE_DATE = "2022-11-05";

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022

SELECT * FROM RETAIL_SALES
WHERE CATEGORY ="CLOTHING"
AND QUANTIY >=4
AND SALE_date >= '2022-11-01'
  AND SALE_date < '2022-12-01';

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

SELECT
	CATEGORY,
	SUM(TOTAL_SALE) AS NET_SALES,
	COUNT(*) AS TOTAL_ORDERS
FROM
	RETAIL_SALES
GROUP BY
	1;


-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

SELECT
	ROUND(AVG(AGE), '2')AS AVG_AGE
FROM
	RETAIL_SALES
WHERE
	CATEGORY = "BEAUTY";

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

SELECT
	*
FROM
	RETAIL_SALES
WHERE
	TOTAL_SALE>"1000";

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

SELECT
	CATEGORY,
	GENDER,
	COUNT(*)AS TOTAL_TRANSACTIONS
FROM
	RETAIL_SALES
GROUP BY
	CATEGORY ,
	GENDER
ORDER BY
	CATEGORY;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year


SELECT
	YEAR,
	MONTH,
	AVG_SALE
FROM
	(
	SELECT
		YEAR (SALE_DATE)AS YEAR,
		MONTH(SALE_DATE)AS MONTH,
		AVG(TOTAL_SALE)AS AVG_SALE,
		RANK() OVER(PARTITION BY YEAR(SALE_DATE)ORDER BY AVG(TOTAL_SALE)DESC)AS 'rank'
	FROM
		RETAIL_SALES
	GROUP BY
		1,
		2) AS T1
WHERE
	'RANK'= 1;


 Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
 
 SELECT
	CUSTOMER_ID,
	SUM(TOTAL_SALE)AS TOTAL_SALES
FROM
	RETAIL_SALES
GROUP BY
	1
ORDER BY
	2 DESC
LIMIT 5;

-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

SELECT
	CATEGORY,
	COUNT(DISTINCT CUSTOMER_ID)AS UNIQUE_CUSTOMERS
FROM
	RETAIL_SALES
GROUP BY
	CATEGORY; 


-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)


SELECT 
  CASE 
    WHEN HOUR(sale_time) < 12 THEN 'Morning'
    WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
    ELSE 'Evening'
  END AS shift,
  COUNT(*) AS number_of_orders
FROM RETAIL_SALES
GROUP BY shift;


--END OF PROJECT






