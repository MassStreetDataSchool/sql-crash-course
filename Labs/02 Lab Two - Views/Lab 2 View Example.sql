-- =============================================
-- Author: Bob Wakefield
-- Create date: 15Jan19
-- Description: Pulls all customers and aggregates them by how much money they have spent.
-- =============================================

CREATE OR REPLACE VIEW customers_by_total_spent AS

SELECT
cust.first_name,
cust.last_name,
cust.email,
ads.address,
ads.address2,
c.city,
ads.postal_code,
cty.country,
CASE
WHEN cust.active = 1 THEN 'Yes'
WHEN cust.active = 0 THEN 'No'
ELSE 'Unknown'
END AS customer_is_active,
SUM(amount) AS total_revenue_from_customer
FROM country cty
JOIN city c
ON cty.country_id = c.country_id
JOIN address ads
ON c.city_id = ads.city_id
JOIN customer cust
ON ads.address_id = cust.address_id
LEFT OUTER JOIN payment p
ON cust.customer_id = p.customer_id
GROUP BY
cust.first_name,
cust.last_name,
cust.email,
ads.address,
ads.address2,
c.city,
ads.postal_code,
cty.country, 
customer_is_active