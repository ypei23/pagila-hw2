/*
 * This problem is the same as 06.sql,
 * but instead of using the NOT IN operator, you are to use a LEFT JOIN.
 */ 

select title 
from film f 
left join inventory i on i.film_id = f.film_id 
where i.film_id IS NULL;
