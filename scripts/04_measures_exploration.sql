/*
===============================================================================
Measures Exploration (Key Metrics)
===============================================================================
Purpose:
    - To calculate aggregated metrics (e.g., totals, averages) for quick insights.
    - To identify overall trends or spot anomalies.

SQL Functions Used:
    - COUNT(), SUM(), AVG()
===============================================================================
*/

-- Find the Total Sales
SELECT SUM(sales_amount) AS TOTAL_SALES FROM fact_sales;

-- Find how many items are sold
SELECT SUM(quantity) AS TOTAL_ITEMS_SOLD FROM fact_sales;

-- Find the average selling price
SELECT ROUND(AVG(price)) AS AVG_SELLING_PRICE FROM fact_sales;

-- Find the Total number of Orders
SELECT COUNT(order_number) AS TOTAL_ORDERS FROM fact_sales;
SELECT COUNT(DISTINCT order_number) AS TOTAL_ORDERS FROM fact_sales;

-- Find the total number of products
SELECT COUNT(DISTINCT product_name) AS TOTAL_PRODUCTS FROM dim_products;

-- Find the total number of customers
SELECT COUNT(customer_key) AS TOTAL_CUSTOMERS FROM dim_customers;

-- Find the total number of customers that has placed an order
SELECT COUNT(DISTINCT customer_key) AS TOTAL_CUSTOMERS FROM fact_sales;

-- Generate a Report that shows all key metrics of the business
SELECT 'Total Sales' AS measure_name, SUM(sales_amount) AS measure_value FROM fact_sales
UNION ALL
SELECT 'Total Order Quantity' AS measure_name, SUM(quantity) AS measure_value FROM fact_sales
UNION ALL
SELECT 'Avg Selling Price' AS measure_name, ROUND(AVG(price)) AS measure_value FROM fact_sales
UNION ALL
SELECT 'Total Orders' AS measure_name, COUNT(DISTINCT order_number) AS measure_value FROM fact_sales
UNION ALL
SELECT 'Total Products' AS measure_name, COUNT(DISTINCT product_name) AS measure_value FROM dim_products
UNION ALL
SELECT 'Total Customers' AS measure_name, COUNT(customer_key) AS measure_value FROM dim_customers;
