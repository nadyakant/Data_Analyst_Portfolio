/*
**DEMONSTRATION OF SQL COMMANDS**
Note: These queries are for demonstration purposes only and do NOT contain any factual data. 
Please, do NOT IMPORT .csv tables, there is sample data in the query. Thank you!
@nadyakant
*/
-- 1. Data Query Language (DQL)-----------------------------------------------------------------------------------------------------------------------------------------------------
---SELECT
SELECT * FROM products;
SELECT sales_person, id FROM products WHERE id > 10;


-- 2. Data Manipulation Language (DML)-----------------------------------------------------------------------------------------------------------------------------------------------
---INSERT ---UPDATE ---DELETE ---LOCK ---CALL
INSERT INTO products (sales_person, id) VALUES ('Fulano de Tal', 2);
UPDATE products SET id = 30 WHERE sales_person = 'Fulano de Tal';
DELETE FROM products WHERE sales_person = 'Fulano de Tal';
LOCK TABLE products IN SHARE MODE;
CALL stored_procedure();


-- 3. Data Definition Language (DDL)------------------------------------------------------------------------------------------------------------------------------------------------
---CREATE ---DROP ---ALTER ---TRUNCATE---RENAME
CREATE TABLE products (
   id INT PRIMARY KEY
  ,sales_person VARCHAR(100)
  ,id INT
);

DROP TABLE products;
ALTER TABLE products ADD COLUMN product_type VARCHAR(255);
TRUNCATE TABLE products;
RENAME TABLE products TO items;


-- 4. Data Control Language (DCL)--------------------------------------------------------------------------------------------------------------------------------------------------
---GRANT---REVOKE
GRANT SELECT, INSERT ON products TO user1;
REVOKE DELETE ON products FROM user2;


-- 5. Transaction Control Language (TCL)-------------------------------------------------------------------------------------------------------------------------------------------
---ROLLBACK---COMMIT---SAVEPOINT---SET TRANSACTION
START TRANSACTION;
SAVEPOINT savepoint1;
INSERT INTO products (sales_person, id) VALUES ('Mengana de Cual', 1);
ROLLBACK TO savepoint1;
COMMIT;
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;


--6. Aggregations & More--------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---SELECT---INSERT---UPDATE---DELETE---CREATE---ALTER---DROP---JOIN---WHERE---GROUP BY---ORDER BY
---FROM---LIMIT---AS---AND---OR---IN---LIKE---IS NULL---CASE---HAVING---COUNT---SUM---AVG---MIN---MAX
--
SELECT * FROM products;
SELECT sales_person, id FROM products WHERE id > 151;

--
INSERT INTO products (sales_person, id) VALUES ('Fulano de Tal', 2);

--
UPDATE products SET id = 312 WHERE sales_person = 'Fulano de Tal';

--
DELETE FROM products WHERE sales_person = 'Fulano de Tal';

--
CREATE TABLE staff (
  ,staff_id INT PRIMARY KEY
  ,name VARCHAR(100)
  ,staff_id INT
  ,salary DECIMAL(10,2));
  
--
ALTER TABLE staff ADD COLUMN job_title VARCHAR(100);

--
DROP TABLE staff;

--
SELECT orders.order_id, products.sales_person
FROM orders
JOIN products ON orders.customer_id = products.customer_id;

--
SELECT * FROM staff WHERE staff_id > 100;

--
SELECT * FROM staff LIMIT 10;

--
SELECT name AS full_name, salary AS gross_salary FROM staff;

--
SELECT job_title, COUNT(*) as employee_count
FROM staff
GROUP BY job_title;

-- 
SELECT * FROM staff WHERE staff_id < 100 AND job_title = 'IT';

--
SELECT * FROM staff WHERE staff_id > 213 OR job_title = 'HR';

--
SELECT * FROM staff WHERE staff_id IN ('IT', 'Recruiter');

--
SELECT * FROM staff WHERE name LIKE '%de%';

--
SELECT * FROM staff WHERE job_title IS NULL;

--
SELECT name, staff_id,
  CASE
    WHEN staff_id < 100 THEN 'Senior'
    ELSE 'Junior'
  END AS employee_level
