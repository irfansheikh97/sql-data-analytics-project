/*
=============================================================
Create Database and Schemas
=============================================================
Script Purpose:
    This script creates a new database named 'DataWarehouseAnalytics' after checking if it already exists. 
    If the database exists, it is dropped and recreated. Additionally, this script creates a schema called gold
	
WARNING:
    Running this script will drop the entire 'DataWarehouseAnalytics' database if it exists. 
    All data in the database will be permanently deleted. Proceed with caution 
    and ensure you have proper backups before running this script.
*/

-- Drop and recreate the 'DataWarehouseAnalytics' database
DROP DATABASE IF EXISTS DataWarehouseAnalytics;

-- Create the 'DataWarehouseAnalytics' database
CREATE DATABASE DataWarehouseAnalytics;

USE DataWarehouseAnalytics;

-- Create Schemas
DROP TABLE IF EXISTS dim_customers;
CREATE TABLE dim_customers(
	customer_key INT,
	customer_id INT,
	customer_number VARCHAR(50),
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	country VARCHAR(50),
	marital_status VARCHAR(50),
	gender VARCHAR(50),
	birthdate DATE,
	create_date DATE
);

DROP TABLE IF EXISTS dim_products;
CREATE TABLE dim_products(
	product_key INT,
	product_id INT,
	product_number VARCHAR(50),
	product_name VARCHAR(50),
	category_id VARCHAR(50),
	category VARCHAR(50),
	subcategory VARCHAR(50),
	maintenance VARCHAR(50),
	cost INT,
	product_line VARCHAR(50),
	start_date DATE 
);

DROP TABLE IF EXISTS fact_sales;
CREATE TABLE fact_sales(
	order_number VARCHAR(50),
	product_key INT,
	customer_key INT,
	order_date DATE,
	shipping_date DATE,
	due_date DATE,
	sales_amount INT,
	quantity INT,
	price INT 
);


TRUNCATE TABLE dim_customers;
LOAD DATA LOCAL INFILE 'C:\\Users\\welcome\\Desktop\\SQL_DATA_ANALYTICS_PROJECT\\sql-data-analytics-project\\myprojectversion\\datasets\\dim_customers.csv'
INTO TABLE dim_customers
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(customer_key, customer_id, customer_number, first_name, last_name, country, marital_status, gender, @birthdate, create_date)
SET birthdate = NULLIF(@birthdate, '');

TRUNCATE TABLE dim_products;
LOAD DATA LOCAL INFILE 'C:\\Users\\welcome\\Desktop\\SQL_DATA_ANALYTICS_PROJECT\\sql-data-analytics-project\\myprojectversion\\datasets\\dim_products.csv'
INTO TABLE dim_products
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(product_key, product_id, product_number, product_name, category_id, @category, @subcategory, @maintenance, cost, product_line, start_date)
SET category = NULLIF(@category, ''),
	subcategory = NULLIF(@subcategory, ''),
    maintenance = NULLIF(@maintenance, '');
    
TRUNCATE TABLE fact_sales;
LOAD DATA LOCAL INFILE 'C:\\Users\\welcome\\Desktop\\SQL_DATA_ANALYTICS_PROJECT\\sql-data-analytics-project\\myprojectversion\\datasets\\fact_sales.csv'
INTO TABLE fact_sales
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(order_number, product_key, customer_key, @order_date, shipping_date, due_date, sales_amount, quantity, price)
SET order_date = NULLIF(@order_date, '');




