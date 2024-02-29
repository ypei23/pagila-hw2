/*
 * Compute the total revenue for each film.
 * The output should include a new column "rank" that shows the numerical rank
 *
 * HINT:
 * You should use the `rank` window function to complete this task.
 * Window functions are conceptually simple,
 * but have an unfortunately clunky syntax.
 * You can find examples of how to use the `rank` function at
 * <https://www.postgresqltutorial.com/postgresql-window-function/postgresql-rank-function/>.
 */

/*
SELECT 
	case 
		when p.amount > 0 then 
		rank() over (order by SUM(p.amount) DESC) 
	else 
		max(rank() over (order by SUM(p.amount) DESC)) over () +1 
	end as rank, 
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
GROUP BY f.title
ORDER BY rank;
*/ 
WITH revenue_rank AS (
    SELECT
        f.title,
        COALESCE(SUM(p.amount), 0.00) AS revenue,
        RANK() OVER (ORDER BY COALESCE(SUM(p.amount), 0.00) DESC) AS rank_with_revenue
    FROM
        film f
    LEFT JOIN
        inventory i ON f.film_id = i.film_id
    LEFT JOIN
        rental r ON i.inventory_id = r.inventory_id
    LEFT JOIN
        payment p ON r.rental_id = p.rental_id
    LEFT JOIN
        customer c ON r.customer_id = c.customer_id
    GROUP BY
        f.title
)

SELECT
    COALESCE(rank_with_revenue, max_rank + 1) AS rank,
    title,
    revenue
FROM 
    revenue_rank
CROSS JOIN 
    (SELECT MAX(rank_with_revenue) AS max_rank FROM revenue_rank) AS max_ranks
ORDER BY
    rank;
