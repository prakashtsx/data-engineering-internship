-- FILE: 02_where_filter.sql
-- LESSON 3: Apply WHERE Filters (Region, Category, Date, Sales)
-- OBJECTIVE: Filter rows based on specific conditions



-- 3.1  Filter by REGION — show only West region orders

SELECT *
FROM superstore
WHERE region = 'West'
LIMIT 10;


-- 3.2  Filter by CATEGORY — only Technology products

SELECT *
FROM superstore
WHERE category = 'Technology'
LIMIT 10;


-- 3.3  Filter by SUB-CATEGORY — only Phones

SELECT
    order_id,
    customer_name,
    product_name,
    sales,
    profit
FROM superstore
WHERE sub_category = 'Phones';


-- 3.4  Filter by DATE RANGE — orders placed in year 2017

SELECT
    order_id,
    order_date,
    customer_name,
    sales
FROM superstore
WHERE order_date BETWEEN '2017-01-01' AND '2017-12-31'
ORDER BY order_date;


-- 3.5  Filter by SALES threshold — high-value orders (> $500)

SELECT
    order_id,
    customer_name,
    product_name,
    sales
FROM superstore
WHERE sales > 500
ORDER BY sales DESC;


-- 3.6  Filter by NEGATIVE PROFIT (loss-making orders)

SELECT
    order_id,
    customer_name,
    product_name,
    sales,
    profit
FROM superstore
WHERE profit < 0
ORDER BY profit ASC;  


-- 3.7  Combine filters using AND

SELECT
    order_id,
    customer_name,
    category,
    region,
    sales,
    profit
FROM superstore
WHERE category = 'Technology'
  AND region   = 'West';


-- 3.8  Combine filters using OR

SELECT
    order_id,
    customer_name,
    state,
    sales
FROM superstore
WHERE state = 'California'
   OR state = 'New York'
ORDER BY state;


-- 3.9  Use IN — multiple category values in one filter

SELECT
    order_id,
    category,
    sub_category,
    sales
FROM superstore
WHERE sub_category IN ('Chairs', 'Tables', 'Bookcases')
ORDER BY sub_category;


-- 3.10 Use LIKE — search product names containing "Samsung"

SELECT
    product_id,
    product_name,
    sales
FROM superstore
WHERE product_name LIKE '%Samsung%';




-- 3.11 Filter rows where discount was applied (> 0)

SELECT
    order_id,
    product_name,
    discount,
    sales,
    profit
FROM superstore
WHERE discount > 0
ORDER BY discount DESC;


-- 3.12 Filter by SEGMENT — Consumer customers only

SELECT
    customer_id,
    customer_name,
    segment,
    sales
FROM superstore
WHERE segment = 'Consumer'
LIMIT 10;