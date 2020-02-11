USE sakila;
-- L'acteur que l'on trouve dans le plus de film ? -- 
WITH ACT_COUNT AS
(
    SELECT
    A.FIRST_NAME
    ,A.LAST_NAME 
    ,COUNT(*) NB_FILM
    FROM ACTOR A
    INNER JOIN FILM_ACTOR FA ON FA.ACTOR_ID = A.ACTOR_ID
    GROUP BY
    A.FIRST_NAME
    ,A.LAST_NAME
)
SELECT * 
FROM ACT_COUNT A
;
-- les films qui n'ont jamais été loués ? -- 
SELECT 
F.title
,F.release_year
FROM film F 
LEFT JOIN inventory I ON F.film_id = I.film_id
LEFT JOIN RENTAL R ON R.inventory_id = I.inventory_id
WHERE R.rental_id IS NULL;

SELECT 
f.title
,f.release_year
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id
LEFT JOIN rental r ON r.inventory_id = i.inventory_id
WHERE r.rental_id IS NULL;

SELECT
f.title
,f.release_year
FROM film f
WHERE NOT exists
( 
SELECT 1
FROM inventory i
INNER JOIN rental r ON r.inventory_id = i.inventory_id
WHERE f.film_id = i.film_id
);

SELECT 
f.title
,f.release_year
FROM film f 
WHERE f.film_id NOT IN
(
SELECT f2.film_id
FROM film f2
INNER JOIN inventory i on f2.film_id = i.film_id
INNER JOIN rental r on r.inventory_id = i.inventory_id
);
-- temps moyen de restitution d'un film -- 
SELECT AVG (ABS(DATEDIFF(return_date, rental_date)))
FROM rental

-- Temps moyen de restitution d'un film par client (classement du plus long au plus court) -- 
SELECT 
c.first_name
,c.last_name
AVG, (ABS(DATEDIFF(return_date, rental_date))) AVG_DURATION
,CASE 

    WHEN AVG(ABS(DATEDIFF(return_date, rental_date))) > 5 THEN "Bien"
    ELSE "Pas bien"
END
FROM rental r
INNER JOIN customer c ON c.customer.id = r.customer.id
GROUP BY 
c.first_name
,c.last_name
ORDER BY 3 DESC;

select 
c.first_name,
c.last_name
avg,(abs(datediff(return_date,rental_date))) avg_duration 
from rental r
inner join customer c on c.customer_id = r.customer_id
group by
c.first_name
,c.last_name
order by 3 desc;

with client_avg as
(
select
c.first_name
,c.last_name
,avg(abs(datediff(return_date,rental_date))) as avg_duration
from rental r
inner join customer c on c.customers_id = r.customer_id
group by
c.first_name
,c.last_name
)
,
select
ca.*
,case
when avg_duration > 5 then 'pas bien'
else 'bien'
end as client_category
from client_avg ca 

select
f.title
,f.release_year
from film f
minus
##union all
select
f.title
,f.release_year
from film f
inner join inventory i on i.film_id = f.film_id
inner join rental r on r.inventory_id = i.inventory_id
where f.film_id = i.film_id;

##L'acteur préferer de chaque client = l'acteur qui joue le plus dans les films regardés par un client

with actor_client as
(
select 
,c.client_id
,c.first_name || ' ' || c.last_name as client_name
,a.actor_id
,a.first_name || ' ' || a.last_name as actor_name
,count (*) nb_occurence
from customer c
inner join rental r on r.customers_id = c.customer_id
inner join inventory i on i.inventory_id = r.inventory_id
inner join film f on f.film_id = i.film_id
inner join film_actor fa on fa.film_id = fa.actor_id
inner join actor a on a.actori_id = fa.actor_id
group by c.client_id,c.first_name,c.last_name,a.first_name,a.last_name
)

select
client_name
max(actor_name) keep (rank first order by nb_occurence desc) over (partiton by client_name)
from actor_client ac
where not exists
(
select 1
from actor_client ac2
where ac2.client_id = ac.client_id
and ac2.nb_occurence > ac.nb_occurence
);

##L'acteur préferer de chaque client = l'acteur qui joue le plus dans les films regardés par un client

with actor_client as
(
select 
,c.client_id
,c.first_name || ' ' || c.last_name as client_name
,a.actor_id
,a.first_name || ' ' || a.last_name as actor_name
,count (*) nb_occurence
from customer c
inner join rental r on r.customers_id = c.customer_id
inner join inventory i on i.inventory_id = r.inventory_id
inner join film f on f.film_id = i.film_id
inner join film_actor fa on fa.film_id = fa.actor_id
inner join actor a on a.actori_id = fa.actor_id
group by c.client_id,c.first_name,c.last_name,a.first_name,a.last_name
)
select
client_name
max(actor_name) keep (rank first order by nb_occurence desc) over (partiton by client_name)
from actor_client ac
where not exists
(
select 1
from actor_client ac2
where ac2.client_id = ac.client_id
and ac2.nb_occurence > ac.nb_occurence
);
