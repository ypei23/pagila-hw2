/*
 * This problem is the same as 07.sql,
 * but instead of using the NOT IN operator, you are to use a LEFT JOIN.
 */

SELECT DISTINCT film.title
FROM film
JOIN inventory USING (film_id) 
left join (
    SELECT DISTINCT country, film_id
    FROM film 
    JOIN inventory USING (film_id)  
    JOIN rental USING (inventory_id) 
    JOIN customer USING (customer_id) 
    JOIN address USING (address_id) 
    JOIN city USING (city_id)
    JOIN country USING (country_id) 
    WHERE country ILIKE '%United States%'
) t using (film_id) 
where country is null; 
