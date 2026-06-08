# Week 3 — Superstore Sales Analysis (SQL)

## Overview

This folder contains the work for Week 3: exploring and analysing the Superstore sales dataset using SQL and notebooks. The goal is to practise SQL data modeling, querying (joins, filters, aggregations, window functions), and to produce business-focused insights from the data.

## Dataset

- Source: `dataset/Superstore.csv` (copy in this folder)
- Description: Transactional sales data including order, customer, product, geographic and profit information.

## Objectives

- Create and populate SQL tables from the CSV.
- Explore the data (data quality, distributions, missing values).
- Write queries demonstrating filtering, grouping, sorting, joins, subqueries, CTEs, and window functions.
- Answer business questions such as top products, top customers, regional performance, and profit drivers.

## Files and structure

- `dataset/Superstore.csv` — raw CSV data.
- `sql/01_create_tables.sql` — DDL to create the schema/tables.
- `sql/02_insert_data.sql` — SQL to insert/import data into tables.
- `sql/03_subqueries.sql` — example subquery exercises.
- `sql/04_cte_queries.sql` — common table expressions for readable queries.
- `sql/05_window_functions.sql` — window function examples (running totals, ranks).
- `sql/06_business_queries.sql` — business-focused analysis queries.
- `sql/07_final_report_query.sql` — combined query for final reporting.
- `Superstore_Sales_Analysis_SQL.ipynb` — Jupyter notebook with exploratory analysis and commentary.

## How to run

1. Open `Superstore_Sales_Analysis_SQL.ipynb` in Jupyter or VS Code and run cells in order.
2. To run the SQL scripts locally:
   - If you have SQLite, Postgres, or MySQL, create a database and adapt the connection/import step in `02_insert_data.sql`.
   - For a quick test with SQLite, you can use a CSV import tool or Python (pandas.to_sql) to load `dataset/Superstore.csv` into a table.

3. Run the queries in the `sql/` folder against the populated database to reproduce results.
