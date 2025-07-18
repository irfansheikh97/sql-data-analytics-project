/*
===============================================================================
Magnitude Analysis
===============================================================================
Purpose:
    - To quantify data and group results by specific dimensions.
    - For understanding data distribution across categories.

SQL Functions Used:
    - Aggregate Functions: SUM(), COUNT(), AVG()
    - GROUP BY, ORDER BY
===============================================================================
*/

-- Find total customers by countries
SELECT
	country,
	COUNT(*) AS Total_customers
FROM dim_customers
GROUP BY country
ORDER BY Total_customers DESC;

-- Find total customers by gender
SELECT
	gender,
	COUNT(*) AS Total_customers
FROM dim_customers
GROUP BY gender
ORDER BY Total_customers DESC;

-- Find total products by category
SELECT
	category,
	COUNT(product_key) AS Total_products
FROM dim_products
GROUP BY category
ORDER BY Total_products DESC;

-- What is the average costs in each category?
SELECT
	category,
	AVG(cost) AS Avg_Cost
FROM dim_products
WHERE category IS NOT NULL
GROUP BY category
ORDER BY Avg_Cost DESC;

-- What is the total revenue generated for each category?
SELECT
	p.category,
	COALESCE(SUM(f.sales_amount),0) AS Total_Revenue
FROM dim_products p
LEFT JOIN fact_sales f
ON p.product_key = f.product_key
WHERE P.category IS NOT NULL
GROUP BY p.category
ORDER BY Total_Revenue DESC;

-- What is the total revenue generated by each customer?
SELECT
	c.customer_key,
    CONCAT(c.first_name, ' ', c.last_name) AS Full_name,
	COALESCE(SUM(f.sales_amount),0) AS Total_Revenue
FROM dim_customers c
LEFT JOIN fact_sales f
ON c.customer_key = f.customer_key
GROUP BY c.customer_key, CONCAT(c.first_name, ' ', c.last_name)
ORDER BY Total_Revenue DESC;

-- What is the distribution of sold items across countries?
SELECT
	c.country,
	SUM(f.quantity) AS Total_items_sold
FROM dim_customers c
LEFT JOIN fact_sales f
ON c.customer_key = f.customer_key
GROUP BY c.country
ORDER BY Total_items_sold DESC;


