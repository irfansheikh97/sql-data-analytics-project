/*
===============================================================================
Cumulative Analysis
===============================================================================
Purpose:
    - To calculate running totals or moving averages for key metrics.
    - To track performance over time cumulatively.
    - Useful for growth analysis or identifying long-term trends.

SQL Functions Used:
    - Window Functions: SUM() OVER(), AVG() OVER()
===============================================================================
*/

-- Calculate the total sales per month 
-- and the running total of sales over time 
SELECT
order_date,
Total_sales,
SUM(Total_sales) OVER(ORDER BY order_date) AS RunningTotal
FROM (
	SELECT
	DATE_FORMAT(DATE_ADD(order_date, INTERVAL 1 - DAYOFMONTH(order_date) DAY), '%Y-%m-01') AS order_date,
	SUM(sales_amount) AS Total_sales
	FROM fact_sales
	WHERE order_date IS NOT NULL
	GROUP BY DATE_FORMAT(DATE_ADD(order_date, INTERVAL 1 - DAYOFMONTH(order_date) DAY), '%Y-%m-01')
) t;