FROM staff;

--
SELECT * FROM staff ORDER BY name ASC;

--
SELECT job_title, COUNT(*) as employee_count
FROM staff
GROUP BY job_title
HAVING COUNT(*) > 5;

--
SELECT COUNT(*) FROM staff;

--
SELECT SUM(salary) FROM staff;

--
SELECT AVG(salary) FROM staff;

--
SELECT MIN(staff_id) FROM staff;

--
SELECT MAX(staff_id) FROM staff;


--7. JOIN (types)-------------------------------------------------------------------------------------------------------------------------------------------------------------------
---INNER---LEFT---RIGHT---CROSS---FULL
-- Sample Data:
CREATE TABLE staff (
     id INT PRIMARY KEY,
	 name VARCHAR(100),
	 department_id INT
    );
CREATE TABLE departments (
     department_id INT PRIMARY KEY,
	 department_name VARCHAR(100)
    );

INSERT INTO staff (id, name, department_id)
     VALUES (1, 'Pablo', 4)
	       ,(2, 'Maria', 1)
		   ,(3, 'José', 2)
		   ,(4, 'Jimena', 3);

INSERT INTO departments (department_id, department_name)
      VALUES (1, 'IT')
	       , (2, 'TA')
			,(3, 'HR')
			,(4, 'Management');
			
-- INNER JOIN:
SELECT staff.name, departments.department_name
FROM staff
INNER JOIN departments ON staff.department_id = departments.department_id;

--LEFT JOIN:
SELECT staff.name, departments.department_name
FROM staff
LEFT JOIN departments ON staff.department_id = departments.department_id;

--RIGHT JOIN:
SELECT staff.name, departments.department_name
FROM staff
RIGHT JOIN departments ON staff.department_id = departments.department_id;

--CROSS JOIN:
SELECT staff.name, departments.department_name
FROM staff
CROSS JOIN departments;

--FULL JOIN:
SELECT staff.name, departments.department_name
FROM staff
FULL JOIN departments ON staff.department_id = departments.department_id;


--8. FILTERING ---------------------------------------------------------------------------------------------------------------------------------------------------------------------
---COMPARISON OPERATORS---TEXT OPERATORS---WILDCARDS
-- Sample Table:
CREATE TABLE classroom_B01 (
  id INT PRIMARY KEY,
  student_name VARCHAR(100),
  age INT,
  grade VARCHAR(10)
);

INSERT INTO classroom_B01 (id, student_name, age, grade)
VALUES (1, 'José', 12, 'D')
      ,(2, 'Fernanda', 11, 'B')
      ,(3, 'Alejandra', 14, 'A')
      ,(4, 'Mario', 10, 'C');
	   

-- Filters:
SELECT *
FROM classroom_B01
WHERE age > 11;

--
SELECT *
FROM classroom_B01
WHERE grade = 'A';

--
SELECT *
FROM classroom_B01
WHERE age >= 11 AND age <= 13;

--
SELECT *
FROM classroom_B01
WHERE student_name != 'Mario';

--
SELECT *
FROM classroom_B01
WHERE student_name LIKE 'J%';

--
SELECT *
FROM classroom_B01
WHERE student_name LIKE '%n%';

--
SELECT *
FROM classroom_B01
WHERE student_name LIKE 'J_s_';

--
SELECT *
FROM classroom_B01
WHERE student_name LIKE '[F-n]%';

--
SELECT *
FROM classroom_B01
WHERE student_name LIKE '%[^n]%';


--9. Theory Operations-----------------------------------------------------------------------------------------------------------------------------------------------------------------
---UNION---INTERSECT---EXCEPT
-- Sample Table:
CREATE TABLE set01 (id INT);
CREATE TABLE set02 (id INT);

INSERT INTO set01 VALUES (7), (8), (12);
INSERT INTO set02 VALUES (32), (6), (14);

--
SELECT id FROM set01
UNION
SELECT id FROM set02;

--
SELECT id FROM set01
INTERSECT
SELECT id FROM set02;

--
SELECT id FROM set01
EXCEPT
SELECT id FROM set02;


