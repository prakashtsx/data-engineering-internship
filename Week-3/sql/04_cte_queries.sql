-- Superstore Sales Analysis Using SQL
-- File: 04_cte_queries.sql
-- Purpose: CTE-based analysis questions.

-- Q6. Calculate total sales per customer.
WITH customer_sales AS (
    SELECT customer_id, SUM(sales) AS total_sales
    FROM orders
    GROUP BY customer_id
)
SELECT c.customer_id, c.customer_name, cs.total_sales
FROM customer_sales cs
JOIN customers c ON c.customer_id = cs.customer_id;

-- Q7. Calculate total profit per customer.
WITH customer_profit AS (
    SELECT customer_id, SUM(profit) AS total_profit
    FROM orders
    GROUP BY customer_id
)
SELECT c.customer_id, c.customer_name, cp.total_profit
FROM customer_profit cp
JOIN customers c ON c.customer_id = cp.customer_id;

-- Q8. Calculate total quantity purchased by each customer.
WITH customer_quantity AS (
    SELECT customer_id, SUM(quantity) AS total_quantity
    FROM orders
    GROUP BY customer_id
)
SELECT c.customer_id, c.customer_name, cq.total_quantity
FROM customer_quantity cq
JOIN customers c ON c.customer_id = cq.customer_id;

-- Q9. Find customers whose sales are above average customer sales.
WITH customer_sales AS (
    SELECT customer_id, SUM(sales) AS total_sales
    FROM orders
    GROUP BY customer_id
),
avg_sales AS (
    SELECT AVG(total_sales) AS avg_customer_sales
    FROM customer_sales
)
SELECT c.customer_id, c.customer_name, cs.total_sales
FROM customer_sales cs
JOIN customers c ON c.customer_id = cs.customer_id
CROSS JOIN avg_sales a
WHERE cs.total_sales > a.avg_customer_sales;

-- Q10. Find customers generating more than 10000 sales.
WITH customer_sales AS (
    SELECT customer_id, SUM(sales) AS total_sales
    FROM orders
    GROUP BY customer_id
)
SELECT c.customer_id, c.customer_name, cs.total_sales
FROM customer_sales cs
JOIN customers c ON c.customer_id = cs.customer_id
WHERE cs.total_sales > 10000;