--If F5 stops working, just hit the shazam (execute) button.

--How many films are in inventory?
SELECT COUNT(*) AS film_count
FROM film

--What does a sample output of the films table look like?
SELECT *
FROM film
LIMIT 100 --This is system specific

--What films are longer than three hours? Order by title reverse alphabetical order
SELECT title, release_year, rental_duration, rating
FROM film
WHERE length >= 180
ORDER BY title DESC

--What films are longer than three hours and have a rental duration of a week ordered by rating?
SELECT title, length/60.0 AS length_in_hours, release_year, rental_duration, rating
FROM film
WHERE length >= 180
AND rental_duration = 7
ORDER BY rating

--What are the max and min rental rates of the movies in inventory?
SELECT MAX(rental_rate) AS max_rate, MIN(rental_rate) AS min_rate
FROM film

--What is the average rental rate?
SELECT AVG(rental_rate)
FROM film

--Find the range of dates in the payment table.
SELECT MIN(payment_date), MAX(payment_date)
FROM payment

--What customers made a payment in May?
SELECT c.customer_id, c.first_name, c.last_name, p.payment_date
FROM customer c
JOIN payment p
ON c.customer_id = p.customer_id
WHERE payment_date >= '20070401'
ORDER BY p.payment_date

--What is the average payment by customer?
SELECT c.customer_id, c.first_name, c.last_name, AVG(p.amount) AS average_payment
FROM customer c
JOIN payment p
ON c.customer_id = p.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY AVG(p.amount) DESC






