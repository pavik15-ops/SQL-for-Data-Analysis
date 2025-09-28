create database Shopping;

use Shopping;

show tables;

select * from shopping_trends;

describe shopping_trends;

ALTER TABLE shopping_trends
MODIFY COLUMN `Purchase Amount (USD)` DECIMAL(10,2);

ALTER TABLE shopping_trends
MODIFY COLUMN `Customer ID` VARCHAR(20);


-- 1. Total revenue and average purchase amount

SELECT 
    sum(`Purchase Amount (USD)`) AS total_revenue,
	avg(`Purchase Amount (USD)`) AS avg_purchase
FROM shopping_trends;

-- 2. count of total purchases in each category

SELECT category, COUNT(*) AS total_purchases
FROM shopping_trends
GROUP BY category
ORDER BY total_purchases DESC;

-- 3. Average spending by gender

SELECT gender, avg(`Purchase Amount (USD)`) AS avg_spending
FROM shopping_trends
GROUP BY gender;

-- 4. Revenue by season

SELECT season,  SUM(`Purchase Amount (USD)`) AS season_revenue
FROM shopping_trends
GROUP BY season
ORDER BY season_revenue DESC;

-- 5. Best-selling item in each category

SELECT category, 'item purchased', COUNT(*) AS total_sales
FROM shopping_trends
GROUP BY category, 'item purchased'
HAVING total_sales = (
    SELECT MAX(item_count)
    FROM (
        SELECT category AS cat, 'item purchased', COUNT(*) AS item_count
        FROM shopping_trends
        GROUP BY category, 'item purchased'
    ) AS sub
    WHERE sub.cat = shopping_trends.category
);


-- 6. Create a view

CREATE VIEW sales_summary AS
SELECT 
    category,
    season,
    SUM(`Purchase Amount (USD)`) AS total_revenue,
    AVG('review rating') AS avg_rating
FROM shopping_trends
GROUP BY category, season;
















	
