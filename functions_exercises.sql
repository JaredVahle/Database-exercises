-- Write a query to to find all employees whose last name starts and ends with 'E'. Use concat() to combine their first and last name together as a single column named full_name.

USE employees;


SELECT CONCAT (first_name, " ", last_name) AS full_name
FROM employees
WHERE last_name LIKE "e%e";

-- Convert the names produced in your last query to all uppercase.

SELECT CONCAT (upper(first_name), " ",upper(last_name)) AS full_name
FROM employees
WHERE last_name LIKE "e%e";

-- Find all employees hired in the 90s and born on Christmas. Use datediff() function to find how many days they have been working at the company (Hint: You will also need to use NOW() or CURDATE()),

SELECT DATEDIFF(now(),hire_date) AS days_since_hired
FROM employees
WHERE (hire_date LIKE "199%") AND  hire_date LIKE "%-12-25";

-- Find the smallest and largest current salary from the salaries table.

SELECT min(salary) AS min_salary
FROM salaries;

SELECT max(salary) AS max_salary
FROM salaries;

-- Use your knowledge of built in SQL functions to generate a username for all of the employees. A username should be all lowercase, and consist of the first character of the employees first name, the first 4 characters of the employees last name, an underscore, the month the employee was born, and the last two digits of the year that they were born. Below is an example of what the first 10 rows will look like:

SELECT * 
FROM employees;

SELECT LOWER(CONCAT(substr(first_name,1,1),SUBSTR(last_name,1,4),"_",SUBSTR(birth_date,6,2),SUBSTR(birth_date,3,2)))
FROM employees;