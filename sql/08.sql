/*
 * Select the title of all 'G' rated movies that have the 'Trailers' special feature.
 * Order the results alphabetically.
 *
 * HINT:
 * Use `unnest(special_features)` in a subquery.
 */

SELECT title
from ( 
       select title, rating, unnest(special_features) as u  
       from film 
       ) t
WHERE rating = 'G' 
and t.u = 'Trailers'
ORDER BY title;
