-- Superstore Sales Analysis Using SQL
-- File: 06_business_queries.sql
-- Purpose: Business analysis questions Q21-Q70.

-- CUSTOMER ANALYSIS

-- Q21. Who are the Top 5 customers?
WITH customer_sales AS (
    SELECT customer_id, SUM(sales) AS total_sales
    FROM orders
    GROUP BY customer_id
)
SELECT c.customer_name, cs.total_sales
FROM customer_sales cs
JOIN customers c ON c.customer_id = cs.customer_id
ORDER BY cs.total_sales DESC
FETCH FIRST 5 ROWS ONLY;

-- Q22. Who are the Bottom 5 customers?
WITH customer_sales AS (
    SELECT customer_id, SUM(sales) AS total_sales
    FROM orders
    GROUP BY customer_id
)
SELECT c.customer_name, cs.total_sales
FROM customer_sales cs
JOIN customers c ON c.customer_id = cs.customer_id
ORDER BY cs.total_sales ASC
FETCH FIRST 5 ROWS ONLY;

-- Q23. Which customers placed only one order?
SELECT c.customer_id, c.customer_name, COUNT(DISTINCT o.order_id) AS order_count
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(DISTINCT o.order_id) = 1;

-- Q24. Which customers placed more than 10 orders?
SELECT c.customer_id, c.customer_name, COUNT(DISTINCT o.order_id) AS order_count
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING COUNT(DISTINCT o.order_id) > 10;

-- Q25. Which customers have above-average sales?
WITH customer_sales AS (
    SELECT customer_id, SUM(sales) AS total_sales
    FROM orders
    GROUP BY customer_id
)
SELECT c.customer_id, c.customer_name, cs.total_sales
FROM customer_sales cs
JOIN customers c ON c.customer_id = cs.customer_id
WHERE cs.total_sales > (SELECT AVG(total_sales) FROM customer_sales);

-- Q26. Which customers generated highest profit?
WITH customer_profit AS (
    SELECT customer_id, SUM(profit) AS total_profit
    FROM orders
    GROUP BY customer_id
)
SELECT c.customer_id, c.customer_name, cp.total_profit
FROM customer_profit cp
JOIN customers c ON c.customer_id = cp.customer_id
ORDER BY cp.total_profit DESC
FETCH FIRST 1 ROW ONLY;

-- Q27. Which customer purchased maximum quantity?
WITH customer_qty AS (
    SELECT customer_id, SUM(quantity) AS total_quantity
    FROM orders
    GROUP BY customer_id
)
SELECT c.customer_id, c.customer_name, cq.total_quantity
FROM customer_qty cq
JOIN customers c ON c.customer_id = cq.customer_id
ORDER BY cq.total_quantity DESC
FETCH FIRST 1 ROW ONLY;

-- Q28. Which customer has highest order value?
SELECT c.customer_id, c.customer_name, o.order_id, o.sales
FROM orders o
JOIN customers c ON c.customer_id = o.customer_id
ORDER BY o.sales DESC, o.order_date DESC
FETCH FIRST 1 ROW ONLY;

-- Q29. Which customer has lowest order value?
SELECT c.customer_id, c.customer_name, o.order_id, o.sales
FROM orders o
JOIN customers c ON c.customer_id = o.customer_id
ORDER BY o.sales ASC, o.order_date ASC
FETCH FIRST 1 ROW ONLY;

-- Q30. Which customers never generated profit?
SELECT c.customer_id, c.customer_name, SUM(o.profit) AS total_profit
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING SUM(o.profit) <= 0;

-- PRODUCT ANALYSIS

-- Q31. Top 5 products by sales.
SELECT p.product_id, p.product_name, SUM(o.sales) AS total_sales
FROM products p
JOIN orders o ON o.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_sales DESC
FETCH FIRST 5 ROWS ONLY;

-- Q32. Bottom 5 products by sales.
SELECT p.product_id, p.product_name, SUM(o.sales) AS total_sales
FROM products p
JOIN orders o ON o.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_sales ASC
FETCH FIRST 5 ROWS ONLY;

