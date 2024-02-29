/*
 * A group of social scientists is studying American movie watching habits.
 * To help them, select the titles of all films that have never been rented by someone who lives in the United States.
 *
 * NOTE:
 * Not every film in the film table is available in the store's inventory,
 * and you should only return films in the inventory.
 *
 * NOTE:
 * This can be solved by either using a LEFT JOIN or by using the NOT IN clause and a subquery.
 * For this problem, you should use the NOT IN clause;
 * in problem 07b you will use the LEFT JOIN clause.
 *
 * NOTE:
 * This is the last problem that will require you to use a particular method to solve the query.
 * In future problems, you may choose whether to use the LEFT JOIN or NOT IN clause if they are more applicable.
 */

SELECT distinct film.title
FROM film
JOIN inventory ON film.film_id = inventory.film_id
WHERE film.film_id NOT IN (
    SELECT DISTINCT inventory.film_id
    FROM rental
    JOIN inventory ON rental.inventory_id = inventory.inventory_id
    JOIN customer ON rental.customer_id = customer.customer_id
    JOIN address on customer.address_id = address.address_id
    JOIN city on address.city_id = city.city_id
    JOIN country on city.country_id = country.country_id
    WHERE country ILIKE '%United States%'
)
order by film.title;
