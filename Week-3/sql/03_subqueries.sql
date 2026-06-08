-- Superstore Sales Analysis Using SQL
-- File: 03_subqueries.sql
-- Purpose: Subquery-based analysis questions.

-- Q1. Find all orders having sales greater than average sales.
SELECT *
FROM orders
WHERE sales > (SELECT AVG(sales) FROM orders);

-- Q2. Find highest sales order for every customer.
SELECT o.*
FROM orders o
WHERE o.sales = (
    SELECT MAX(o2.sales)
    FROM orders o2
    WHERE o2.customer_id = o.customer_id
);

-- Q3. Find customers whose total sales exceed average customer sales.
SELECT c.customer_id, c.customer_name,
       (SELECT SUM(o.sales)
        FROM orders o
        WHERE o.customer_id = c.customer_id) AS total_sales
FROM customers c
WHERE (
    SELECT SUM(o.sales)
    FROM orders o
    WHERE o.customer_id = c.customer_id
) > (
    SELECT AVG(customer_sales)
    FROM (
        SELECT SUM(sales) AS customer_sales
        FROM orders
        GROUP BY customer_id
    ) AS customer_totals
);

-- Q4. Find products whose total sales exceed average product sales.
SELECT p.product_id, p.product_name,
       (SELECT SUM(o.sales)
        FROM orders o
        WHERE o.product_id = p.product_id) AS total_sales
FROM products p
WHERE (
    SELECT SUM(o.sales)
    FROM orders o
    WHERE o.product_id = p.product_id
) > (
    SELECT AVG(product_sales)
    FROM (
        SELECT SUM(sales) AS product_sales
        FROM orders
        GROUP BY product_id
    ) AS product_totals
);

-- Q5. Find orders with profit greater than average profit.
SELECT *
FROM orders
WHERE profit > (SELECT AVG(profit) FROM orders);