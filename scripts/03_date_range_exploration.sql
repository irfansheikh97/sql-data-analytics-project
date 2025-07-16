/*
===============================================================================
Date Range Exploration 
===============================================================================
Purpose:
    - To determine the temporal boundaries of key data points.
    - To understand the range of historical data.

SQL Functions Used:
    - MIN(), MAX(), DATEDIFF()
===============================================================================
*/

-- Determine the first and last order date and the total duration in months
SELECT
	MIN(order_date) AS FirstOrderDate,
	MAX(order_date) AS LastOrderDate,
    PERIOD_DIFF(DATE_FORMAT(MAX(order_date), '%Y%m'), DATE_FORMAT(MIN(order_date), '%Y%m')) AS 'TotalDurations(Months)'
FROM fact_sales;

-- Find the youngest and oldest customer based on birthdate
SELECT
	MIN(birthdate) AS YoungestCustomer,
	MAX(birthdate) AS OldestCustomer
FROM dim_customers;
