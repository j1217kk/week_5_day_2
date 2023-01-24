-- FULL OUTER
SELECT first_name, last_name, 

--INNER JOIN to see which actors were in which films by id
SELECT actor.actor_id, first_name, last_name, film_id
FROM film_actor
INNER JOIN actor
ON actor.actor_id = film_actor.actor_id;

-- double INNER join to see which actors where in which films by film title
SELECT actor.actor_id, first_name, last_name, film.film_id, title
FROM film_actor
INNER JOIN actor
ON actor.actor_id = film_actor.actor_id
INNER JOIN film
ON film_actor.film_id = film.film_id;

SELECT actor.actor_id, first_name, last_name, film_id
FROM film_actor
LEFT JOIN actor
ON actor.actor_id = film_actor.actor_id
WHERE first_name IS NULL and last_name is NULL;

-- Query for actors who are not in any movies
-- FULL JOIN
SELECT actor.actor_id, first_name, last_name, film_id
FROM actor
FULL JOIN film_actor
ON actor.actor_id = film_actor.actor_id
WHERE film_id IS NULL;

-- JOIN to find customers who live in Angola
SELECT first_name, last_name, country
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
INNER JOIN city
ON address.city_id = city.city_id
INNER JOIN country
ON city.country_id = country.country_id
WHERE country = 'Angola';


SELECT customer.first_name, customer.last_name, customer.email
from customer
LEFT JOIN address
ON customer.address_id = address.address_id;

-- SubQueries
-- kind of like two queries split apart and then combine the returned data
-- Fine a customer that has an amount greater than 175 in total payments

SELECT customer_id
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > 175
ORDER BY SUM(amount) DESC;

SELECT first_name, last_name, customer_id
FROM customer
WHERE customer_id = 148 OR customer_id = 526 OR customer_id = 178;

-- ^ SubQuery version
SELECT first_name, last_name, store_id
FROM customer
WHERE customer_id IN (
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount) > 175
	ORDER BY SUM(amount) DESC
)
GROUP BY store_id, first_name, last_name;

SELECT * 
FROM language; -- purple cuz it is a keyword

-- Query to select all films in English

SELECT *
FROM film
WHERE language_id IN(
	SELECT language_id
	FROM "language" -- looks for language table specifically. literally. 
	WHERE name = 'English'
);

-- Customers who live in Dallas
SELECT first_name, last_name, address_id
FROM customer
WHERE address_id IN(
	SELECT address_id
	FROM address
	WHERE city_id IN (
		SELECT city_id
		FROM city
		WHERE city = 'Dallas'
	)
);

-- Grab all movies from the action category
SELECT title, film_id
FROM film
WHERE film_id IN (
	SELECT film_id
	FROM film_category
	WHERE category_id IN (
		SELECT category_id
		FROM category
		WHERE name = 'Action'
	)
);

-- Find customers who live in Angola with a subquery
SELECT first_name, last_name
FROM customer
WHERE address_id IN(
	SELECT address_id
	FROM address
	WHERE city_id IN(
		SELECT city_id
		FROM city
		WHERE country_id IN (
			SELECT country_id
			FROM country
			WHERE country = 'Angola'
		)
	)
);

-- Grab the staff_id of the staff who has made the most rental transactions for 
-- customer who's name is Barbara Jones. 
-- Bonus points if you can bring back the staff name.

SELECT first_name, last_name, staff_id
FROM staff
WHERE staff_id IN (
	SELECT staff_id
	FROM rental
	WHERE customer_id IN (
		SELECT customer_id
		FROM customer
		WHERE first_name = 'Barbara' AND last_name = 'Jones'
	)
	GROUP BY staff_id
	ORDER BY COUNT(staff_id) DESC
	LIMIT 1
)

