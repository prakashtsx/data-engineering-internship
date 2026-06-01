-- step 7 : validate results / data quality

-- total rows (should be 9994)
SELECT COUNT(*) FROM superstore;

-- check for nulls in important columns
SELECT
    COUNT(*) - COUNT(order_id)     AS null_order_id,
    COUNT(*) - COUNT(customer_id)  AS null_customer_id,
    COUNT(*) - COUNT(sales)        AS null_sales,
    COUNT(*) - COUNT(profit)       AS null_profit,
    COUNT(*) - COUNT(order_date)   AS null_order_date
FROM superstore;
-- all should be 0

-- any negative sales? (shouldn't happen)
SELECT COUNT(*) FROM superstore WHERE sales <= 0;

-- any bad discount values? (should be 0.0 to 1.0)
SELECT COUNT(*) FROM superstore WHERE discount < 0 OR discount > 1;

-- ship date should never be before order date
SELECT COUNT(*) FROM superstore WHERE ship_date < order_date;

-- discount distribution (spot unusual values)
SELECT discount, COUNT(*) AS cnt
FROM superstore
GROUP BY discount
ORDER BY discount;

-- unexpected region values?
SELECT DISTINCT region FROM superstore
WHERE region NOT IN ('East','West','Central','South');

-- final data quality summary
SELECT
    COUNT(*)                    AS total_rows,
    COUNT(DISTINCT order_id)    AS unique_orders,
    COUNT(DISTINCT customer_id) AS unique_customers,
    MIN(order_date)             AS from_date,
    MAX(order_date)             AS to_date,
    ROUND(SUM(sales)::numeric, 2)  AS total_revenue,
    ROUND(SUM(profit)::numeric, 2) AS total_profit
FROM superstore;