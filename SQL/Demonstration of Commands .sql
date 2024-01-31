/*
**DEMONSTRATION OF COMMANDS**
Note: These queries are demonstration only and do NOT contain any actual data. 

1. Data Query Language (DQL)
---SELECT

2. Data Manipulation Language (DML)
---INSERT ---UPDATE ---DELETE ---LOCK ---CALL

3. Data Definition Language (DDL)
---CREATE ---DROP ---ALTER ---TRUNCATE---RENAME

4. Data Control Language (DCL)
---GRANT---REVOKE

5. Transaction Control Language (TCL) 
---ROLLBACK---COMMIT---SAVEPOINT---SET TRANSACTION

6. Structured query language (SQL)
---SELECT---INSERT---UPDATE---DELETE---CREATE---ALTER---DROP---JOIN---WHERE---GROUP BY
*/
-- 1.
SELECT * FROM products;
SELECT sales_person, id FROM products WHERE id > 10;

-- 2.
INSERT INTO products (sales_person, id) VALUES ('Fulano de Tal', 11);
UPDATE products SET id = 30 WHERE sales_person = 'Fulano de Tal';
DELETE FROM products WHERE sales_person = 'Fulano de Tal';
LOCK TABLE products IN SHARE MODE;
CALL stored_procedure();

-- 3.
CREATE TABLE products (
  id INT PRIMARY KEY,
  sales_person VARCHAR(100),
  id INT
);
DROP TABLE products;
ALTER TABLE products ADD COLUMN product_type VARCHAR(255);
TRUNCATE TABLE products;
RENAME TABLE products TO items;

-- 4.
GRANT SELECT, INSERT ON products TO user1;
REVOKE DELETE ON products FROM user2;

-- 5.
START TRANSACTION;
SAVEPOINT savepoint1;
INSERT INTO products (sales_person, id) VALUES ('Mengana de Cual', 1);
ROLLBACK TO savepoint1;
COMMIT;
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

-- 6.
--
SELECT * FROM products;
SELECT sales_person, id FROM products WHERE id > 151;
--
INSERT INTO products (sales_person, id) VALUES ('Fulano de Tal', 25);
--
UPDATE products SET id = 312 WHERE sales_person = 'Fulano de Tal';
--
DELETE FROM products WHERE sales_person = 'Fulano de Tal';
--
CREATE TABLE staff (
  staff_id INT PRIMARY KEY,
  name VARCHAR(100),
  staff_id INT,
  salary DECIMAL(10,2));
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
SELECT job_title, COUNT(*) as employee_count
FROM staff
GROUP BY job_title;
