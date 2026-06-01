-- step 6 : business use cases

-- monthly sales trend
SELECT
    TO_CHAR(order_date, 'YYYY-MM') AS month,
    ROUND(SUM(sales)::numeric, 2)  AS monthly_sales
FROM superstore
GROUP BY month
ORDER BY month;
-- insight : nov-dec always spikes (holiday season)

-- quarterly trend
SELECT
    EXTRACT(YEAR    FROM order_date) AS yr,
    EXTRACT(QUARTER FROM order_date) AS qtr,
    ROUND(SUM(sales)::numeric, 2)    AS sales
FROM superstore
GROUP BY yr, qtr
ORDER BY yr, qtr;

-- top 10 customers by revenue
SELECT
    customer_name,
    ROUND(SUM(sales)::numeric, 2)  AS total_spent,
    COUNT(DISTINCT order_id)       AS orders
FROM superstore
GROUP BY customer_name
ORDER BY total_spent DESC
LIMIT 10;

-- top 10 customers by profit
SELECT
    customer_name,
    ROUND(SUM(profit)::numeric, 2) AS total_profit
FROM superstore
GROUP BY customer_name
ORDER BY total_profit DESC
LIMIT 10;

-- customers causing losses (negative profit)
SELECT
    customer_name,
    ROUND(SUM(sales)::numeric, 2)  AS sales,
    ROUND(SUM(profit)::numeric, 2) AS profit
FROM superstore
GROUP BY customer_name
HAVING SUM(profit) < 0
ORDER BY profit ASC;

-- check for duplicate rows (by row_id)
SELECT row_id, COUNT(*) AS cnt
FROM superstore
GROUP BY row_id
HAVING COUNT(*) > 1;
-- if no rows returned = no duplicates, good!

-- same product ordered twice in one order?
SELECT order_id, product_id, COUNT(*) AS cnt
FROM superstore
GROUP BY order_id, product_id
HAVING COUNT(*) > 1;