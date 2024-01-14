-- dimdate table

INSERT INTO dimdate(
	date_key,
	date,
	year,
	quarter,
	month,
	week,
	day,
	is_weekend
	
)
SELECT 
	DISTINCT (TO_CHAR(payment_date :: DATE, 'yyMMDD') :: integer) as date_key,
	date(payment_date) as date,
	EXTRACT(year from payment_date) AS year,
	EXTRACT(quarter from payment_date) AS quarter,
	EXTRACT(month from payment_date) AS month,
	EXTRACT(week from payment_date) AS week,
	EXTRACT(day from payment_date) AS day,
	CASE WHEN EXTRACT(ISODOW FROM payment_date) IN (6,7) THEN true ELSE false END
	FROM payment;
	
--dimcustomer table

INSERT INTO dimcustomer(
	customer_key,
	customer_id,
	first_name,
	last_name,
	email,
	address,
	address2,
	district,
	city,
	country,
	postal_code,
	phone,
	active,
	create_date,
	start_date,
	end_date
)

SELECT 
	c.customer_id as customer_key,
	c.customer_id,
	c.first_name,
	c.last_name,
	c.email,
	a.address,
	a.address2,
	a.district,
	ct.city,
	cy.country,
	a.postal_code,
	a.phone,
	c.active,
	c.create_date,
	now() AS start_date,
	now() AS end_date
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ct ON a.city_id = ct.city_id
JOIN country cy ON ct.country_id = cy.country_id

--dimmovie

INSERT INTO dimmovie(
	movie_key,
	film_id,
	title,
	description,
	release_year,
	language,
	original_language,
	length,
	rating,
	speacial_features
)

SELECT 
	f.film_id AS movie_key,
	f.film_id,
	f.title,
	f.description,
	f.release_year,
	l.name,
	l.name AS original_language,
	f.length,
	f.rating,
	f.special_features
FROM film f
JOIN language l ON f.language_id = l.language_id;
	
--dimstore

INSERT INTO dimstore(
	store_key,
	store_id,
	address,
	address2,
	district,
	city,
	country,
	postal_code,
	manager_first_name,
	manager_last_name,
	start_date,
	end_date
)

SELECT 
	s.store_id AS store_key,
	s.store_id,
	a.address,
	a.address2,
	a.district,
	ct.city,
	cy.country,
	a.postal_code,
	sf.first_name AS manager_first_name,
	sf.last_name AS manager_last_name,
	now() AS start_date,
	now() AS end_date
FROM store s
JOIN address a ON s.address_id = a.address_id
JOIN city ct ON a.city_id = ct.city_id
JOIN country cy ON ct.country_id = cy.country_id
JOIN staff sf ON s.staff_id = sf.staff_id

--factsales

INSERT INTO factsales(
	date_key,
	customer_key,
	movie_key,
	store_key,
	sales_amount
)

SELECT 
	TO_CHAR(payment_date :: DATE, 'yyMMDD') :: integer AS date_key,
	p.customer_id as customer_key,
	i.film_id as movie_key,
	i.store_id AS store_key,
	p.amount AS sales_amount
FROM payment p
JOIN rental r ON p.rental_id = r.rental_id
JOIN inventory i ON r.inventory_id = i.inventory_id;