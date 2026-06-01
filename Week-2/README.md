# SQL-based Data Analysis — Superstore Dataset

**Objective:** Analyze sales data using SQL with filtering, aggregation, and business queries.

**Dataset:** [Kaggle Superstore Dataset](https://www.kaggle.com/datasets/vivek468/superstore-dataset-final)  
**Tool:** PostgreSQL  
**Files:** SQL scripts organized step by step

---

## Project Structure

```
sql-analysis-project/
├── 00_create_table.sql       -- create table + load csv
├── 01_data_exploration.sql      -- schema + sample data
├── 02_where_filter.sql      -- WHERE (region, category, date, sales)
├── 03_group.sql  -- GROUP BY (sales, qty, averages)
├── 04_sort_limit.sql     -- ORDER BY + LIMIT (top products)
├── 05_business_usecases.sql -- monthly trends, top customers, duplicates
├── 06_validate_results.sql   -- row counts, data quality checks
└── README.md
```

---

## Step 1 — Load Dataset

Created a `superstore` table with 21 columns and loaded the CSV.

```sql
COPY superstore
FROM '/your/path/Superstore.csv'
DELIMITER ',' CSV HEADER;
```

---

## Step 2 — Explore Table

```sql
SELECT COUNT(*) FROM superstore;
```

| count |
| ----- |
| 9994  |

```sql
SELECT MIN(order_date), MAX(order_date) FROM superstore;
```

| min        | max        |
| ---------- | ---------- |
| 2014-01-03 | 2017-12-30 |

```sql
SELECT DISTINCT region FROM superstore;
```

| region  |
| ------- |
| West    |
| East    |
| Central |
| South   |

> **Insight:** Dataset covers 4 years (2014–2017), 4 regions, 3 categories.

---

## Step 3 — WHERE Filters

```sql
-- high value orders
SELECT order_id, customer_name, sales
FROM superstore
WHERE sales > 500
ORDER BY sales DESC
LIMIT 5;
```

| order_id       | customer_name | sales    |
| -------------- | ------------- | -------- |
| CA-2014-145317 | Sean Miller   | 22638.48 |
| US-2016-108966 | Tamara Chand  | 17499.95 |
| CA-2016-117121 | Raymond Buch  | 14052.34 |
| CA-2015-168116 | Tom Ashbrook  | 13999.96 |
| CA-2014-103366 | Ken Lonsdale  | 11199.97 |

```sql
-- loss making orders
SELECT product_name, sales, profit
FROM superstore
WHERE profit < 0
ORDER BY profit ASC
LIMIT 5;
```

| product_name                          | sales   | profit   |
| ------------------------------------- | ------- | -------- |
| Cubify CubeX 3D Printer Triple Head   | 7999.98 | -6599.98 |
| Lexmark MX611dhe Monochrome Laser...  | 4199.89 | -3839.90 |
| Cubify CubeX 3D Printer Double Head   | 3839.94 | -3359.95 |
| GBC DocuBind P400 Electric...         | 1029.95 | -1875.01 |
| Barricks Multi-Purpose Stacking Chair | 957.58  | -1680.00 |

> **Insight:** 3D printers and heavy machinery consistently make losses — likely due to high discounts.

---

## Step 4 — GROUP BY Aggregations

```sql
SELECT region, ROUND(SUM(sales)::numeric, 2) AS total_sales
FROM superstore
GROUP BY region
ORDER BY total_sales DESC;
```

| region  | total_sales |
| ------- | ----------- |
| West    | 725457.82   |
| East    | 678781.24   |
| Central | 501239.89   |
| South   | 391721.91   |

```sql
SELECT category,
    ROUND(SUM(sales)::numeric, 2)  AS total_sales,
    ROUND(SUM(profit)::numeric, 2) AS total_profit
FROM superstore
GROUP BY category
ORDER BY total_sales DESC;
```

| category        | total_sales | total_profit |
| --------------- | ----------- | ------------ |
| Technology      | 836154.03   | 145454.95    |
| Furniture       | 741999.80   | 18451.27     |
| Office Supplies | 719047.03   | 122490.80    |

```sql
-- profit margin by category
SELECT category,
    ROUND(SUM(profit) / SUM(sales) * 100, 2) AS margin_pct
FROM superstore
GROUP BY category;
```

| category        | margin_pct |
| --------------- | ---------- |
| Technology      | 17.40%     |
| Office Supplies | 17.03%     |
| Furniture       | 2.49%      |

> **Insight:** Furniture has near-zero profit margin despite high sales — heavy discounting is the likely cause. Technology is the most profitable category.

---

## Step 5 — Sort & Limit (Top Products / Categories)

```sql
-- top 10 products by sales
SELECT product_name, ROUND(SUM(sales)::numeric, 2) AS total_sales
FROM superstore
GROUP BY product_name
ORDER BY total_sales DESC
LIMIT 5;
```

| product_name                                  | total_sales |
| --------------------------------------------- | ----------- |
| Canon imageCLASS 2200 Advanced Copier         | 61599.82    |
| Fellowes PB500 Electric Punch Plastic Comb... | 27453.38    |
| Cisco TelePresence System EX90 Videoconf...   | 22638.48    |
| HON 5400 Series Task Chairs                   | 21870.53    |
| GBC DocuBind TL300 Electric Binding System    | 19823.48    |

```sql
-- top 5 states by revenue
SELECT state, ROUND(SUM(sales)::numeric, 2) AS total_sales
FROM superstore
GROUP BY state
ORDER BY total_sales DESC
LIMIT 5;
```

| state        | total_sales |
| ------------ | ----------- |
| California   | 457687.63   |
| New York     | 310876.27   |
| Texas        | 170188.05   |
| Washington   | 138641.27   |
| Pennsylvania | 116511.91   |

> **Insight:** California alone contributes ~20% of total revenue.

---

## Step 6 — Business Use Cases

### Monthly Sales Trend

```sql
SELECT TO_CHAR(order_date, 'YYYY-MM') AS month,
    ROUND(SUM(sales)::numeric, 2) AS monthly_sales
FROM superstore
GROUP BY month
ORDER BY month
LIMIT 6;
```

| month   | monthly_sales |
| ------- | ------------- |
| 2014-01 | 14236.90      |
| 2014-02 | 4519.89       |
| 2014-03 | 55691.01      |
| 2014-04 | 28295.35      |
| 2014-05 | 23648.31      |
| 2014-06 | 34601.27      |

> **Insight:** November and December consistently spike every year — clear seasonality pattern.

### Top 5 Customers by Revenue

```sql
SELECT customer_name,
    ROUND(SUM(sales)::numeric, 2) AS total_spent,
    COUNT(DISTINCT order_id) AS orders
FROM superstore
GROUP BY customer_name
ORDER BY total_spent DESC
LIMIT 5;
```

| customer_name | total_spent | orders |
| ------------- | ----------- | ------ |
| Sean Miller   | 25043.05    | 8      |
| Tamara Chand  | 19052.22    | 8      |
| Raymond Buch  | 15117.34    | 8      |
| Tom Ashbrook  | 14595.62    | 7      |
| Adrian Barton | 14473.57    | 11     |

### Duplicate Check

```sql
SELECT row_id, COUNT(*) FROM superstore
GROUP BY row_id HAVING COUNT(*) > 1;
```

| result             |
| ------------------ |
| 0 rows returned ✅ |

> **Insight:** No duplicate rows found. Data is clean.

---

## Step 7 — Validate Results

```sql
SELECT
    COUNT(*)                    AS total_rows,
    COUNT(DISTINCT order_id)    AS unique_orders,
    COUNT(DISTINCT customer_id) AS unique_customers,
    MIN(order_date)             AS from_date,
    MAX(order_date)             AS to_date,
    ROUND(SUM(sales)::numeric, 2)  AS total_revenue,
    ROUND(SUM(profit)::numeric, 2) AS total_profit
FROM superstore;
```

| total_rows | unique_orders | unique_customers | from_date  | to_date    | total_revenue | total_profit |
| ---------- | ------------- | ---------------- | ---------- | ---------- | ------------- | ------------ |
| 9994       | 5009          | 793              | 2014-01-03 | 2017-12-30 | 2297200.86    | 286397.02    |

```sql
-- null check (all should be 0)
SELECT
    COUNT(*) - COUNT(sales)     AS null_sales,
    COUNT(*) - COUNT(profit)    AS null_profit,
    COUNT(*) - COUNT(order_date) AS null_dates
FROM superstore;
```

| null_sales | null_profit | null_dates |
| ---------- | ----------- | ---------- |
| 0          | 0           | 0          |

> **Insight:** Dataset is complete with no missing values. Total revenue of $2.29M across 4 years with $286K profit (~12.5% overall margin).

---

## Key Takeaways

| Finding          | Detail                           |
| ---------------- | -------------------------------- |
| Best region      | West — $725K revenue             |
| Best category    | Technology — 17.4% margin        |
| Problem category | Furniture — only 2.49% margin    |
| Top state        | California — ~20% of all revenue |
| Top customer     | Sean Miller — $25K spent         |
| Data quality     | Clean — no nulls, no duplicates  |
| Seasonality      | Nov–Dec spike every year         |
