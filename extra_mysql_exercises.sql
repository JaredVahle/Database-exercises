
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


#--------------------------------------BONUS--------------------------------
USE world;
# 1. Find all the countries whose local name is different from the official name

SELECT name, localname
FROM country
WHERE name != localname;

# 2. How many countries have a life expectancy less than x?

SELECT name, lifeexpectancy
FROM country
WHERE lifeexpectancy < 70;  -- this is your X value and you can change the 70 to raise the expected life expectancy.


# 3. What state is city x located in?


SELECT *
FROM country
WHERE country.code IN (
	SELECT city.countrycode
	FROM city
	WHERE city.name = "kabul" -- This is where you put in the city name and it will return with the country information
);

SELECT Name,District
FROM city
WHERE city.name IN ("Kabul"); # This returns the district information only given city name
# 4. What region of the world is city x located in?

SELECT region, city.name 
FROM country
JOIN city ON city.countrycode = country.code
WHERE city.name IN ("Kabul"); # All you have to enter is the target city name ie. "X"

# 5. What country (use the human readable name) city x located in?

SELECT country.name AS "country_of_orgin"
FROM country
WHERE country.code = (
	SELECT city.countrycode
	FROM city
	WHERE city.name IN ("Kabul")
);
# 6. What is the life expectancy in city x?

SELECT code, name, LifeExpectancy
FROM country
WHERE country.code = (
	SELECT city.countrycode
	FROM city
	WHERE city.name IN ("Haag"));
	
# --------------------------------------------- Sakila Database Questions ------------------------------------------------

# 1. Display the first and last names in all lowercase of all the actors.

SELECT lower(first_name) AS "first_name",lower(last_name) AS "last_name"
FROM actor;

# 2. You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." What is one query would you could use to obtain this information?

SELECT *
FROM actor
WHERE first_name LIKE "joe";

# 3. Find all actors whose last name contain the letters "gen":

SELECT *
FROM actor
WHERE last_name LIKE "%gen%";

# 4. Find all actors whose last names contain the letters "li". This time, order the rows by last name and first name, in that order.

SELECT *
FROM actor
WHERE last_name LIKE "%li%";


# 5. Using IN, display the country_id and country columns for the following countries: Afghanistan, Bangladesh, and China:

SELECT country_id, country
FROM country
WHERE country IN ("Afghanistan", "Bangladesh", "China");

# 6. List the last names of all the actors, as well as how many actors have that last name.

SELECT count(last_name) , last_name
FROM actor
GROUP BY last_name;

# 7. List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors

SELECT count(last_name), last_name
FROM actor
GROUP BY last_name
HAVING count(last_name) >= 2;

# 8. You cannot locate the schema of the address table. Which query would you use to re-create it?

DESCRIBE address;

# 9. Use JOIN to display the first and last names, as well as the address, of each staff member.

SELECT first_name, last_name, address
FROM address
JOIN staff ON staff.address_id = address.address_id;

# 10. Use JOIN to display the total amount rung up by each staff member in August of 2005.

SELECT payment_id, payment_date, amount, first_name,last_name
FROM payment
JOIN staff ON staff.staff_id = payment.staff_id
WHERE payment_date LIKE "2005-08-%";

# 11. List each film and the number of actors who are listed for that film.

SELECT title, count(actor_id) AS "num_of_actors"
FROM film
JOIN film_actor ON film_actor.film_id = film.film_id
GROUP BY title
ORDER BY num_of_actors DESC;

# 12. How many copies of the film Hunchback Impossible exist in the inventory system?

SELECT title,COUNT(*) AS "num_of_copies"
FROM film
JOIN inventory AS i ON i.film_id = film.film_id
WHERE title = "hunchback impossible";

# 13. The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an unintended consequence, films starting with the letters K and Q have also soared in popularity. Use subqueries to display the titles of movies starting with the letters K and Q whose language is English.

SELECT *
FROM film
JOIN language AS l ON l.language_id = film.language_id
WHERE (film.title LIKE "k%" OR film.title LIKE "q%") AND l.language_id = 1;

