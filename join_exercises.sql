# 1. Use the join_example_db. Select all the records from both the users and roles tables.

USE join_example_db;

# 2. Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson. Before you run each query, guess the expected number of results.

SELECT *
FROM users
JOIN roles ON roles.id = users.role_id;

SELECT *
FROM users
LEFT JOIN roles ON roles.id = users.role_id;

SELECT *
FROM users
RIGHT JOIN roles on roles.id = users.role_id;

# 3. Although not explicitly covered in the lesson, aggregate functions like count can be used with join queries. Use count and the appropriate join type to get a list of roles along with the number of users that has the role. Hint: You will also need to use group by in the query.

SELECT count(*), role_id, name
FROM users
GROUP BY role_id, name;


#EMPLOYEES DB

# 1. Use the employees database.

USE employees;

# 2. Using the example in the Associative Table Joins section as a guide, write a query that shows each department along with the name of the current manager for that department.

SELECT departments.dept_name AS "Department_name", CONCAT(first_name," ", last_name) AS "Department_manager"
FROM employees
JOIN dept_manager ON dept_manager.emp_no = employees.emp_no
JOIN departments ON departments.dept_no = dept_manager.dept_no
WHERE to_date > CURDATE();

# 3. Find the name of all departments currently managed by women.

SELECT dept_name AS 'Department Name', CONCAT(first_name," ", last_name) AS "Manager Name"
FROM employees
JOIN dept_manager ON dept_manager.emp_no = employees.emp_no
JOIN departments ON departments.dept_no = dept_manager.dept_no
WHERE gender = "F" AND dept_manager.to_date = "9999-01-01";

# 4. Find the current titles of employees currently working in the Customer Service department.

SELECT title, count(*) AS COUNT
FROM employees
JOIN dept_emp ON dept_emp.emp_no = employees.emp_no
JOIN departments ON departments.dept_no = dept_emp.dept_no
JOIN titles ON titles.emp_no = dept_emp.emp_no
WHERE dept_name LIKE ("Customer Service") AND dept_emp.to_date = "9999-01-01" AND titles.to_date = "9999-01-01"
GROUP BY title;

# 23580

# 5. Find the current salary of all current managers.

SELECT dept_name AS "Department_Name", CONCAT(first_name, " ", last_name) AS first_last, salary
FROM employees
JOIN dept_manager ON dept_manager.emp_no = employees.emp_no
JOIN salaries ON salaries.emp_no = dept_manager.emp_no
JOIN departments ON departments.dept_no = dept_manager.dept_no
WHERE dept_manager.to_date = "9999-01-01" AND salaries.to_date = "9999-01-01"
GROUP BY department_name , first_last, salary
HAVING MAX(salary);

# 6. Find the number of current employees in each department.

SELECT departments.dept_no , dept_name, COUNT(*) AS num_employees
FROM employees
JOIN dept_emp ON dept_emp.emp_no = employees.emp_no
JOIN departments ON departments.dept_no = dept_emp.dept_no
WHERE dept_emp.to_date = "9999-01-01"
GROUP BY dept_name
ORDER BY dept_no;

# 7. Which department has the highest average salary? Hint: Use current not historic information.

SELECT dept_name, AVG(salary) AS "average_salary"
FROM employees
JOIN dept_emp ON dept_emp.emp_no = employees.emp_no
JOIN departments ON departments.dept_no = dept_emp.dept_no
JOIN salaries ON salaries.emp_no = employees.emp_no
WHERE dept_emp.to_date = "9999-01-01" AND salaries.to_date = "9999-01-01"
GROUP BY dept_name
ORDER BY dept_name DESC
LIMIT 1;

# SALES 88852.9695

# 8. Who is the highest paid employee in the Marketing department?

SELECT first_name,last_name
FROM employees
JOIN dept_emp ON dept_emp.emp_no = employees.emp_no
JOIN departments ON departments.dept_no = dept_emp.dept_no
JOIN salaries ON salaries.emp_no = employees.emp_no
WHERE dept_emp.to_date = "9999-01-01" AND salaries.to_date = "9999-01-01" AND departments.dept_name = "marketing"
GROUP BY first_name, last_name
ORDER BY MAX(salary) DESC
LIMIT 1;

# Akemi Warwick, 145128

# 9. Which current department manager has the highest salary?

SELECT first_name, last_name, salary, dept_name
FROM employees
JOIN dept_emp ON dept_emp.emp_no = employees.emp_no
JOIN departments ON departments.dept_no = dept_emp.dept_no
JOIN salaries ON salaries.emp_no = employees.emp_no
JOIN dept_manager ON dept_manager.emp_no = employees.emp_no
WHERE dept_emp.to_date = "9999-01-01" AND salaries.to_date = "9999-01-01" AND dept_manager.to_date = "9999-01-01"
ORDER BY salary DESC
LIMIT 1;


# 10. BONUS- Find the names of all current employees, their department name, and their current manager's name.

SELECT CONCAT(e.first_name," ", e.last_name) AS "Full_name", d.dept_name as "department_name", CONCAT(e1.first_name," ",e1.last_name) AS "manager_name"
FROM employees AS e
JOIN dept_emp AS de ON de.emp_no = e.emp_no
JOIN departments AS d ON d.dept_no = de.dept_no
JOIN salaries ON salaries.emp_no = e.emp_no
JOIN dept_manager AS dm ON dm.dept_no = de.dept_no
JOIN employees AS e1 ON e1.emp_no = dm.emp_no
WHERE de.to_date = "9999-01-01" AND salaries.to_date = "9999-01-01" AND dm.to_date = "9999-01-01"
ORDER BY department_name;

# Who is the highest paid employee within each department

SELECT CONCAT (first_name," ",last_name) AS "Employee Name", dept_name AS "Department_Name", salary
FROM employees AS e
JOIN salaries AS s ON s.emp_no = e.emp_no
JOIN dept_emp AS de ON de.emp_no = e.emp_no
JOIN departments AS d ON d.dept_no = de.dept_no
WHERE de.to_date = "9999-01-01" AND s.to_date = "9999-01-01" AND salary > "115000"
ORDER BY salary DESC;