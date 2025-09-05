----Select * from RetailSales

----SELECT COUNT (*) 
----from RetailSales

----Select * from RetailSales
----WHERE transactions_id is NULL

----Select * from RetailSales
----WHERE sale_date is NULL

----Select * from RetailSales
----WHERE sale_time is NULL

Select * from RetailSales
WHERE 
	transactions_id IS NULL
	OR
	sale_date IS NULL
	OR
	sale_time IS NULL
	OR
	customer_id IS NULL
	OR
	gender IS NULL
	OR 
	category IS NULL
	OR
	quantiy IS NULL
	OR
	cogs IS NULL
	OR
	total_sale IS NULL

	-- Data cleaning

DELETE FROM RetailSales
WHERE 
	transactions_id IS NULL
	OR
	sale_date IS NULL
	OR
	sale_time IS NULL
	OR
	customer_id IS NULL
	OR
	gender IS NULL
	OR 
	category IS NULL
	OR
	quantiy IS NULL
	OR
	cogs IS NULL
	OR
	total_sale IS NULL


-- Data Exploration

-- How many sales do we have?
SELECT COUNT (*) as total_sales FROM RetailSales

--1997 sales after removing 3 rows with incomplete data

-- How many unique customers do we have?  -155
SELECT COUNT (DISTINCT Customer_id) as no_cust FROM RetailSales

 -- How many categories do we have?  - 3
 SELECT COUNT (DISTINCT category)as no_cateory FROM RetailSales

 -- what are the category names?  - Clothing, Electronics, Beauty
 SELECT DISTINCT category 
 FROM RetailSales

 -- Data Analysis & Business Key Problems and Answers
  -- Q1 Write an SQL query to retrieve all the columns for sales made on '2022-11-05'

  SELECT * FROM RetailSales
  WHERE sale_date = '2022-11-05'

  --Q2 Write a SQL query to retrieve all the transactions where the 
  --category is clothing and the quantity sold is more than 4
  -- and is in the month of November 2022
  
SELECT *
FROM RetailSales
WHERE category = 'Clothing'
	AND sale_date >= '2022-11-01'
	AND sale_date < '2022-12-01'
	AND quantiy >= 4

--Q3 Write and SQL query to calculate the total sales for each category

SELECT 
	category,
	SUM (total_sale) as net_sale,
	COUNT (*) AS total_orders
FROM RetailSales
GROUP BY category;

--Q4. Write an SQL query to find the average age of customers who 
-- purchased from the beauty category

SELECT
	AVG(age) AS avg_age
FROM RetailSales
WHERE category = 'Beauty'

--Q5. Write an SQL query to find all transactions where
-- the total sales is greater than 1000

select * from RetailSales
WHERE total_sale > 1000

--Q6 Write a SQL query to find the total number of transactions 
-- made by each gender in each category

SELECT 
	category,
	gender,
	COUNT(*) AS TOTAL_TRANS
FROM RetailSales
GROUP BY
	category,
	gender
order by category

--Q7 Write a SQL query to calculate the average sale for each month
-- and find out the best selling month in each year

SELECT 
	year(sale_date) as year,
	month(sale_date) as month,
	AVG(total_sale) AS avg_sales
FROM RetailSales
Group BY year(sale_date),
		 month(sale_date)
Order By year,
		 avg_sales DESC;

-- Q8. Write an SQL query to find the top 5 customers based on the 
--highest total sales

Select TOP 5
	customer_id,
	SUM(total_sale) as total_sales
from retailsales
Group BY customer_id
Order BY total_sales DESC;

--Q9. Write an SQL query to find the number of unique customers who 
-- purchased items from each category

select 
	COUNT(Distinct customer_id) as unique_cust
	category
from RetailSales
GROUP BY category

-- Q10. Write a SQL query to create each shift and number of orders 
--(Example morning <= 12, afternoon 15 or 17, evening  >17

WITH hourly_sales  
AS
(
select *,
	CASE
		when DATEPART(HOUR, sale_time) < 12 then 'Morning' 
		when DATEPART(HOUR, sale_time) between 12 and 17 then 'Afternoon'
		else 'Evening'
	end as shift
from RetailSales
)
select
	shift,
	count (*) as total_orders
from hourly_sales
Group By shift

--  End of Project


	










