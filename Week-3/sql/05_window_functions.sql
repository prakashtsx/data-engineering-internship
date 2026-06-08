-- Superstore Sales Analysis Using SQL
-- File: 05_window_functions.sql
-- Purpose: Window function analysis questions.

-- Q11. Rank customers based on total sales.
WITH customer_sales AS (
    SELECT customer_id, SUM(sales) AS total_sales
    FROM orders
    GROUP BY customer_id
)
SELECT c.customer_id, c.customer_name, cs.total_sales,
       RANK() OVER (ORDER BY cs.total_sales DESC) AS sales_rank
FROM customer_sales cs
JOIN customers c ON c.customer_id = cs.customer_id;

-- Q12. Assign row numbers to each order within customers.
SELECT o.*,
       ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY order_date, row_id) AS order_number_within_customer
FROM orders o;

-- Q13. Find Top 3 customers.
WITH customer_sales AS (
    SELECT customer_id, SUM(sales) AS total_sales
    FROM orders
    GROUP BY customer_id
), ranked_customers AS (
    SELECT cs.customer_id, cs.total_sales,
           RANK() OVER (ORDER BY cs.total_sales DESC) AS sales_rank
    FROM customer_sales cs
)
SELECT c.customer_id, c.customer_name, rc.total_sales, rc.sales_rank
FROM ranked_customers rc
JOIN customers c ON c.customer_id = rc.customer_id
WHERE rc.sales_rank <= 3;

-- Q14. Find Top 10 customers.
WITH customer_sales AS (
    SELECT customer_id, SUM(sales) AS total_sales
    FROM orders
    GROUP BY customer_id
), ranked_customers AS (
    SELECT cs.customer_id, cs.total_sales,
           RANK() OVER (ORDER BY cs.total_sales DESC) AS sales_rank
    FROM customer_sales cs
)
SELECT c.customer_id, c.customer_name, rc.total_sales, rc.sales_rank
FROM ranked_customers rc
JOIN customers c ON c.customer_id = rc.customer_id
WHERE rc.sales_rank <= 10;

-- Q15. Find highest sale order per customer using ROW_NUMBER().
WITH ranked_orders AS (
    SELECT o.*,
           ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY sales DESC, order_date DESC, row_id DESC) AS rn
    FROM orders o
)
SELECT *
FROM ranked_orders
WHERE rn = 1;

-- Q16. Calculate cumulative sales.
SELECT o.*,
       SUM(sales) OVER (ORDER BY order_date, row_id) AS cumulative_sales
FROM orders o
ORDER BY order_date, row_id;

-- Q17. Calculate running profit.
SELECT o.*,
       SUM(profit) OVER (ORDER BY order_date, row_id) AS running_profit
FROM orders o
ORDER BY order_date, row_id;

-- Q18. Assign dense rank based on customer sales.
WITH customer_sales AS (
    SELECT customer_id, SUM(sales) AS total_sales
    FROM orders
    GROUP BY customer_id
)
SELECT c.customer_id, c.customer_name, cs.total_sales,
       DENSE_RANK() OVER (ORDER BY cs.total_sales DESC) AS sales_dense_rank
FROM customer_sales cs
JOIN customers c ON c.customer_id = cs.customer_id;

-- Q19. Find second highest customer sales.
WITH customer_sales AS (
    SELECT customer_id, SUM(sales) AS total_sales
    FROM orders
    GROUP BY customer_id
), ranked AS (
    SELECT customer_id, total_sales,
           DENSE_RANK() OVER (ORDER BY total_sales DESC) AS sales_rank
    FROM customer_sales
)
SELECT c.customer_id, c.customer_name, r.total_sales
FROM ranked r
JOIN customers c ON c.customer_id = r.customer_id
WHERE r.sales_rank = 2;

-- Q20. Find third highest customer sales.
WITH customer_sales AS (
    SELECT customer_id, SUM(sales) AS total_sales
    FROM orders
    GROUP BY customer_id
), ranked AS (
    SELECT customer_id, total_sales,
           DENSE_RANK() OVER (ORDER BY total_sales DESC) AS sales_rank
    FROM customer_sales
)
SELECT c.customer_id, c.customer_name, r.total_sales
FROM ranked r
JOIN customers c ON c.customer_id = r.customer_id
WHERE r.sales_rank = 3;