use sakila;

###### 1 ########
select rental_rate, count(*)
from film
group by rental_rate
having avg(rental_rate) > (Select avg(rental_rate) from film);


###### 2 #######

Select distinct(title)
from film
join inventory
on film.film_id = inventory.film_id
#join rental
#on rental.inventory_id = inventory.inventory_id
where 
not exists
(select * from rental
where inventory.inventory_id = rental.inventory_id);



###### 3 ######

SELECT store.store_id, count(payment.payment_ID), sum(payment.amount)
from store
join staff
on store.store_id = staff.store_id
join payment
on staff.staff_id = payment.staff_id
group by store.store_id;

#####  4  #####

SELECT store.store_id, sum(payment.amount)
from store
join inventory
on store.store_id = inventory.store_id
join rental
on rental.inventory_id = inventory.inventory_id
join payment
on payment.rental_id = rental.rental_id
group by store_ID
having amount > avg(amount);

##### 5 ######

Select store.store_id, datediff(day, rental.rental_date, rental.return_date)
from store
join inventory
on store.store_id = inventory.store_id
join rental
on rental.inventory_id = inventory.inventory_id
group by store.store_id;

##### 6 ######

select store.store_id, monthname(rental.rental_date), count(rental.return_date)
from store
join inventory
on store.store_id = inventory.store_id
join rental
on rental.inventory_id = inventory.inventory_id
group by store.store_id, month(rental.rental_date) with rollup;
