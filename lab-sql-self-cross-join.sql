-- Get all pairs of actors that worked together

select concat(a1.first_name, " ", a1.last_name) as "Actor 1", concat(a2.first_name, " ", a2.last_name) as "Actor 2", film.title
from actor a1
join actor a2 
on a1.actor_id <> a2.actor_id
join film_actor f1
on a1.actor_id = f1.actor_id
join film_actor f2
on a2.actor_id = f2.actor_id
join film 
on film.film_id = f1.film_id;

-- Get all pairs of customers that have rented the same film more than 3 times

with cust as
(select
	customer_id,
        first_name,
        last_name,
        rental_id,
        inventory_id,
        film_id,
        title
from customer
join rental using(customer_id)
join inventory using(inventory_id)
join film using(film_id))
select
	tb1.customer_id as cust1_id,
        concat(tb1.first_name, " ", tb1.last_name) as cust1_name,
        tb2.customer_id as cust2_id,
        concat(tb2.first_name, " ", tb2.last_name) as cust2_name,
	count(distinct tb1.film_id) as same_movies_rented -- >>>>>>>>> we'll count distinct film_ids: this is how we will "fix" the multiplication of rows!!! <<<<<<<<<
from cust as tb1
join cust as tb2
on tb1.film_id = tb2.film_id -- since we want pairs of customers that rented the same films
and tb1.customer_id < tb2.customer_id -- in order to avoid duplicated rows, only with inverted pairs of customers
group by tb1.customer_id, tb2.customer_id
having same_movies_rented > 3
order by same_movies_rented desc;

-- Get all possible pairs of actors and films.

select actor.actor_id AS actor_id, CONCAT(actor.first_name, ' ', actor.last_name) AS actor_name, film.film_id AS film_id, film.title AS film_title
from actor
join film
on 1=1;