-- Q33. Top 5 products by profit.
SELECT p.product_id, p.product_name, SUM(o.profit) AS total_profit
FROM products p
JOIN orders o ON o.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_profit DESC
FETCH FIRST 5 ROWS ONLY;

-- Q34. Most sold product.
SELECT p.product_id, p.product_name, SUM(o.quantity) AS total_quantity
FROM products p
JOIN orders o ON o.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_quantity DESC
FETCH FIRST 1 ROW ONLY;

-- Q35. Least sold product.
SELECT p.product_id, p.product_name, SUM(o.quantity) AS total_quantity
FROM products p
JOIN orders o ON o.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_quantity ASC
FETCH FIRST 1 ROW ONLY;

-- Q36. Highest revenue generating category.
SELECT p.category, SUM(o.sales) AS total_sales
FROM products p
JOIN orders o ON o.product_id = p.product_id
GROUP BY p.category
ORDER BY total_sales DESC
FETCH FIRST 1 ROW ONLY;

-- Q37. Lowest revenue generating category.
SELECT p.category, SUM(o.sales) AS total_sales
FROM products p
JOIN orders o ON o.product_id = p.product_id
GROUP BY p.category
ORDER BY total_sales ASC
FETCH FIRST 1 ROW ONLY;

-- Q38. Highest profit generating sub-category.
SELECT p.sub_category, SUM(o.profit) AS total_profit
FROM products p
JOIN orders o ON o.product_id = p.product_id
GROUP BY p.sub_category
ORDER BY total_profit DESC
FETCH FIRST 1 ROW ONLY;

-- Q39. Lowest profit generating sub-category.
SELECT p.sub_category, SUM(o.profit) AS total_profit
FROM products p
JOIN orders o ON o.product_id = p.product_id
GROUP BY p.sub_category
ORDER BY total_profit ASC
FETCH FIRST 1 ROW ONLY;

-- Q40. Products with above-average sales.
WITH product_sales AS (
    SELECT product_id, SUM(sales) AS total_sales
    FROM orders
    GROUP BY product_id
)
SELECT p.product_id, p.product_name, ps.total_sales
FROM product_sales ps
JOIN products p ON p.product_id = ps.product_id
WHERE ps.total_sales > (SELECT AVG(total_sales) FROM product_sales);

-- REGIONAL ANALYSIS

-- Q41. Top performing region.
SELECT c.region, SUM(o.sales) AS total_sales
FROM orders o
JOIN customers c ON c.customer_id = o.customer_id
GROUP BY c.region
ORDER BY total_sales DESC
FETCH FIRST 1 ROW ONLY;

-- Q42. Lowest performing region.
SELECT c.region, SUM(o.sales) AS total_sales
FROM orders o
JOIN customers c ON c.customer_id = o.customer_id
GROUP BY c.region
ORDER BY total_sales ASC
FETCH FIRST 1 ROW ONLY;

-- Q43. Region with highest profit.
SELECT c.region, SUM(o.profit) AS total_profit
FROM orders o
JOIN customers c ON c.customer_id = o.customer_id
GROUP BY c.region
ORDER BY total_profit DESC
FETCH FIRST 1 ROW ONLY;

-- Q44. Region with highest quantity sold.
SELECT c.region, SUM(o.quantity) AS total_quantity
FROM orders o
JOIN customers c ON c.customer_id = o.customer_id
GROUP BY c.region
ORDER BY total_quantity DESC
FETCH FIRST 1 ROW ONLY;

-- Q45. State with highest sales.
SELECT c.state, SUM(o.sales) AS total_sales
FROM orders o
JOIN customers c ON c.customer_id = o.customer_id
GROUP BY c.state
ORDER BY total_sales DESC
FETCH FIRST 1 ROW ONLY;

-- Q46. State with highest profit.
SELECT c.state, SUM(o.profit) AS total_profit
FROM orders o
JOIN customers c ON c.customer_id = o.customer_id
GROUP BY c.state
ORDER BY total_profit DESC
FETCH FIRST 1 ROW ONLY;

