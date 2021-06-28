USE titanic_db;

SELECT *
FROM passengers;

DESCRIBE passengers;

SELECT *
FROM passengers
LIMIT 10;

SELECT COUNT(*) AS number_of_passengers
FROM passengers;

SELECT DISTINCT class
FROM passengers;

SELECT class
FROM passengers
GROUP BY class;

SELECT class
FROM passengers
GROUP BY class
ORDER BY class DESC;

SELECT DISTINCT sex
FROM passengers;

SELECT sex
FROM passengers
GROUP BY sex;

SELECT sex, class
FROM passengers
GROUP BY sex, class;

SELECT sex, COUNT(*) AS number_of_passengers
FROM passengers
GROUP BY sex;

SELECT sex, COUNT(sex) AS number_of_passengers_with_a_value_for_sex
FROM passengers
GROUP BY sex;

SELECT *
FROM passengers;

SELECT deck, COUNT(deck) AS 'non_null_values', COUNT(*) AS "all_roles"
FROM passengers
GROUP BY deck;

SELECT sex,class,COUNT(*) as num_of_passengers
FROM passengers
GROUP BY sex,class;

-- GROUP BY EXERCISE

USE employees;

SELECT *
FROM titles;

-- In your script, use DISTINCT to find the unique titles in the titles table. How many unique titles have there ever been? Answer that in a comment in your SQL file.

SELECT DISTINCT title
FROM titles;

-- THERE ARE 7 UNIQUE TITLES.

-- # 3 Write a query to to find a list of all unique last names of all employees that start and end with 'E' using GROUP BY.

SELECT DISTINCT last_name
FROM employees
WHERE last_name LIKE "e%e"
GROUP BY last_name;

-- Erde, Eldridge, Etalle, Erie, Erbe

-- Write a query to to find all unique combinations of first and last names of all employees whose last names start and end with 'E'.

SELECT DISTINCT first_name, last_name
FROM employees
WHERE last_name LIKE "e%e"
GROUP BY first_name, last_name;

-- Write a query to find the unique last names with a 'q' but not 'qu'. Include those names in a comment in your sql code.

SELECT DISTINCT last_name
FROM employees
WHERE (last_name LIKE "%q%") AND last_name NOT LIKE "%qu%";

-- Chleq, Lindqvist, Qiwen

-- Add a COUNT() to your results (the query above) to find the number of employees with the same last name.

SELECT DISTINCT last_name, COUNT(last_name) AS "shared_last_name"
FROM employees
WHERE (last_name LIKE "%q%") AND last_name NOT LIKE "%qu%"
GROUP BY last_name;

-- Chleq 189, Lindqvist 190, Qiwen 168.

-- Find all all employees with first names 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) and GROUP BY to find the number of employees for each gender with those names.

SELECT first_name, gender, COUNT(*)
FROM employees
WHERE first_name IN ('Irena', 'Vidya','Maya')
GROUP BY first_name,gender;

-- Using your query that generates a username for all of the employees, generate a count employees for each unique username. Are there any duplicate usernames? BONUS: How many duplicate usernames are there?

SELECT *
FROM employees;

SELECT LOWER(CONCAT(substr(first_name,1,1),SUBSTR(last_name,1,4),"_",SUBSTR(birth_date,6,2),SUBSTR(birth_date,3,2))) AS "user_name", COUNT(*) AS "user_count"
FROM employees
GROUP BY user_name
HAVING user_count != 1
ORDER BY user_count desc;

-- YES, 13251