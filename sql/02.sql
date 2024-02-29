/*
 * A film's rating can be either G, PG, PG-13, etc.
 * First, generate a query that returns the two most popular ratings.
 * Then, use a subquery to select the film_id and title columns
 * for all films whose rating is one of the two most popular.
 * Use the film table and order by title.
 */

-- Find the two most popular ratings
WITH RatingCounts AS (
    SELECT rating, COUNT(*) AS rating_count
    FROM film
    GROUP BY rating
    ORDER BY rating_count DESC
    LIMIT 2
)
-- Select film_id and title for films with one of the two most popular ratings
SELECT film_id, title
FROM film
WHERE rating IN (
    SELECT rating
    FROM RatingCounts
)
ORDER BY title;
