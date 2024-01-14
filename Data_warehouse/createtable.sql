CREATE TABLE dimCustomer(
	customer_key SERIAL PRIMARY KEY,
	customer_id smallint NOT NULL,
	first_name varchar(45) NOT NULL,
	last_name varchar(45) NOT NULL,
	email varchar(50),
	address varchar(50) NOT NULL,
	address varchar(50)
	district varchar(20) NOT NULL,
	city varchar(50) NOT NULL,
	country varchar(50) NOT NULL,
	postal_code varchar(10),
	phone varchar(20),
	active smallint NOT NULL,
	create_date timestamp NOT NULL,
	start_date date NOT NULL,
	end_date date NOT NULL
	
);

CREATE TABLE dimDate(
	date_key integer NOT NULL PRIMARY KEY,
	date date NOT NULL,
	year smallint NOT NULL,
	quarter smallint NOT NULL,
	month smallint NOT NULL,
	day smallint NOT NULL,
	week smallint NOT NULL,
	is_weekend boolean
);

CREATE TABLE dimMovie(
	movie_key SERIAL PRIMARY KEY,
	film_id smallint NOT NULL,
	title varchar(250) NOT NULL,
	description text,
	release_year year,
	language varchar(20) NOT NULL,
	original_language varchar(20),
	rental_duration smallint NOT NULL,
	length smallint NOT NULL,
	rating varchar(5) NOT NULL,
	special_features varchar(60) NOT NULL
);

CREATE TABLE dimStore(
	store_key SERIAL PRIMARY KEY,
	store_id smallint NOT NULL,
	address varchar(50) NOT NULL,
	address2 varchar(50),
	district varchar(20) NOT NULL,
	city varchar(50) NOT NULL,
	country varchar(50) NOT NULL,
	postal_code varchar(10),
	manager_first_name varchar(45) NOT NULL,
	manager_last_name varchar(45) NOT NULL,
	start_date date NOT NULL,
	end_date date NOT NULL
);

CREATE TABLE factsales(
	sales_key SERIAL PRIMARY KEY,
	date_key,
	customer_key,
	movie_key,
	store_key,
	sales_amount decimal(10,2) NOT NULL
	
FOREIGN KEY date_key REFERENCES dimDate(date_key)
FOREIGN KEY customer_key REFERENCES dimCustomer(customer_key)
FOREIGN KEY movie_key REFERENCES dimMovie(movie_key)
FOREIGN KEY store_key REFERENCES dimStore(store_key)
);
