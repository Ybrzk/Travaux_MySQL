SELECT CASE MONTH(rental_date)
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
END
FROM rental WHERE year(rental_date) = 2006 LIMIT 10;
SELECT DATEDIFF(return_date, rental_date) FROM rental LIMIT 10;
SELECT rental_date FROM rental WHERE hour (rental_date)<1 and year (rental_date) = 2005 LIMIT 10;
SELECT * FROM rental WHERE MONTH (rental_date) BETWEEN 04 AND 05 ORDER BY rental_date LIMIT 10;
SELECT title FROM film WHERE title NOT LIKE "%Le%" LIMIT 10;
SELECT title, CASE (rating)
WHEN "NC-17" THEN 'oui'
WHEN "PG-13" then 'non'
END FROM film; 
SELECT from 