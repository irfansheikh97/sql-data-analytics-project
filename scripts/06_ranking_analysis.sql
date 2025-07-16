/*
===============================================================================
Ranking Analysis
===============================================================================
Purpose:
    - To rank items (e.g., products, customers) based on performance or other metrics.
    - To identify top performers or laggards.

SQL Functions Used:
    - Window Ranking Functions: RANK(), DENSE_RANK(), ROW_NUMBER(), TOP
    - Clauses: GROUP BY, ORDER BY
===============================================================================
*/

-- Which 5 products Generating the Highest Revenue?
-- Simple Ranking
SELECT
	p.product_name,
    COALESCE(SUM(f.sales_amount),0) AS Total_Revenue
FROM dim_products p
LEFT JOIN fact_sales f
ON p.product_key = f.product_key
GROUP BY p.product_name
ORDER BY Total_Revenue DESC
LIMIT 5;

-- Complex but Flexibly Ranking Using Window Functions
SELECT 
	product_name,
    Total_Revenue
FROM (
	SELECT
		p.product_name,
		SUM(f.sales_amount) AS Total_Revenue,
		DENSE_RANK() OVER(ORDER BY SUM(f.sales_amount) DESC) AS ranks
	FROM dim_products p
	JOIN fact_sales f
	ON p.product_key = f.product_key
	GROUP BY p.product_name
	) t
WHERE ranks <= 5;


-- What are the 5 worst-performing products in terms of sales?
SELECT
	p.product_name,
    SUM(f.sales_amount) AS Total_Revenue
FROM dim_products p
JOIN fact_sales f
ON p.product_key = f.product_key
GROUP BY p.product_name
ORDER BY Total_Revenue
LIMIT 5;

-- Find the top 10 customers who have generated the highest revenue
SELECT
	customer_key,
    first_name,
    last_name,
    Highest_Revenue_Generated
FROM (
	SELECT
		c.customer_key,
		c.first_name,
		c.last_name,
		SUM(f.sales_amount) AS Highest_Revenue_Generated,
		DENSE_RANK() OVER(ORDER BY SUM(f.sales_amount) DESC) AS ranks
	FROM dim_customers c
	LEFT JOIN fact_sales f
	ON c.customer_key = f.customer_key
	GROUP BY c.customer_key, c.first_name, c.last_name
	) t
WHERE ranks <= 10;

-- The 3 customers with the fewest orders placed
SELECT
	c.customer_key,
	c.first_name,
	c.last_name,
	COUNT(DISTINCT f.order_number) AS Total_orders_placed
FROM dim_customers c
JOIN fact_sales f
ON c.customer_key = f.customer_key
GROUP BY c.customer_key, c.first_name, c.last_name
ORDER BY Total_orders_placed
LIMIT 3;
