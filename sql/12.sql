/*
 * List the title of all movies that have both the 'Behind the Scenes' and the 'Trailers' special_feature
 *
 * HINT:
 * Create a select statement that lists the titles of all tables with the 'Behind the Scenes' special_feature.
 * Create a select statement that lists the titles of all tables with the 'Trailers' special_feature.
 * Inner join the queries above.
 */

select film.title
FROM film
join (select film.title 
	from film 
	where 'Trailers' = ANY (film.special_features)
) as a on film.title = a.title
WHERE 'Behind the Scenes' = ANY (film.special_features)
order by film.title;
