USE employees;

# CASE STATEMENTS EXERCISES



# 1. Write a query that returns all employees (emp_no), their department number, their start date, their end date, and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not.

SELECT emp_no, dept_no, from_date AS "Start Date", to_date,
	CASE
	WHEN to_date > NOW() THEN 1
	ELSE 0
	END AS is_current_employee
FROM dept_emp;


#-------------------------------------------------TEST CODE BELOW------------------------------------------------------#
SELECT emp_no, dept_no, from_date AS "Start Date", to_date,
	IF(to_date > NOW() , True, False) AS is_current_employee
FROM dept_emp;

SELECT *, concat(first_name," ",last_name),
	CASE
		WHEN de.to_date >= now() THEN 1
		ELSE 0
		END AS is_current_employee
FROM employees AS e
WHERE de.emp_no = (
	SELECT emp_no
	FROM dept_emp
	WHERE de.to_date = (
		SELECT MAX(to_date)
		FROM dept_emp
JOIN dept_emp AS de ON dept_emp.emp_no =  employees.emp_no
GROUP BY is_current_employee
));

SELECT *,
	CASE
	WHEN to_date >= NOW() THEN 1
	ELSE 0
	END AS is_current_employee
FROM dept_emp AS de
JOIN employees AS e ON e.emp_no = de.emp_no
WHERE to_date = (
	SELECT 
		CASE
		WHEN (
			SELECT emp_no,COUNT(emp)
			FROM dept_emp
			GROUP BY emp_no AS emp) > 1 THEN "9999-01-01"
		ELSE to_date
		END AS count
		FROM dept_emp
);

#-------------------------------------------------TEST CODE BELOW------------------------------------------------------#


# 2. Write a query that returns all employee names (previous and current), and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.

SELECT last_name,
	CASE
	WHEN last_name BETWEEN "A" AND "Hz%" THEN "A-H"
	WHEN last_name BETWEEN "I" AND "Qz%" THEN "I-Q"
	WHEN last_name BETWEEN "R" AND "Zz%" THEN "R-Z"
	ELSE "OTHER"
	END AS alpha_group
FROM employees
ORDER BY birth_date;

# 3. How many employees (current or previous) were born in each decade?

SELECT count(*) AS "# of employees",
	CASE
	WHEN birth_date BETWEEN "1950-01-01" AND "1959-12-31" THEN "1950s"
	WHEN birth_date BETWEEN "1960-01-01" AND "1969-12-31" THEN "1960s"
	ELSE "OTHER"
	END AS decade_born
FROM employees
GROUP BY decade_born;

# BONUS----------------------



# 1. What is the current average salary for each of the following department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?


SELECT 
	CASE
		WHEN dept_name IN ("Research","Development") THEN "R&D"
		 WHEN dept_name IN ("Sales","Marketing") THEN "Sales & Marketing"
		 WHEN dept_name IN ("Production","Quality Management") THEN "Prod & QM"
		 WHEN dept_name IN ("Finance","Human Resources") THEN "Finance & HR"
		WHEN dept_name IN ("Customer Service") THEN "Customer Service"
		ELSE "OTHER"
	END AS department_groups , AVG(salary)
FROM salaries
JOIN dept_emp AS de ON de.emp_no = salaries.emp_no
JOIN departments AS d ON d.dept_no = de.dept_no
WHERE salaries.to_date = "9999-01-01"
GROUP BY department_groups
ORDER BY AVG(salary) DESC;