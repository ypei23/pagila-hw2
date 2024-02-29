/*
 * Compute the total revenue for each film.
 * The output should include another new column "revenue percent" that shows the percent of total revenue that comes from the current film and all previous films.
 * That is, the "revenue percent" column is 100*"total revenue"/sum(revenue)
 *
 * HINT:
 * The `to_char` function can be used to achieve the correct formatting of your percentage.
 * See: <https://www.postgresql.org/docs/current/functions-formatting.html#FUNCTIONS-FORMATTING-EXAMPLES-TABLE>
 */ 

select *, 
	sum(revenue) over (order by rank ASC) as "total revenue", 
       to_char(100 * SUM(revenue) OVER (ORDER BY rank ASC) / SUM(revenue) OVER (), 'FM900.00') AS "percent revenue" 
FROM (
  select 
	rank() over (order by coalesce(sum(amount), 0.00) DESC),
	title,
	coalesce(sum(amount), 0.00) as revenue
	from film 
	left join inventory USING (film_id) 
	left join rental USING (inventory_id) 
	left join payment USING (rental_id)
	group by title
	order by revenue DESC
) t 
order by rank ASC, title;

/* 
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
    revenue,
    sum(revenue) over (order by COALESCE(rank_with_revenue, max_rank + 1)) as "total revenue",
    100.0 * revenue / sum(revenue)  as "percent revenue"

   -- to_char(100.0 * revenue / sum(revenue) over(), "999.99") || "%" as "percent revenue"
FROM
    revenue_rank
CROSS JOIN
    (SELECT MAX(rank_with_revenue) AS max_rank FROM revenue_rank) AS max_ranks
ORDER BY
    rank, revenue DESC, title;
*/
