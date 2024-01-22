
/*Analysis on pet products, their total sales, growth rates, contribution to the ravenue and popularity
based on 'Pet Store Records 2020 - predict or classify' on Kaggle by Ippudkippude (Owner)
by @nadyakant
!Queries in this document are not for comercial use. They only serve an illustrative purpose as a portfolio project. They do NOT represent real pet store data.!



--------Queries: ---------------------------------------------------*/

---
--What is the growth rate by month of (pet)food products in 2022?
SELECT month,
    sales AS current_month,
    LAG(sales, 1) OVER (ORDER BY month) AS previous_month
FROM pet_shop_sales
WHERE product_category = 'Food'
    AND year = 2022

---
--What is the growth rate by month of (pet)medicine products in 2022? (+ growth rate)
SELECT
    month, sales AS current_month,
    LAG(sales, 1) OVER (ORDER BY month) AS previous_month,
    (sales - LAG(sales, 1) OVER (ORDER BY month)) / LAG(sales, 1) OVER (ORDER BY month) * 100 AS growth_rate
FROM pet_shop_sales
WHERE product_category = 'Medicine'
    AND year = 2022

---
--Best performing products based on pet type in terms of sales for 2021:
WITH monthly_sales AS (
    SELECT year, month, et_type, SUM(sales) AS total_sales
    FROM pet_shop_sales
    WHERE year = 2021  
    GROUP BY year, month, pet_type
),
top_pet-type products AS (
    SELECT year, month, pet_type, total_sales,
        RANK() OVER (PARTITION BY year, month ORDER BY total_sales DESC) AS pet_type_rank
    FROM monthly_sales)
	
SELECT year, month, pet_type, total_sales
FROM top_pet-type products
WHERE pet_type_rank = 1
ORDER BY year, month

---
--Best performing products based on pet type in terms of sales for 2022:
WITH monthly_sales AS (
    SELECT year, month, pet_type, SUM(sales) AS total_sales
    FROM pet_shop_sales
    WHERE year = 2022  
    GROUP BY year, month, pet_type
),
top_pet-type products AS (
    SELECT year, month, pet_type, total_sales,
        RANK() OVER (PARTITION BY year, month ORDER BY total_sales DESC) AS pet_type_rank
    FROM monthly_sales)
SELECT year, month, pet_type, total_sales
FROM top_pet-type products
WHERE pet_type_rank = 1
ORDER BY year, month

---
--Which product category contributed the most to the total sales?
SELECT product_category, pet_type,
    SUM(sales) AS total_sales
FROM pet_shop_sales
GROUP BY product_category, pet_type
ORDER BY total_sales DESC
	
---
--Is there any seasonality in pet type product sales, and how do they vary on a monthly basis?
SELECT pet_type, year, month,
    SUM(sales) AS total_sales
FROM pet_shop_sales
GROUP BY year, pet_type, month
ORDER BY year, pet_type, month
	
---
--How do sales vary among pet type products based on product id?

SELECT product_id, pet_type,
    SUM(sales) AS total_sales
FROM pet_shop_sales
GROUP BY product_id, pet_type
ORDER BY product_id, total_sales DESC

---
--Are there any significant changes in pet type product sales during particular months or years? Which ones?
SELECT pet_type, year, month, sales
FROM pet_shop_sales
WHERE (pet_type, year, month) IN (
        SELECT
            pet_type, year, month
        FROM (
            SELECT pet_type, year, month, sales,
                LAG(sales) OVER (PARTITION BY pet_type ORDER BY year, month) AS prev_sales,
                LEAD(sales) OVER (PARTITION BY pet_type ORDER BY year, month) AS next_sales
            FROM pet_shop_sales) AS sales_analysis
        WHERE
            sales > 1.5 * COALESCE(prev_sales, 0) OR sales > 1.5 * COALESCE(next_sales, 0))
ORDER BY pet_type, year, month
	
---
--Which category within fish products had the highest sales revenue for 2022?
SELECT product_category,
    SUM(sales) AS total_sales
FROM pet_shop_sales
WHERE pet_type = 'fish' AND year = 2022
GROUP BY product_category
ORDER BY total_sales DESC

---
--What is the contribution (in percent) for each product category in the fish industry in 2021?
WITH fish_sales AS (
    SELECT product_category,
        SUM(sales) AS total_sales
    FROM pet_shop_sales
    WHERE pet_type = 'fish' 
	AND year = 2021  
    GROUP BY product_category
),
total_sales_fish AS (
    SELECT
        SUM(sales) AS total_sales_fish
    FROM pet_shop_sales
    WHERE pet_type = 'fish' 
	AND year = 2021)
	
SELECT product_category,
    ROUND((total_sales / total_sales_fish.total_sales_fish) * 100, 2) AS contribution
FROM fish_sales
CROSS JOIN total_sales_fish

---
--What are the growth rates for fish products during 2022?
SELECT year, product_category, pet_type,
    (sales - LAG(sales) OVER (PARTITION BY pet_type ORDER BY year)) / LAG(sales) OVER (PARTITION BY pet_type ORDER BY year) * 100 AS growth_rate
FROM pet_shop_sales
	WHERE pet_type = 'fish'
	AND year = 2022
ORDER BY pet_type, year

---
--What are the total sales for food and medicine by year?
SELECT year,
    sum(CASE WHEN product_category = 'Food' THEN sales ELSE 0 END) as food_sales,
    sum(CASE WHEN product_category = 'Medicine' THEN sales ELSE 0 END) as medicine_sales
FROM pet_shop_sales
GROUP BY year

---
--What is the yearly ratio of total sales of toys to equipment?
SELECT year, toys_sales/equipment_sales as Toys_to_Equipment_ratio
FROM (
    SELECT year,
    sum(CASE WHEN product_category = 'Toys' THEN sales ELSE 0 END) as toys_sales,
    sum(CASE WHEN product_category = 'Equipment' THEN sales ELSE 0 END) as equipment_sales
    FROM pet_shop_sales
    GROUP BY 1)

---
--What is the sales amount of medicine products by the monthly total (+ previous months of the year)?
SELECT rs.month, rs.year, rs.sales,
    ((
            SELECT SUM(sales)
            FROM pet_shop_sales AS rs2
            WHERE rs2.year = rs.year
            AND rs2.month <= rs.month
            AND rs2.product_category = 'Medicine'
        )) AS by_month_sales
FROM pet_shop_sales AS rs
WHERE rs.product_category = 'Medicine'
    AND rs.year IN (2019, 2020, 2021, 2022)


