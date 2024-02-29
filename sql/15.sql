/*
 * Compute the total revenue for each film.
 */
SELECT
    f.title,
    COALESCE(SUM(p.amount), 0.00) as revenue
FROM
    film f
left JOIN
    inventory i ON f.film_id = i.film_id
left join
    rental r ON i.inventory_id = r.inventory_id
left join 
    payment p ON r.rental_id = p.rental_id
left join
    customer c ON r.customer_id = c.customer_id
GROUP BY
    f.title
ORDER BY
    revenue DESC; 
