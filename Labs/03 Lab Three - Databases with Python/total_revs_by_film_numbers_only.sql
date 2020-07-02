-- =============================================
-- Author: Bob Wakefield
-- Create date: 15Jan19
-- Description: Feature engineering on total_revs_by_film
-- =============================================

DROP VIEW IF EXISTS total_revs_by_film_numbers_only;

CREATE VIEW total_revs_by_film_numbers_only AS
WITH revs_by_film(film_id, amount) AS (
SELECT i.film_id,
SUM(p.amount) AS sum
FROM inventory i
JOIN rental r 
ON i.inventory_id = r.inventory_id
JOIN payment p 
ON r.rental_id = p.rental_id
GROUP BY i.film_id
)
SELECT
f.release_year,
f.rental_duration,
f.rental_rate,
f.length,
CASE
WHEN f.rating = 'NC-17' THEN 1 
ELSE 0
END AS is_nc17,
CASE
WHEN f.rating = 'G' THEN 1 
ELSE 0
END AS is_g,
CASE
WHEN f.rating = 'PG-13' THEN 1 
ELSE 0
END AS is_pg13,
CASE
WHEN f.rating = 'PG' THEN 1 
ELSE 0
END AS is_pg,
CASE
WHEN f.rating = 'R' THEN 1 
ELSE 0
END AS is_R,
CASE
WHEN c.name = 'Animation' THEN 1 
ELSE 0
END AS is_animation,
CASE
WHEN c.name = 'Travel' THEN 1 
ELSE 0
END AS is_travel,
CASE
WHEN c.name = 'Music' THEN 1 
ELSE 0
END AS is_music,
CASE
WHEN c.name = 'Horror' THEN 1 
ELSE 0
END AS is_horror,
CASE
WHEN c.name = 'Drama' THEN 1 
ELSE 0
END AS is_drama,
CASE
WHEN c.name = 'Sci-Fi' THEN 1 
ELSE 0
END AS is_scifi,
CASE
WHEN c.name = 'Games' THEN 1 
ELSE 0
END AS is_games,
CASE
WHEN c.name = 'Documentary' THEN 1 
ELSE 0
END AS is_documentary,
CASE
WHEN c.name = 'Foreign' THEN 1 
ELSE 0
END AS is_foreign,
CASE
WHEN c.name = 'Action' THEN 1 
ELSE 0
END AS is_action,
CASE
WHEN c.name = 'Children' THEN 1 
ELSE 0
END AS is_children,
CASE 
WHEN rbf.amount IS NOT NULL THEN rbf.amount
ELSE 0.00
END AS total_revs
FROM language l
JOIN film f 
ON l.language_id = f.language_id
JOIN film_category fc 
ON f.film_id = fc.film_id
JOIN category c 
ON c.category_id = fc.category_id
LEFT JOIN revs_by_film rbf 
ON f.film_id = rbf.film_id;


