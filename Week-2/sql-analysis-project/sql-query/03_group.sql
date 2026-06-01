-- step 4 : group by aggregations

-- total sales by region
SELECT region, ROUND(SUM(sales)::numeric, 2) AS total_sales
FROM superstore
GROUP BY region
ORDER BY total_sales DESC;

-- sales and profit by category
SELECT
    category,
    ROUND(SUM(sales)::numeric, 2)  AS total_sales,
    ROUND(SUM(profit)::numeric, 2) AS total_profit
FROM superstore
GROUP BY category
ORDER BY total_sales DESC;

-- total quantity sold by category
SELECT category, SUM(quantity) AS units_sold
FROM superstore
GROUP BY category
ORDER BY units_sold DESC;

-- average order value by segment
SELECT segment, ROUND(AVG(sales)::numeric, 2) AS avg_order_value
FROM superstore
GROUP BY segment
ORDER BY avg_order_value DESC;

-- sales by year
SELECT
    EXTRACT(YEAR FROM order_date) AS yr,
    ROUND(SUM(sales)::numeric, 2) AS total_sales
FROM superstore
GROUP BY yr
ORDER BY yr;

-- orders count by region
SELECT region, COUNT(DISTINCT order_id) AS orders
FROM superstore
GROUP BY region
ORDER BY orders DESC;

-- sub-categories with sales above 100k (using HAVING)
SELECT sub_category, ROUND(SUM(sales)::numeric, 2) AS total_sales
FROM superstore
GROUP BY sub_category
HAVING SUM(sales) > 100000
ORDER BY total_sales DESC;

-- profit margin by category
SELECT
    category,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS margin_pct
FROM superstore
GROUP BY category
ORDER BY margin_pct DESC;