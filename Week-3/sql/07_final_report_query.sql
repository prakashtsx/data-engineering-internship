-- Superstore Sales Analysis Using SQL
-- File: 07_final_report_query.sql
-- Purpose: Final combined report using JOIN, CTE, and RANK().

WITH customer_totals AS (
    SELECT customer_id, SUM(sales) AS total_sales
    FROM orders
    GROUP BY customer_id
)
SELECT
    c.customer_name AS "Customer Name",
    ct.total_sales AS "Total Sales",
    RANK() OVER (ORDER BY ct.total_sales DESC) AS "Rank"
FROM customer_totals ct
JOIN customers c ON c.customer_id = ct.customer_id
ORDER BY "Rank", "Customer Name";