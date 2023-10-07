-- 1. Give the name, release year, and worldwide gross of the lowest grossing movie.

SELECT film_title, release_year, worldwide_gross
FROM specs
FULL JOIN revenue
USING (movie_id)
ORDER BY worldwide_gross;

--ANSWER: Semi-Tough, 1977, $37,187,139



-- 2. What year has the highest average imdb rating?

SELECT release_year, AVG(imdb_rating) as avg_rating
FROM specs
FULL JOIN rating
USING (movie_id)
GROUP BY release_year
ORDER BY avg_rating DESC;

--ANSWER: 1991


-- 3. What is the highest grossing G-rated movie? Which company distributed it?

SELECT film_title, company_name, worldwide_gross
FROM specs
FULL JOIN revenue
USING (movie_id)
FULL JOIN distributors
ON domestic_distributor_id=distributor_id
WHERE mpaa_rating = 'G'
ORDER BY worldwide_gross DESC;

--ANSWER: Toy Story 4, Walt Disney

SELECT *
FROM revenue



-- 4. Write a query that returns, for each distributor in the distributors table, the distributor name and the number of movies associated with that distributor in the movies table. Your result set should include all of the distributors, whether or not they have any movies in the movies table.

SELECT company_name, COUNT(film_title) as number_of_movies
FROM distributors
LEFT JOIN specs
ON distributor_id=domestic_distributor_id
GROUP BY company_name
ORDER BY number_of_movies DESC;



-- 5. Write a query that returns the five distributors with the highest average movie budget.

SELECT company_name, AVG(film_budget) AS avg_budget
FROM distributors
FULL JOIN specs
ON distributor_id=domestic_distributor_id
INNER JOIN revenue
USING (movie_id)
GROUP BY company_name
ORDER BY avg_budget DESC
LIMIT 5;



-- 6. How many movies in the dataset are distributed by a company which is not headquartered in California? Which of these movies has the highest imdb rating?

SELECT film_title, headquarters, imdb_rating
FROM specs
FULL JOIN distributors
ON domestic_distributor_id=distributor_id
FULL JOIN rating
USING (movie_id)
WHERE headquarters NOT LIKE '%, CA%';

--ANSWER: 2; Dirty Dancing



-- 7. Which have a higher average rating, movies which are over two hours long or movies which are under two hours?

SELECT AVG(imdb_rating) AS avg_rating
FROM rating
FULL JOIN specs
USING (movie_id)
WHERE length_in_min>120

SELECT AVG(imdb_rating) AS avg_rating
FROM rating
FULL JOIN specs
USING (movie_id)
WHERE length_in_min<=120

SELECT specs.length_in_min>120 AS films_greater_than_2_hours, specs.length_in_min<=120 AS films_2_hours_or_less, AVG(imdb_rating) AS avg_rating
FROM rating
FULL JOIN specs
USING (movie_id)
GROUP BY specs.length_in_min>120, specs.length_in_min<=120
--Tried to put it all in one script.

--ANSWER: movies which are over 2 hours long