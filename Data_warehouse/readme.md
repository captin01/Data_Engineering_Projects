
# 3NF TO STAR SCHEMA

## Introduction

The data set used was from [**DVDrental**](https://www.postgresqltutorial.com/postgresql-getting-started/postgresql-sample-database/)

## Overview
This documentation outlines the **_process of changing a Third Normal Form (3NF) schema to a Star Schema_** in a DVD Rental Database using PostgreSQL. The goal is to optimize the **_database structure for data warehousing and analytical querying_**, improving performance and ease of analysis.

## Prerequisites 
- PostgreSQL database with the DVD Rental sample database installed

>[!NOTE]
>
> Information on how to both **download and load the dataset to PostgreSQL** is clearly stated in the website provided.
>
>If loading the data using PostgreSQL GUI refuses/gives an error use the sql server but make sure the directory is in **bin** when loading the dataset.

- Basic knowledge of SQL and database concepts. [**learn sql**](https://youtu.be/5OdVJbNCSso?si=ow-JA5Nh50Fwo85l)

- Access to PostgreSQL command-line interface (psql) or a PostgreSQL client.
[**Downloading PostgreSQL**](https://www.postgresql.org/download/)

## Walkthrough

- <u>Original 3NF(Third Normal Form) Schema</u>

![image](https://github.com/captin01/Data_Engineering_Projects/assets/114471010/b81366e8-cca1-4953-a988-4c2c852c9b81)

- <u>Final Star Schema</u> 

![dvdrentalERD drawio](https://github.com/captin01/Data_Engineering_Projects/assets/114471010/271ccb0c-2d83-4c4f-b51b-1ca2e23876f2)

### Identfying the Fact and Dimension table.
- By Identfying what will be the fact table it makes the process easier when creating tables (Fact and Dimension) 
- As shown from the images above the Sales table was identified as the fact table and (Date, Customer, Movie, Store) as dimension tables.

### Creating a Star Schema
- The example below shows how both the Fact and one dimensional table was created.

#### <u>***Fact***</u>
```
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
```
#### <u>***Dimensional Table***</u>
```
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
	end_date date NOT NULL)
```

### Inserting the data into the created tables

- Using the same table examples above, the insert syntax will be used to add data into them.

#### <u>***Fact***</u>
```
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
```

#### <u>***Dimensional Table***</u>
```
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
```

### Explantion on data insertion 
- You'll notice that there's a part where specific columns are called out in order to add data into them respectively.
- ALL COLUMNS are following the same order during the insertion process to prevent adding data into the wrong columns. 

## THE END TILL NEXT TIME.
![bonk-meme](https://github.com/captin01/Data_Engineering_Projects/assets/114471010/8206930b-cf2d-4e94-a229-83903d90a129)