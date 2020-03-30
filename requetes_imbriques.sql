USE sakila;

-- 1. Avec une requête imbriquée sélectionner tout les acteurs ayant joués dans les films ou a joué « MCCONAUGHEY CARY ». --

SELECT title, concat(actor.first_name, ' ', actor.last_name) name FROM film f
JOIN film_actor ON f.film_id = film_actor.film_id
JOIN actor ON film_actor.actor_id = actor.actor_id
AND concat(last_name, ' ', first_name) <> 'MCCONAUGHEY CARY'
WHERE EXISTS (
SELECT film.film_id, title FROM film
JOIN film_actor ON film.film_id = film_actor.film_id
JOIN actor ON film_actor.actor_id = actor.actor_id
AND concat(last_name, ' ',first_name) = 'MCCONAUGHEY CARY'
WHERE f.film_id = film.film_id);

-- • 2. Afficher tout les acteurs n’ayant pas joués dans les films ou a joué « MCCONAUGHEY CARY ». --

-- 1ère méthode -- 

SELECT title, concat(actor.first_name, ' ', actor.last_name) name FROM film f
JOIN film_actor ON f.film_id = film_actor.film_id
JOIN actor ON film_actor.actor_id = actor.actor_id
AND concat(last_name, ' ', first_name) <> 'MCCONAUGHEY CARY'
WHERE NOT EXISTS (
SELECT film.film_id, title FROM film
JOIN film_actor ON film.film_id = film_actor.film_id
JOIN actor ON film_actor.actor_id = actor.actor_id
AND concat(last_name, ' ',first_name) = 'MCCONAUGHEY CARY'
WHERE f.film_id = film.film_id);

-- 2ème méthode -- 

SELECT last_name Nom, first_name Prénom FROM actor 
JOIN film_actor ON actor.actor_id = film_actor.actor_id
WHERE film_id NOT IN ( SELECT film_id, title FROM film_actor WHERE actor_id = 77) # id =77 c'est celui de "MCCONAUGHEY CARY"
GROUP BY last_name, first_name
ORDER BY last_name, first_name;

-- • 3. Afficher Uniquement le nom du film qui contient le plus d'acteur et le nombre d'acteurs associé sans utiliser LIMIT (2 niveaux de sous requêtes). --

 SELECT title, count(actor_id) nb FROM film
	JOIN film_actor ON film.film_id = film_actor.film_id
    GROUP BY film.film_id
    HAVING nb = (
		SELECT max(a.cnt) FROM (
			SELECT count(actor_id) cnt FROM film_actor
				GROUP BY film_id) a);

-- 4. Afficher les acteurs ayant joué uniquement dans des films d’actions (Utiliser EXISTS). -- 

SELECT title, concat(actor.first_name, ' ', actor.last_name) name FROM film f
JOIN film_actor ON f.film_id = film_actor.film_id
JOIN actor ON film_actor.actor_id = actor.actor_id
WHERE EXISTS (
SELECT category.name, title FROM film
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category c ON fc.category_id = c.category_id
AND category.name = 'Action'); 

SELECT DISTINCT title, concat(actor.first_name,' ', actor.last_name) name FROM film f
    JOIN film_actor ON f.film_id = film_actor.film_id
    JOIN actor ON film_actor.actor_id = actor.actor_id
    WHERE EXISTS(
    SELECT title, category.name
    FROM film
    JOIN film_category
    ON film.film_id = film_category.film_id
    JOIN category
	ON film_category.category_id = category.category_id
    WHERE category.name LIKE 'Action'
    );


