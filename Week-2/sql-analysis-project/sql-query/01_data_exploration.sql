-- 2.1  See the table structure (column names + data types)

SELECT
    column_name,
    data_type,
    character_maximum_length
FROM information_schema.columns
WHERE table_name = 'superstore'
ORDER BY ordinal_position;

-- 2.2  Preview first 10 rows of raw data

SELECT *
FROM superstore
LIMIT 10;


-- 2.3  Count total number of rows in the table

SELECT COUNT(*) AS total_rows
FROM superstore;


-- 2.4  Count distinct values in key categorical columns

SELECT
    COUNT(DISTINCT order_id)     AS unique_orders,
    COUNT(DISTINCT customer_id)  AS unique_customers,
    COUNT(DISTINCT product_id)   AS unique_products,
    COUNT(DISTINCT city)         AS unique_cities,
    COUNT(DISTINCT state)        AS unique_states
FROM superstore;


-- 2.5  See all unique regions

SELECT DISTINCT region
FROM superstore
ORDER BY region;


-- 2.6  See all unique categories and sub-categories

SELECT DISTINCT category, sub_category
FROM superstore
ORDER BY category, sub_category;


-- 2.7  See all unique customer segments

SELECT DISTINCT segment
FROM superstore
ORDER BY segment;


-- 2.8  Check date range of the dataset

SELECT
    MIN(order_date) AS earliest_order,
    MAX(order_date) AS latest_order
FROM superstore;


-- 2.9  Quick numeric summary (sales, quantity, profit)

SELECT
    ROUND(MIN(sales)::NUMERIC, 2)   AS min_sales,
    ROUND(MAX(sales)::NUMERIC, 2)   AS max_sales,
    ROUND(AVG(sales)::NUMERIC, 2)   AS avg_sales,

    MIN(quantity)                   AS min_qty,
    MAX(quantity)                   AS max_qty,

    ROUND(MIN(profit)::NUMERIC, 2)  AS min_profit,
    ROUND(MAX(profit)::NUMERIC, 2)  AS max_profit,
    ROUND(AVG(profit)::NUMERIC, 2)  AS avg_profit
FROM superstore;
