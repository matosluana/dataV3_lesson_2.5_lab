USE sakila;

-- Select all the actors with the first name ‘Scarlett’.
SELECT * FROM sakila.actor
WHERE first_name='Scarlett';

-- How many films (movies) are available for rent and how many films have been rented?
-- Assuming that the question wants to know how many copies are available for rent right now and how many are currently rented. 

SELECT COUNT(film_id)  AS "total_movies" FROM sakila.inventory; -- 4581 movies in total
SELECT (COUNT(rental_date)-COUNT(return_date)) AS "rented_movies" from sakila.rental; -- 183 rented movies
SELECT 4581-183; -- 4398 films available right now

-- Question from me:
-- Is there a way to create a new table with those data and make the subtraction in the table?



-- What are the shortest and longest movie duration? Name the values max_duration and min_duration.
SELECT max(length) AS "max_duration", min(length) AS "min_duration" FROM sakila.film;

-- What's the average movie duration expressed in format (hours, minutes)?
SELECT
	concat(floor((AVG(length))/60),":",round((AVG(length))%60,0)) AS "average_length"
from sakila.film;


-- How many distinct (different) actors' last names are there?
SELECT COUNT(DISTINCT(last_name)) from sakila.actor;

-- Since how many days has the company been operating (check DATEDIFF() function)?
-- There is no information about the opening of stores, so I will use the rental information as base

SELECT DATEDIFF(MAX(last_update),MIN(rental_date)) AS "days_of_operation" from sakila.rental;


-- Show rental info with additional columns month and weekday. Get 20 results.

SELECT *, date_format(CONVERT(left(rental_date,12),date), '%M') AS 'rental_month',
CASE
WHEN WEEKDAY(left(rental_date,12))=0 then 'Monday' 
WHEN WEEKDAY(left(rental_date,12))=1 then 'Tuesday'
WHEN WEEKDAY(left(rental_date,12))=2 then 'Wednesday' 
WHEN WEEKDAY(left(rental_date,12))=3 then 'Thursday' 
WHEN WEEKDAY(left(rental_date,12))=4 then 'Friday' 
WHEN WEEKDAY(left(rental_date,12))=5 then 'Saturday' 
WHEN WEEKDAY(left(rental_date,12))=6 then 'Sunday' 
ELSE 'No date information'
END AS "rental_day"
FROM sakila.rental
LIMIT 20;


-- Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week.

SELECT *,
CASE
WHEN WEEKDAY(left(rental_date,12))<=4 then 'Weekday' -- 0 = Monday, 1=Tuesday.... 
WHEN WEEKDAY(left(rental_date,12))>4 then 'Weekend'
ELSE 'No date information'
END AS 'rental_day_week'
FROM sakila.rental;


-- Get release years.
SELECT DISTINCT(release_year) from sakila.film;

-- Get all films with ARMAGEDDON in the title.

SELECT * FROM sakila.film
WHERE title LIKE "%ARMAGEDDON%";

-- Get all films which title ends with APOLLO.

SELECT * FROM sakila.film
WHERE title LIKE "%APOLLO";

-- Get 10 the longest films.
SELECT * from sakila.film
ORDER by length DESC
LIMIT 10;

-- since all top 10 are 185 min long I will expand the list, to see if there are more films with this length
SELECT * from sakila.film
ORDER by length DESC
LIMIT 20;
-- There are not! :)

-- How many films include Behind the Scenes content?
SELECT count(title) FROM sakila.film
WHERE special_features LIKE "%Behind the Scenes%"; -- returns 538 titles

