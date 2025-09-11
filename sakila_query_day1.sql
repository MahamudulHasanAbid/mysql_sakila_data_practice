use sakila;

show tables;

-- 1.Count total films in the database.
	desc film;
	select count(film_id) as total_film from film;

-- 2.Count total customers per store.
	-- desc store;
	-- 	select * from store;

	desc customer;
	select store_id, count(customer_id) as total_customer
	from customer 
	group by store_id;

-- 3.Find the average rental_rate of all films.
	desc film;
	select count(film_id) as total_film, avg(rental_rate) as avg_rental_rate from film; 


/* Group By */

-- 1.Count the number of films in each category.
		-- desc film;
		-- show tables;
		-- desc category;
		-- select * from category;
		-- select * from film_category;
		
	select category_id, count(film_id) as film_by_category from film_category group by category_id;
		-- Using join
	select c.name as film_name, fc.category_id, count(fc.film_id) as film_by_category
	from film_category fc
	join category c on fc.category_id = c.category_id
	group by c.category_id;

-- 2. List total payments per customer.
		-- show tables;
		-- desc payment;
		-- desc rental;
		-- desc customer;
		-- select * from customer;
		-- desc customer_list;
    
    select customer_id, sum(amount) as total_payment from payment group by customer_id;
    -- using join.
    select p.customer_id, c.first_name, sum(p.amount) as total_payment
    from payment p
    join customer c on p.customer_id = c.customer_id 
    group by p.customer_id;


-- 3. Count how many actors are in each film.
			-- show tables;
            -- desc actor;
            -- desc film_actor;
            -- select * from film_actor limit 30;
            -- desc film;
            -- desc film_list;
            
	select film_id, count(actor_id) as total_actor from film_actor group by film_id;
    
    
-- 4. Find total payment per store.
			-- desc payment;
			-- select * from payment limit 20;
            -- desc staff;
            -- desc store;
	select s.store_id, sum(p.amount) as total_payment
    from payment p
    join staff s on p.staff_id = s.staff_id
    group by store_id;
    
    
    
    
/* HAVING */

-- 1. Find customers who paid more than 100.
SHOW TABLES; 
DESC PAYMENT;

select customer_id, sum(amount) as total_amount
from payment
group by customer_id
having total_amount>100;


-- 2. Find categories with more than 60 films.
	-- 	desc film_category;
	-- 	select * from film_category;
	-- 	desc category;
	-- 	select * from category;
    
select category_id, count(film_id) as total_film
from film_category
group by category_id 
having count(film_id) > 60;

-- 3. Find actors who acted in more than 30 films.
	show tables;
	desc actor;
    desc film_actor;
    desc film_list;
    
select fa.actor_id, a.first_name, count(fa.film_id) as total_film
from film_actor fa
join actor a on fa.actor_id = a.actor_id
group by fa.actor_id, a.first_name
having count(film_id)>30;
    
