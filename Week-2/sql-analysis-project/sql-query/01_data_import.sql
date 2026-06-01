-- I load the superstore.csv file from data/superstore.csv into PostgreSQL .

SELECT COUNT(*) AS total_records
FROM superstore; -- This query counts the total number of records in the superstore table. Output : 9994


SELECT *
FROM superstore
LIMIT 10; -- First 10 records from the superstore table. Output : 10 records with all columns displayed.