# SUB-QUERY's exercises
USE employees;
# 1. Find all the current employees with the same hire date as employee 101010 using a sub-query.
SELECT first_name,last_name
FROM employees
WHERE hire_date IN (
	SELECT hire_date
	FROM employees
	WHERE emp_no = "101010"
);

# 2. Find all the titles ever held by all current employees with the first name Aamod. ----------

SELECT title , emp_no
FROM titles
WHERE emp_no IN (
	SELECT emp_no
	FROM employees
	WHERE first_name = "Aamod" AND emp_no IN (
		SELECT emp_no
		FROM dept_emp
		WHERE to_date = "9999-01-01"
));


# 3. How many people in the employees table are no longer working for the company? Give the answer in a comment in your code. --------

SELECT CONCAT(first_name," ",last_name) AS "EX-EMPLOYEES"
FROM employees
WHERE emp_no IN (
	SELECT emp_no
	FROM dept_emp
	WHERE to_date != "9999-01-01"
);

# 85108


# 4. Find all the current department managers that are female. List their names in a comment in your code. --------

SELECT CONCAT(first_name," ",last_name) AS "CURRENT_FEMALE_MANAGERS"
FROM employees 
WHERE gender = "F" AND emp_no IN (
	SELECT emp_no
	FROM dept_manager
	WHERE to_date = "9999-01-01"
);


# 5. Find all the employees who currently have a higher salary than the companies overall, historical average salary.-----

SELECT CONCAT(first_name," ",last_name) AS "EMPLOYEES TO MAKE FRIENDS WITH"
FROM employees
WHERE emp_no IN (
	SELECT emp_no
	FROM salaries
	WHERE salary > (
		SELECT AVG(salary)
		FROM salaries
));

SELECT AVG(salary)
FROM salaries;

# 6. How many current salaries are within 1 standard deviation of the current highest salary? (Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this?

SELECT salary
FROM salaries
WHERE salary IN (
	SELECT STDDEV(salary)
	FROM salaries
	WHERE salary = (
		SELECT MAX(salary)
		FROM salaries
		WHERE to_date = "9999-01-01"
));
# ASK FOR HELP TOMORROW

# BONUS QUESTIONS

# 1.Find all the department names that currently have female managers.

SELECT dept_name AS "DEPARTMENTS_WITH_FEMALE_MANAGERS"
FROM departments
WHERE dept_no IN (
	SELECT dept_no
	FROM dept_manager
	WHERE to_date = "9999-01-01" AND emp_no IN (
		SELECT emp_no
		FROM employees
		WHERE gender = "f"
));
# 2.Find the first and last name of the employee with the highest salary.

SELECT CONCAT(first_name," ", last_name) AS "HIGHEST EARNER"
FROM employees
WHERE emp_no IN (
	SELECT emp_no
	FROM salaries
	WHERE salary = (
		SELECT MAX(salary)
		FROM salaries
));


# 3.Find the department name that the employee with the highest salary works in.

SELECT dept_name AS "DEPARTMENT_WITH_HIGHES_PAID_EMPLOYEE"
FROM departments
WHERE dept_no IN (
	SELECT dept_no
	FROM dept_emp
	WHERE emp_no = (
		SELECT emp_no
		FROM employees
		WHERE emp_no = (
			SELECT emp_no
			FROM salaries
			WHERE salary = (
				SELECT MAX(salary)
				FROM salaries
))));
