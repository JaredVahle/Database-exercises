-- 1. Create a file named where_exercises.sql. Make sure to use the employees database.
USE employees;
-- Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?
SELECT *
FROM employees
WHERE first_name IN ("Irena", "Vidya", "Maya")
ORDER BY first_name DESC;

-- IRENA REUTENAUER, VIDYA AWDEH

-- Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name and then last name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?
SELECT *
FROM employees
WHERE first_name = "Irena" OR first_name = "Vidya" OR first_name = "Maya"
ORDER BY first_name DESC, last_name DESC;

-- IRENA ACTON, VIDYA ZWEIZIG

-- Write a query to to find all employees whose last name starts and ends with 'E'. Sort the results by their employee number. Enter a comment with the number of employees returned, the first employee number and their first and last name, and the last employee number with their first and last name.
SELECT *
FROM employees
WHERE last_name LIKE "e%e"
ORDER BY emp_no DESC;

-- 899, 10021 RAMZI ERDE, 499648 TADAHIRO ERDE

-- Write a query to to find all employees whose last name starts and ends with 'E'. Sort the results by their hire date, so that the newest employees are listed first. Enter a comment with the number of employees returned, the name of the newest employee, and the name of the oldest emmployee.
SELECT *
FROM employees
WHERE last_name LIKE "e%e"
ORDER BY hire_date DESC;

-- 899, SERGI ERDE, TEIJI ELDRIDGE


-- Find all employees hired in the 90s and born on Christmas. Sort the results so that the oldest employee who was hired last is the first result. Enter a comment with the number of employees returned, the name of the oldest employee who was hired last, and the name of the youngest emmployee who was hired first.

SELECT *
FROM employees
WHERE (hire_date LIKE "199%") AND  hire_date LIKE "%-12-25"
ORDER BY birth_date DESC, hire_date ASC;

-- LUCIAN MENHOUDJ, LENA LENART