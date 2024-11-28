
DROP DATABASE IF EXISTS mysql_query;
CREATE DATABASE IF NOT EXISTS MySQL_Query;
USE MYSQL_Query;

-- CREATE TABLE 

DROP TABLE IF EXISTS employees;
CREATE TABLE IF NOT EXISTS employees(
	Id INT PRIMARY KEY,
    Name VARCHAR(30) NOT NULL,
    Age INT DEFAULT 0,
    Salary DECIMAL(10,2)
);

-- CHECK TABLE EXISTS OR NOT
SHOW TABLES;

-- VERIFY THE TABLE STRUCTURE
DESCRIBE employees;

-- alter : add,drop and modify
DESCRIBE employees;

ALTER TABLE employees ADD COLUMN Department VARCHAR(50);
ALTER TABLE employees MODIFY COLUMN Age TINYINT;
ALTER TABLE employees DROP COLUMN department;

-- insert data : followed by column names and values

-- for single value
INSERT INTO employees(id,name,age,Salary)
VALUES(12,'Salman',23,50000.00);

-- for multiple value insert
INSERT INTO employees(id,name,age,salary)
VALUE
(1, 'Mohammad Ali', 28, 45000.00),
(2, 'Sultan Ahmed', 32, 55000.00),
(3, 'Faruk Hossain', 27, 50000.00),
(4, 'Ruhul Amin', 35, 60000.00),
(5, 'Anwarul Islam', 29, 47000.00),
(6,'Anwarul', 36, 40500.00);


-- remove data from the table
DELETE FROM employees WHERE age > 35;

-- select :* for all and 
SELECT * FROM employees;
SELECT id,name FROM employees;

-- where : followed by conditions
SELECT * FROM employees WHERE age<30;

-- fetch unique value 
SELECT DISTINCT Salary from employees;


-- rename table
Rename table employees to Staff;


-- 

-- delete full table 
DROP TABLE employee;