# 14. Use subqueries to display all actors who appear in the film Alone Trip.

SELECT actor.actor_id, first_name,last_name, title
FROM film
JOIN film_actor ON film_actor.film_id = film.film_id
JOIN actor ON actor.actor_id = film_actor.actor_id
WHERE film.title = "alone trip";

# 15. You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers.

SELECT CONCAT (first_name , " ", last_name) AS "full_name", email
FROM customer
JOIN address USING (address_id)
JOIN city USING (city_id)
JOIN country USING (country_id)
WHERE country.country_id = 20;

# 16. Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as family films.

SELECT name, title, film_id
FROM film
JOIN film_category USING (film_id)
JOIN category USING (category_id)
WHERE category_id = 8;

# 17. Write a query to display how much business, in dollars, each store brought in.

SELECT store_id,sum(amount) AS "total_amount_sold"
FROM store
JOIN staff USING(store_id)
JOIN payment USING(staff_id)
GROUP BY store_id;

# 18. Write a query to display for each store its store ID, city, and country.

SELECT store_id, city.city, country.country
FROM store
JOIN address USING (address_id)
JOIN city USING (city_id)
JOIN country USING (country_id);

# 19. List the top five genres in gross revenue in descending order. (Hint: you may need to use the following tables: category, film_category, inventory, payment, and rental.)

SELECT category.name, sum(amount) AS "gross_revenue"
FROM category
JOIN film_category USING (category_id)
JOIN inventory USING (film_id)
JOIN rental USING (inventory_id)
JOIN payment USING (rental_id)
GROUP BY category_id;

#-----------------------------------------------------------------------------------------------------------------

# 1. SELECT statements
	# a. Select all columns from the actor table
	USE sakila;
	SELECT *
	FROM actor;
	# b. Select only the last_name column from the actor table
	SELECT last_name
	FROM actor;
	# c. Select only the following columns from the film table
	SELECT film_id, title
	FROM film;
# 2. DISTINCT operator
	# a. Select all distinct last names from the actor table
	SELECT DISTINCT last_name
	FROM actor;
	# b. Select all distinct postal codes from the address table.
	SELECT DISTINCT postal_code
	FROM address;
	# c. Select all distinct rating from the film table
	SELECT DISTINCT rating
	FROM film;
# 3. WHERE clause
	# a. Select the title, description, rating, movie length columns from the films table that last 3 hours or longer.
	SELECT title, description, rating, length
	FROM film
	WHERE length >= 180;
	
	# b. Select the payment id, amount, and payment date columns from the payments table for payments made on or after 05/27/2005.
	SELECT payment_id, amount, payment_date
	FROM payment
	WHERE payment_date BETWEEN "2005-05-27" AND NOW();
	
	# c. Select the primary key, amount, and payment date columns from the payment table for payments made on 05/27/2005.
	
	
	# d. Select all columns from the customer table for rows that have a last names beginning with S and a first names ending with N.
	
	
	# e. Select all columns from the customer table for rows where the customer is inactive or has a last name beginning with "M".
	
	
	# f. Select all columns from the category table for rows where the primary key is greater than 4 and the name field begins with either C, S or T.
	
	
	# g. Select all columns minus the password column from the staff table for rows that contain a password.
	
	
	# h. Select all columns minus the password column from the staff table for rows that do not contain a password.
	
# 4. IN operator
	# a. Select the phone and district columns from the address table for addresses in California, England, Taipei, or West Java.
	
	
	# b. Select the payment id, amount, and payment date columns from the payment table for payments made on 05/25/2005, 05/27/2005, and 05/29/2005. (Use the IN operator and the DATE function, 			instead of the AND operator as in previous exercises.)
	
	
	# c. Select all columns from the film table for films rated G, PG-13 or NC-17.
	
#5 BETWEEN operator

	# a. Select all columns from the payment table for payments made between midnight 05/25/2005 and 1 second before midnight 05/26/2005.
	
	
	# b. Select the following columns from the film table for films where the length of the description is between 100 and 120.
	
# 6. LIKE operator

	