# JOIN NOTES

USE employees;

DESCRIBE titles;

DESCRIBE salaries;

DESCRIBE employees;

DESCRIBE dept_manager;

DESCRIBE dept_emp;

DESCRIBE departments;

SELECT *
FROM employees;

# ANATOMY OF A JOIN STARTS w/ A SELECT
# TALK TO TABLE A WITH A SELECT
SELECT *
FROM employees
JOIN salaries
ON salaries.emp_no = employees.emp_no; #TABLE B's column it has in common w/ table a
# ON tableB.column_of_interest = tableA.column_of_intrest

SELECT *
FROM employees
JOIN titles ON titles.emp_no = employees.emp_no
JOIN salaries ON salaries.emp_no = employees.emp_no
WHERE titles.to_date > now()
LIMIT 50;

USE join_example_db;
#Inner join gives us all A that exists in B, all B that exists in A, A and B
SELECT * 
FROM users
JOIN roles ON roles.id = users.role_id;
# LEFT JOIN
SELECT *
FROM users #LEFT JOIN MEANS WE GET ALL THE RECORDS FROM THE FIRST TABLE WE SELECT (table A)
LEFT JOIN roles ON roles.id = users.role_id; #EVEN IF THERE'S NULL INFO ON TABLE B

# RIGHT JOIN 5 ROWS
SELECT *
FROM users #RIGHT JOIN GIVES US ALL THE RECORDS FROM TABLE B, EVEN IF THE HAVE NULL
RIGHT JOIN roles ON roles.id = users.role_id;

USE quotes_db;

USE employees;

SELECT *
FROM dept_emp
WHERE dept_no = 'd005';

# SHOW ALL EMPLOYEES AND THE DEPARTMENT NAMES WHERE THEY WORK
SELECT *
FROM employees
JOIN dept_emp ON dept_emp.emp_no = employees.emp_no
JOIN departments ON dept_emp.dept_no = departments.dept_no
JOIN salaries ON salaries.emp_no = employees.emp_no
JOIN titles ON titles.emp_no = employees.emp_no;