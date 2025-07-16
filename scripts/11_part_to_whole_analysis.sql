/*
===============================================================================
Part-to-Whole Analysis
===============================================================================
Purpose:
    - To compare performance or metrics across dimensions or time periods.
    - To evaluate differences between categories.
    - Useful for A/B testing or regional comparisons.

SQL Functions Used:
    - SUM(), AVG(): Aggregates values for comparison.
    - Window Functions: SUM() OVER() for total calculations.
===============================================================================
*/
-- Which categories contribute the most to overall sales?
WITH category_sales AS (
	SELECT
		p.category,
		SUM(f.sales_amount) AS Total_sales
	FROM fact_sales f
	LEFT JOIN dim_products p
	ON p.product_key = f.product_key
	WHERE P.category IS NOT NULL
	GROUP BY p.category
)

SELECT
	category,
    Total_sales,
    SUM(Total_sales) OVER() AS Overall_sales,
    ROUND((CAST(SUM(Total_sales) AS DOUBLE) / SUM(Total_sales) OVER()) * 100, 2) AS percentage_of_total
FROM category_sales
GROUP BY category
ORDER BY Total_sales DESC;