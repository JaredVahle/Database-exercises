
# EMPLOYEES DATABASE
USE employees;
# 1. How much do the current managers of each department get paid, relative to the average salary for the department? Is there any department where the department manager gets paid less than the average salary?

SELECT salary, salaries.emp_no, dm.dept_no
FROM salaries
JOIN dept_manager AS dm ON dm.emp_no = salaries.emp_no
JOIN departments AS d ON d.dept_no = dm.dept_no
WHERE salaries.to_date = "9999-01-01" AND dm.to_date = "9999-01-01"; # THIS QUERY GIVES YOU THE SALARY OF ALL THE CURRENT MANAGERS

SELECT dept_no
FROM salaries AS s
JOIN dept_emp AS de ON de.emp_no = s.emp_no
JOIN departments AS d ON d.dept_no = de.dept_no
WHERE s.to_date = "9999-01-01"
GROUP BY d.dept_no;

#----------------------------------------------UNFINISHED-------------------------------------#

# WORLD DATABASE
USE WORLD;
# 1. What languages are spoken in Santa Monica?

SELECT *
FROM city
WHERE name LIKE ("Santa Monica");

SELECT language, percentage
FROM city
JOIN country AS c ON c.code = city.countrycode
JOIN countrylanguage AS cl ON cl.countrycode = city.countrycode
WHERE city.name LIKE ("Santa Monica")
ORDER BY percentage;
# 2. How many diffrent countries are in each region

SELECT *
FROM city
JOIN country AS c ON c.code = city.countrycode
JOIN countrylanguage AS cl ON cl.countrycode = city.countrycode;

SELECT region, count(*)
FROM city
JOIN country AS c ON c.code = city.countrycode
JOIN countrylanguage AS cl ON cl.countrycode = city.countrycode
GROUP BY region;

SELECT region, count(name) AS "num_of_countries"
FROM country
GROUP BY region
ORDER BY num_of_countries;

# 3. What is the population for each region?

SELECT region, SUM(population) AS population
FROM country AS c
GROUP BY region
ORDER BY population DESC;

# 4. What is the population for each continent?

SELECT continent, SUM(population) AS population
FROM country AS c
GROUP BY continent
ORDER BY population DESC;

# 5. What is the average life expectancy globally?

SELECT AVG(LifeExpectancy)
FROM country;

# 6. What is the average life expectancy for each region, each continent? Sort the results from shortest to longest

SELECT region,AVG(LifeExpectancy) AS life_expectancy
FROM country
GROUP BY region
ORDER BY life_expectancy;

SELECT continent,AVG(LifeExpectancy) AS life_expectancy
FROM country
GROUP BY continent
ORDER BY life_expectancy;