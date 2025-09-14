use sakila;
show tables;

-- 1. List each customer's full name and total payment amount
	desc customer;
    desc customer_list;
    desc payment;
    
    select c.customer_id, concat(c.first_name, ' ', c.last_name) as full_name, sum(p.amount) as total_amount
    from customer c
    join payment p 
    ON c.customer_id = p.customer_id
    group by c.customer_id;

-- 2. Show all films along with the number of actors in each film
	desc film;
    desc actor;
    select * from actor ;
    desc film_actor;
    select * from film_actor;
    
		select fa.film_id, f.title, 
        count(fa.actor_id) as no_of_actor, 
        group_concat(concat(a.first_name, ' ', a.last_name) separator ',') as actors
        from film_actor fa
        join film f on fa.film_id = f.film_id
        join actor a on fa.actor_id = a.actor_id
        group by film_id, f.title;
        
        
-- 3. find each store's total sales.
	show tables;
    desc sales_by_store;
    select * from sales_by_store;
    desc store;
    
-- 4. List customers who rented more than 5 films.
	desc customer;
    desc payment;
    desc rental;
    
    
-- 5.List customers who paid more than the average payment.
	
    
  