--10. Stored Procedures-----------------------------------------------------------------------------------------------------------------------------------------------------------------
---CREATE PROCEDURE
CREATE PROCEDURE getStaffCount
AS
BEGIN
    SELECT COUNT(*) AS staffCount
    FROM staff
END;
--11. CASE Statements------------------------------------------------------------------------------------------------------------------------------------------------------------------
---CASE WHEN
SELECT name,
       salary,
       CASE
           WHEN salary > 5000 THEN 'High'
           WHEN salary > 2000 THEN 'Medium'
           ELSE 'Low'
       END AS salary_bonus
FROM staff;


--12. Sequences as 'id'-----------------------------------------------------------------------------------------------------------------------------------------------------------------
--
CREATE SEQUENCE id_generator
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    MAXVALUE 199
    CYCLE;
	
--
INSERT INTO staff (id, name, department_id)
VALUES (NEXTVAL('id_generator'), name, department_id);

--
SELECT NEXTVAL('id_generator');

--
ALTER SEQUENCE id_generator RESTART;


--13. Window Functions-----------------------------------------------------------------------------------------------------------------------------------------------------------------
---OVER---PARTITION BY---ROW_NUMBER---RANK---DENSE_RANK

--Creating a table:
CREATE TABLE sales (
       id INT PRIMARY KEY,
	   sale_date DATE,
       country VARCHAR(100), 
	   product VARCHAR(100), 
	   quantity INT, 
	   revenue INT
    );
INSERT INTO sales (id, sale_date, country, product, quantity, revenue)
     VALUES (1, '11-07-2023', 'France', 'Laptop', 1, 2000)
	        ,(2, '05-12-2023', 'Italy', 'Mouse', 1, 75)
			,(3, '27-03-2023', 'UK', 'Laptop', 1, 2300)
			,(4, '01-02-2024', 'Spain', 'Monitor', 2, 1300)
			,(5, '11-01-2024', 'Germany', 'Monitor', 1, 700);

--
SELECT sale_date,
       country, 
	   product, 
	   quantity, 
	   revenue,
       SUM(quantity) OVER (PARTITION BY product ORDER BY product) AS total_units_sold_worldwide
FROM   sales;

-- !Note: EXTRACT won't work on SQLite and SQL Server!
SELECT DISTINCT country,
       EXTRACT(MONTH FROM sale_day) AS month,
       SUM(revenue) OVER (PARTITION BY sale_month) AS total_revenue_bymonth
       ,SUM(revenue) OVER (PARTITION BY country, sale_month) AS country_revenue_bymonth
     ,(SUM(revenue) OVER (PARTITION BY sale_month)::decimal
           / (SELECT COUNT(DISTINCT country) FROM sales)::decimal) AS average_month_bycountry
        ,SUM(revenue) OVER (PARTITION BY country, sale_month) 
		- (SUM(revenue) OVER (PARTITION BY sale_month)::decimal
           / (SELECT COUNT(DISTINCT country) FROM sales)::decimal) AS average_gap_bycountry
FROM sales
WHERE extract(YEAR from sale_day) = 2023
ORDER BY country, month

-- 
SELECT
  product AS product_name,
  revenue,
  ROW_NUMBER() OVER (ORDER BY revenue DESC) AS revenue_using_row_number,
  RANK() OVER (ORDER BY revenue DESC) AS revenue_using_rank,
  DENSE_RANK() OVER (ORDER BY revenue DESC) AS revenue_using_dense_rank
 FROM sales;


--14. Subqueries-----------------------------------------------------------------------------------------------------------------------------------------------------------------
---SINGLE ROW---MULTIPLE ROW---NESTED---CORRELATED

-- 
SELECT product
FROM sales
WHERE revenue = (SELECT revenue FROM last_year_sales);

--
SELECT products
FROM sales
WHERE revenue IN (SELECT revenue FROM last_year_sales);

--
SELECT products
FROM sales
WHERE ravenue IN (SELECT ravenue FROM last_year_sales WHERE country = (SELECT country FROM sales_2010));

--
SELECT products
FROM sales AS s
WHERE EXISTS (SELECT ravenue FROM last_year_sales AS lys WHERE s.ravenue = lys.ravenue);




/*
END
*/
