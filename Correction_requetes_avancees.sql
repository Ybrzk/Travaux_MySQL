Use sakila;


# 1. Afficher tout les emprunt ayant été réalisé en 2006.
# Le mois doit être écrit en toute lettre et le résultat doit s’afficher dans une seul colonne.

SELECT rental_id, customer_id, CASE MONTH(rental_date)
         WHEN 1 THEN 'janvier'
         WHEN 2 THEN 'février'
         WHEN 3 THEN 'mars'
         WHEN 4 THEN 'avril'
         WHEN 5 THEN 'mai'
         WHEN 6 THEN 'juin'
         WHEN 7 THEN 'juillet'
         WHEN 8 THEN 'août'
         WHEN 9 THEN 'septembre'
         WHEN 10 THEN 'octobre'
         WHEN 11 THEN 'novembre'
         ELSE 'décembre'
	END as mois
	from rental
	where year(rental_date) = 2006
	limit 10;



# 2. Afficher la colonne qui donne la durée de location des films en jour.

select rental_id, customer_id, datediff(return_date, rental_date) as duree_de_location
	from rental
    limit 10;
    
   
   
# 2.bis. Afficher le nom et prenom des acteurs dans une seul colonne.

select concat(first_name, ' ', last_name) as acteur
	from actor
    limit 10;



# 3. Afficher les emprunts réalisés avant 1h du matin en 2005.
# Afficher la date dans un format lisible.

select rental_id, customer_id, date_format(return_date, '%d/%m/%y') as date_d_enprunt
	from rental
    where hour(rental_date) < 1 and year(rental_date) = 2005
    limit 10;
    
    
	
# 4. Afficher les emprunts réalisé entre le mois d’avril et le moi de mai.
# La liste doit être trié du plus ancien au plus récent.

select *
	from rental
    where month(rental_date) between '04' and '05'
    order by rental_date
    limit 10;
    
    
	
# 5. Lister les film dont le nom ne commence pas par « Le ».

select *
	from film
    where left(title, 2) <> 'Le ';
    

# 6. Lister les films ayant la mention « PG-13 » ou « NC-17 ».
# Ajouter une colonne qui affichera « oui » si « NC-17 » et « non » Sinon.

select title, case rating
		when 'NC-17' then 'oui'
		else 'non'
	end as Mention_NC_17
    from film
    where rating like 'NC-17' or rating like 'PG-13' limit 10;



# 7. Fournir la liste des catégorie qui commence par un ‘A’ ou un ‘C’. (Utiliser LEFT).

select name
	from category
    where left(name, 1) = 'A' or left(name, 1) like 'C';
    
	
    
# 8. Lister les trois premiers caractères en majuscul des noms des catégorie.

select ucase(left(name, 3)) as short_name
	from category;
    
	

# 9. Lister les 10 premiers acteurs en remplaçant dans leur prénom les E par des A.

select replace(first_name, 'E', 'A') as first_name_A_E, last_name
	from actor
    limit 10;
