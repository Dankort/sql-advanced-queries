use sakila;

-- 1.List each pair of actors that have worked together.
 
with ActorList as (
    select distinct
        fa.actor_id,
        a.first_name,
        a.last_name
    from
        film_actor fa
    join
        actor a on fa.actor_id = a.actor_id
)

select 
    a1.actor_id AS actor1_id,
    CONCAT(a1.first_name, ' ', a1.last_name) AS actor1_name,
    a2.actor_id AS actor2_id,
    CONCAT(a2.first_name, ' ', a2.last_name) AS actor2_name
FROM
    ActorList a1
JOIN
    ActorList a2 ON a1.actor_id < a2.actor_id;
    

-- 2 For each film, list actor that has acted in more films.

select distinct
    fa.film_id,
    a.actor_id,
    CONCAT(a.first_name, ' ', a.last_name) as actor_name
from
    film_actor fa
join
    actor a on fa.actor_id = a.actor_id
where
    (
        select COUNT(fa2.actor_id)
        from film_actor fa2
        where fa2.film_id = fa.film_id
    ) =
    (
        select MAX(actor_count)
        from (
            select COUNT(fa3.actor_id) as actor_count
            from film_actor fa3
            where fa3.film_id = fa.film_id
            group by fa3.actor_id
        ) as actor_counts
    );