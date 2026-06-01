-- step 5 : sort and limit (top / bottom results)

-- top 10 products by sales
SELECT product_name, ROUND(SUM(sales)::numeric, 2) AS total_sales
FROM superstore
GROUP BY product_name
ORDER BY total_sales DESC
LIMIT 10;

-- bottom 10 products by sales
SELECT product_name, ROUND(SUM(sales)::numeric, 2) AS total_sales
FROM superstore
GROUP BY product_name
ORDER BY total_sales ASC
LIMIT 10;

-- top 5 states by revenue
SELECT state, ROUND(SUM(sales)::numeric, 2) AS total_sales
FROM superstore
GROUP BY state
ORDER BY total_sales DESC
LIMIT 5;
-- insight : california is #1 by far

-- top 5 cities by orders
SELECT city, state, COUNT(DISTINCT order_id) AS orders
FROM superstore
GROUP BY city, state
ORDER BY orders DESC
LIMIT 5;

-- top 10 most profitable orders
SELECT order_id, customer_name, product_name, profit
FROM superstore
ORDER BY profit DESC
LIMIT 10;

-- top 10 worst (biggest loss) orders
SELECT order_id, customer_name, product_name, profit
FROM superstore
ORDER BY profit ASC
LIMIT 10;

-- top sub-categories by quantity
SELECT sub_category, SUM(quantity) AS units
FROM superstore
GROUP BY sub_category
ORDER BY units DESC
LIMIT 5;