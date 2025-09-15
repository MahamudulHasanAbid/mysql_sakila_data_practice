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
    
    
-- 5.List customers who paid in avg more than the average payment.
	desc customer;
    desc payment;
    
    select customer_id, avg(amount)
    from payment
    group by customer_id
    having avg(amount)>(
    select avg(amount)
    from payment );

-- 6. Find films whose rental_rate is higher than the average rental_rate of their category.
	desc film;
    desc film_list;
    desc film_category;
    select * from film_category;
    desc category;
    select * from category limit 2;
    
		select fo.film_id, fo.title, fo.rental_rate, c.category_id, c.name, cat_avg.category_avg_rentalRate
		from film fo
		join film_category fco on fo.film_id = fco.film_id
		join category c on fco.category_id = c.category_id
		join (
			select fc.category_id, avg(f.rental_rate) as category_avg_rentalRate
			from film f
			join film_category fc on f.film_id = fc.film_id
			group by fc.category_id
		) cat_avg on fco.category_id = cat_avg.category_id
		where fo.rental_rate > cat_avg.category_avg_rentalRate
		order by film_id;
    
    
-- 7. Show the top 3 most rented films per category
	
    desc film;
    desc rental;
    show tables;
	desc film_category;
	desc inventory;
    desc category;
    
		select category_name, film_id, film_title, rental_count
		from(
		select  c.name as category_name,
		f.film_id as film_id,
		f.title as film_title,
		count(r.rental_id) as rental_count,
		row_number() over(partition by c.category_id order by count(r.rental_id) desc) as rn
		from film f
		join film_category fc ON f.film_id = fc.film_id
		join category c ON fc.category_id = c.category_id
		join inventory i ON f.film_id = i.film_id
		join rental r ON i.inventory_id = r.inventory_id
		group by c.category_id, f.film_id
		) a 
		where rn <= 3;
  
  
  -- 8. Rank customers by total payments per store( top 3 per store)
	desc customer;
    desc payment;
    desc store;
    show tables;
		select customer_id, store_id, total_payment_by_customer, customer_rank
		from (
			select c.customer_id, c.store_id, sum(p.amount) as total_payment_by_customer,
			row_number() over(partition by c.store_id order by sum(p.amount) DESC) as customer_rank
			from customer c 
			join payment p ON c.customer_id = p.customer_id
			group by c.customer_id, c.store_id
            ) rnk
        where customer_rank <=3;
        
-- 9. List films with total rentals and average rental duration per category, orderred by category and rental count
	desc film;
    desc film_category;
    select * from film limit 4;
	