-- Q47. Top 10 cities by sales.
SELECT c.city, SUM(o.sales) AS total_sales
FROM orders o
JOIN customers c ON c.customer_id = o.customer_id
GROUP BY c.city
ORDER BY total_sales DESC
FETCH FIRST 10 ROWS ONLY;

-- Q48. Top 10 cities by profit.
SELECT c.city, SUM(o.profit) AS total_profit
FROM orders o
JOIN customers c ON c.customer_id = o.customer_id
GROUP BY c.city
ORDER BY total_profit DESC
FETCH FIRST 10 ROWS ONLY;

-- PROFIT ANALYSIS

-- Q49. Total company profit.
SELECT SUM(profit) AS total_company_profit
FROM orders;

-- Q50. Average profit per order.
SELECT AVG(profit) AS average_profit_per_order
FROM orders;

-- Q51. Most profitable order.
SELECT order_id, row_id, sales, profit
FROM orders
ORDER BY profit DESC
FETCH FIRST 1 ROW ONLY;

-- Q52. Least profitable order.
SELECT order_id, row_id, sales, profit
FROM orders
ORDER BY profit ASC
FETCH FIRST 1 ROW ONLY;

-- Q53. Profit percentage by category.
SELECT p.category,
       SUM(o.profit) AS total_profit,
       SUM(o.sales) AS total_sales,
       CASE WHEN SUM(o.sales) = 0 THEN 0 ELSE ROUND((SUM(o.profit) / SUM(o.sales)) * 100, 2) END AS profit_percentage
FROM products p
JOIN orders o ON o.product_id = p.product_id
GROUP BY p.category;

-- Q54. Loss-making products.
SELECT p.product_id, p.product_name, SUM(o.profit) AS total_profit
FROM products p
JOIN orders o ON o.product_id = p.product_id
GROUP BY p.product_id, p.product_name
HAVING SUM(o.profit) < 0
ORDER BY total_profit ASC;

-- Q55. Loss-making customers.
SELECT c.customer_id, c.customer_name, SUM(o.profit) AS total_profit
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING SUM(o.profit) < 0
ORDER BY total_profit ASC;

-- ADVANCED SQL ANALYSIS

-- Q56. Monthly sales trend.
SELECT EXTRACT(YEAR FROM order_date) AS sales_year,
       EXTRACT(MONTH FROM order_date) AS sales_month,
       SUM(sales) AS monthly_sales
FROM orders
GROUP BY EXTRACT(YEAR FROM order_date), EXTRACT(MONTH FROM order_date)
ORDER BY sales_year, sales_month;

-- Q57. Yearly sales trend.
SELECT EXTRACT(YEAR FROM order_date) AS sales_year,
       SUM(sales) AS yearly_sales
FROM orders
GROUP BY EXTRACT(YEAR FROM order_date)
ORDER BY sales_year;

-- Q58. Monthly profit trend.
SELECT EXTRACT(YEAR FROM order_date) AS profit_year,
       EXTRACT(MONTH FROM order_date) AS profit_month,
       SUM(profit) AS monthly_profit
FROM orders
GROUP BY EXTRACT(YEAR FROM order_date), EXTRACT(MONTH FROM order_date)
ORDER BY profit_year, profit_month;

-- Q59. Best sales month.
WITH monthly_sales AS (
    SELECT DATE_TRUNC('month', order_date) AS month_start, SUM(sales) AS total_sales
    FROM orders
    GROUP BY DATE_TRUNC('month', order_date)
)
SELECT month_start, total_sales
FROM monthly_sales
ORDER BY total_sales DESC
FETCH FIRST 1 ROW ONLY;

-- Q60. Worst sales month.
WITH monthly_sales AS (
    SELECT DATE_TRUNC('month', order_date) AS month_start, SUM(sales) AS total_sales
    FROM orders
    GROUP BY DATE_TRUNC('month', order_date)
)
SELECT month_start, total_sales
FROM monthly_sales
ORDER BY total_sales ASC
FETCH FIRST 1 ROW ONLY;

