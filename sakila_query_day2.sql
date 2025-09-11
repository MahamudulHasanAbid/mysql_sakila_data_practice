use sakila;
show tables;

 desc film;
 desc language;
 select * from language;
 /* Joins*/
 
 -- 1. List all films with their language name. 
	 select f.film_id, l.name as language, f.title 
	 from film f
	 inner join language l
	 ON f.language_id = l.language_id;
 
 -- 2. List all films with their category name. 
	  desc film;
	  select * from film;
	  desc film_category;
	  desc category;
	  
	  select fc.category_id, c.name as category, fc.film_id, f.title
	  from film_category fc
	  join category c on fc.category_id = c.category_id
	  join film f on fc.film_id = f.film_id
	  order by film_id;
  
  -- 3. List all customers with their city and country.
	  show tables;
	  desc customer;
	  desc customer_list;
	  
	  select ID, name, city, country from customer_list;
  
  
  
  /* SubQueries */
  
  -- 1. Find films that have a higher rental rate than the average rental rate
	  desc film;
	  select film_id, title, rental_rate, (select avg(rental_rate) from film) as avg_rental_rate
	  from film
	  where rental_rate > (select avg(rental_rate) from film)
	  order by film_id;
  
  -- 2. Find actors who acted in more than 5 films
	  show tables;
	  desc film_actor; -- actor_id, film_id
	  desc film; -- title
	  desc actor_info; -- actor_id, first_name, lname
	  
	  select ai.actor_id, concat(ai.first_name, " ", ai.last_name) as full_name, count(fa.film_id) as total_film
	  from actor_info ai
	  join film_actor fa on ai.actor_id = fa.actor_id
	  group by ai.actor_id, ai.first_name, ai.last_name
	  having count(fa.film_id)>5;
   
		-- Using Subquery --
		select ai.actor_id, concat(ai.first_name, " " ,ai.last_name) as full_name, count(fa.film_id) as film_count
		from actor_info ai
		join film_actor fa on ai.actor_id = fa.actor_id
		where ai.actor_id in (
		select fa.actor_id
		from film_actor fa
		group by fa.actor_id
		having count(fa.film_id) > 5)
		group by ai.actor_id, ai.first_name, ai.last_name;
        
/*Window Functions*/

use sakila;
show tables;
desc film; 
desc category;
desc film_category;

-- 1. Rank films by rental_rate within each category.
	select c.name as category_name ,f.film_id, f.title, f.rental_rate,
	dense_rank() over(partition by c.category_id order by f.rental_rate desc, f.film_id asc ) as rank_in_category
	from film f
	join film_category fc ON f.film_id = fc.film_id
	join category c ON fc.category_id = c.category_id
	order by rank_in_category;

-- 2. Show total payment per customer and the difference from the average customer payment.
	show tables;
    desc customer;
    desc customer_list;
    desc payment;
     
    select customer_id,
    sum(amount) over(partition by customer_id ) as total_paymet,
    round(avg(amount) over(),2) as average_customer_payment,
    round(sum(amount) over(partition by customer_id ) - avg(amount) over(),2) as difference_from_average
    from payment;