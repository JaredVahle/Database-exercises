

# 1. Using the example from the lesson, create a temporary table called employees_with_departments that contains first_name, last_name, and dept_name for employees currently with that department.
USE germain_1460;
CREATE TEMPORARY TABLE employees_with_departments AS
SELECT emp_no, first_name, last_name, dept_no, dept_name
FROM employees.employees
JOIN employees.dept_emp USING(emp_no)
JOIN employees.departments USING(dept_no);

SELECT *
FROM employees_with_departments;

# A) Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns

ALTER TABLE employees_with_departments ADD full_name VARCHAR(200);


# B) Update the table so that full name column contains the correct data

UPDATE employees_with_departments SET full_name = CONCAT(first_name, " ", last_name);

# C) Remove the first_name and last_name columns from the table.

ALTER TABLE employees_with_departments DROP COLUMN first_name;
ALTER TABLE employees_with_departments DROP COLUMN last_name;

SELECT *
FROM employees_with_departments;

# D) What is another way you could have ended up with this same table?
USE employees;
CREATE TEMPORARY TABLE germain_1460.employees_with_departments_2 AS
SELECT emp_no, first_name,last_name , dept_no, dept_name
FROM employees
JOIN dept_emp USING(emp_no)
JOIN departments USING(dept_no);

ALTER TABLE germain_1460.employees_with_departments_2 ADD full_name VARCHAR(200);

UPDATE germain_1460.employees_with_departments_2 SET full_name = CONCAT(first_name, " ", last_name);

ALTER TABLE germain_1460.employees_with_departments_2 DROP COLUMN first_name;
ALTER TABLE germain_1460.employees_with_departments_2 DROP COLUMN last_name;

SELECT * 
FROM germain_1460.employees_with_departments_2;


# 2. Create a temporary table based on the payment table from the sakila database. Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. For example, 1.99 should become 199.
DROP TABLE payment_change;
USE germain_1460;

CREATE TEMPORARY TABLE payment_change AS
SELECT *
FROM sakila.payment;

SELECT *
FROM payment_change;

ALTER TABLE payment_change ADD new_amount FLOAT (10,2);
UPDATE payment_change SET new_amount = (amount * 100);
ALTER TABLE payment_change DROP COLUMN amount;

SELECT *
FROM payment_change;

# Find out how the current average pay in each department compares to the overall, historical average pay. In order to make the comparison easier, you should use the Z-score for salaries. In terms of salary, what is the best department right now to work for? The worst?

USE employees;


CREATE TEMPORARY TABLE germain_1460.cur_avg_dept_sal AS
SELECT dept_name, AVG(salary) AS "current_avg_sal"
FROM salaries
JOIN dept_emp AS de ON de.emp_no = salaries.emp_no
JOIN departments AS d ON d.dept_no = de.dept_no
WHERE salaries.to_date = "9999-01-01" AND de.to_date = "9999-01-01"
GROUP BY dept_name;

ALTER TABLE germain_1460.cur_avg_dept_sal ADD zscore FLOAT(10,3);

UPDATE germain_1460.cur_avg_dept_sal SET zscore = ((current_avg_sal - (SELECT AVG(salary) FROM employees.salaries)) / (SELECT STDDEV(salary) FROM employees.salaries));

SELECT *
FROM germain_1460.cur_avg_dept_sal;

# BEST DEPARTMENT - SALES ------- WORST DEPARTMENT - HUMAN RESOURCES