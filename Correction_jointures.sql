# 1. Lister les 10 premiers films ainsi que leur langues.

select title, name as langue
	from film
    left join language
    on film.language_id = language.language_id
    limit 10;
    
    

# 2. Afficher les film dans les quel à joué « JENNIFER DAVIS » sortie en 2006.

select title, first_name, last_name
	from film
    inner join film_actor
    on film.film_id = film_actor.film_id
    inner join actor
    on film_actor.actor_id = actor.actor_id
    where concat(first_name, ' ', last_name) like 'JENNIFER DAVIS';
#   where first_name like 'JENNIFER' and last_name like 'DAVIS';



# 3. Afficher le noms des client ayant emprunté « ALABAMA DEVIL ».

select first_name, last_name, title
	from customer
    inner join rental
    on customer.customer_id = rental.customer_id
    inner join inventory
    on rental.inventory_id = inventory.inventory_id
    inner join film
    on inventory.film_id = film.film_id
    where title like 'ALABAMA DEVIL';
    
    
    
# 4. Afficher les films louer par des personne habitant à « Woodridge ».


select city, first_name, last_name, title
	from customer
    inner join address
    on customer.address_id = address.address_id
	inner join city
    on address.city_id = city.city_id
    inner join rental
    on customer.customer_id = rental.customer_id
    inner join inventory
    on rental.inventory_id = inventory.inventory_id
    inner join film
    on inventory.film_id = film.film_id
    where city like 'Woodrige';



# 4.bis. Vérifié s’il y a des films qui n’ont jamais été emprunté.

select distinct title, inventory.inventory_id
	from film
    inner join inventory
    on film.film_id = inventory.film_id
    left join rental
    on inventory.inventory_id = rental.inventory_id
    where inventory.inventory_id is null;
    
    

# 5. Quel sont les 10 films dont la durée d’emprunt à été la plus courte ?

select distinct title, datediff(return_date, rental_date) as duree_de_location
	from film
    inner join inventory
    on film.film_id = inventory.film_id
    left join rental
    on inventory.inventory_id = rental.inventory_id
    having duree_de_location >= 0
    order by duree_de_location 
    limit 10;
    
    

# 6. Lister les films de la catégorie « Action » ordonnés par ordre alphabétique.

select title, category.name
	from film
	inner join film_category
    on film.film_id = film_category.film_id
    inner join category
    on film_category.category_id = category.category_id
    where category.name like 'Action';




# 7. Quel sont les films dont la duré d’emprunt à été inférieur à 2 jour ?

select distinct title, datediff(return_date, rental_date) as duree_de_location
	from film
    inner join inventory
    on film.film_id = inventory.film_id
    left join rental
    on inventory.inventory_id = rental.inventory_id
    having duree_de_location < 2
    order by duree_de_location;

