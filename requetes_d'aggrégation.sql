-- Mise en Pratique -- 
-- 1. Afficher le nombre de films dans les quels à joué l'acteur "JOHNNY LOLLOBRIGIDA", regroupé par catégorie. --

SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY','film_category'));
SELECT category.name, count(film.title),
actor.first_name, actor.last_name 
FROM actor
INNER JOIN film_actor
ON actor.actor_id = film_actor.actor_id
INNER JOIN film
ON film_actor.film_id = film.film_id
INNER JOIN film_category
ON film.film_id = film_category.film_id
INNER JOIN category
ON film_category.category_id = category.category_id
WHERE actor.first_name = "JOHNNY" AND actor.last_name = "LOLLOBRIGIDA"
GROUP BY actor.first_name, actor.last_name, category.name;

-- 2. Ecrire la requête qui affiche les catégories dans les quels « JOHNNY LOLLOBRIGIDA » totalise plus de 3 films. --
SELECT category.name, count(film.title) as cnt
FROM actor
INNER JOIN film_actor
ON actor.actor_id = film_actor.actor_id
INNER JOIN film
ON film_actor.film_id = film.film_id
INNER JOIN film_category
ON film.film_id = film_category.film_id
INNER JOIN category
ON film_category.category_id = category.category_id
WHERE actor.first_name = "JOHNNY" AND actor.last_name = "LOLLOBRIGIDA"
GROUP BY actor.first_name, actor.last_name, category.name
HAVING cnt > 3;

-- 3. Afficher la durée moyenne d'emprunt des films par acteurs -- 

SELECT avg(datediff(return_date, rental_date)) as moyenne, first_name, last_name FROM rental
INNER JOIN inventory ON rental.inventory_id=inventory.inventory_id
INNER JOIN  film_actor ON inventory.film_id=film_actor.film_id
INNER JOIN actor ON film_actor.actor_id=actor.actor_id
GROUP BY first_name, last_name;

-- 4. L'argent total dépensé au vidéos club par chaque clients, classé par ordre décroissant -- 

SELECT
SUM(rental_rate) ARGENT_DEPENSE
, FIRST_NAME
,LAST_NAME
FROM CUSTOMER C
JOIN PAYMENT P ON C.CUSTOMER_ID = P.CUSTOMER_ID
JOIN RENTAL R ON P.RENTAL_ID = R.RENTAL_ID
JOIN INVENTORY I ON R.INVENTORY_ID = I.INVENTORY_ID
JOIN FILM F ON I.FILM_ID = F.FILM_ID
GROUP BY FIRST_NAME, LAST_NAME 
ORDER BY ARGENT_DEPENSE DESC;

SELECT SUM(rental_date) argent_depense,
first_name,
last_name
FROM customer
INNER JOIN payment
ON customer.customer_id = p.customer_id
INNER JOIN rental
ON payment.rental_id = rental.rental_id
INNER JOIN inventory 
ON rental.inventory_id = inventory.inventory_id
INNER JOIN film
ON inventory.film_id = film.film_id
GROUP BY first_name, last_name
ORDER BY argent_depense DESC;