-- Q61. Average sales per month.
WITH monthly_sales AS (
    SELECT DATE_TRUNC('month', order_date) AS month_start, SUM(sales) AS total_sales
    FROM orders
    GROUP BY DATE_TRUNC('month', order_date)
)
SELECT AVG(total_sales) AS average_monthly_sales
FROM monthly_sales;

-- Q62. Average profit per month.
WITH monthly_profit AS (
    SELECT DATE_TRUNC('month', order_date) AS month_start, SUM(profit) AS total_profit
    FROM orders
    GROUP BY DATE_TRUNC('month', order_date)
)
SELECT AVG(total_profit) AS average_monthly_profit
FROM monthly_profit;

-- Q63. Running sales total.
SELECT order_date, row_id, sales,
       SUM(sales) OVER (ORDER BY order_date, row_id) AS running_sales_total
FROM orders
ORDER BY order_date, row_id;

-- Q64. Running profit total.
SELECT order_date, row_id, profit,
       SUM(profit) OVER (ORDER BY order_date, row_id) AS running_profit_total
FROM orders
ORDER BY order_date, row_id;

-- Q65. Top customer in every region.
WITH regional_customer_sales AS (
    SELECT c.region, c.customer_id, c.customer_name, SUM(o.sales) AS total_sales,
           ROW_NUMBER() OVER (PARTITION BY c.region ORDER BY SUM(o.sales) DESC) AS rn
    FROM orders o
    JOIN customers c ON c.customer_id = o.customer_id
    GROUP BY c.region, c.customer_id, c.customer_name
)
SELECT region, customer_name, total_sales
FROM regional_customer_sales
WHERE rn = 1;

-- Q66. Top product in every category.
WITH category_product_sales AS (
    SELECT p.category, p.product_id, p.product_name, SUM(o.sales) AS total_sales,
           ROW_NUMBER() OVER (PARTITION BY p.category ORDER BY SUM(o.sales) DESC) AS rn
    FROM orders o
    JOIN products p ON p.product_id = o.product_id
    GROUP BY p.category, p.product_id, p.product_name
)
SELECT category, product_name, total_sales
FROM category_product_sales
WHERE rn = 1;

-- Q67. Top city in every state.
WITH state_city_sales AS (
    SELECT c.state, c.city, SUM(o.sales) AS total_sales,
           ROW_NUMBER() OVER (PARTITION BY c.state ORDER BY SUM(o.sales) DESC) AS rn
    FROM orders o
    JOIN customers c ON c.customer_id = o.customer_id
    GROUP BY c.state, c.city
)
SELECT state, city, total_sales
FROM state_city_sales
WHERE rn = 1;

-- Q68. Highest order value in every category.
WITH category_order_values AS (
    SELECT p.category, o.order_id, o.sales,
           ROW_NUMBER() OVER (PARTITION BY p.category ORDER BY o.sales DESC) AS rn
    FROM orders o
    JOIN products p ON p.product_id = o.product_id
)
SELECT category, order_id, sales
FROM category_order_values
WHERE rn = 1;

-- Q69. Highest profit order in every region.
WITH region_order_profit AS (
    SELECT c.region, o.order_id, o.profit,
           ROW_NUMBER() OVER (PARTITION BY c.region ORDER BY o.profit DESC) AS rn
    FROM orders o
    JOIN customers c ON c.customer_id = o.customer_id
)
SELECT region, order_id, profit
FROM region_order_profit
WHERE rn = 1;

-- Q70. Customer contribution percentage to total sales.
WITH customer_sales AS (
    SELECT customer_id, SUM(sales) AS total_sales
    FROM orders
    GROUP BY customer_id
), total_sales AS (
    SELECT SUM(total_sales) AS grand_total_sales
    FROM customer_sales
)
SELECT c.customer_id, c.customer_name, cs.total_sales,
       ROUND((cs.total_sales / t.grand_total_sales) * 100, 2) AS contribution_percentage
FROM customer_sales cs
JOIN customers c ON c.customer_id = cs.customer_id
CROSS JOIN total_sales t
ORDER BY contribution_percentage DESC;