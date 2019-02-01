-- specifying mysql to use sakila
use sakila;
-- 1a
select first_name, last_name from actor;
-- 1b
select upper(concat(first_name, " ", last_name)) "Actor Name" FROM actor;
-- 2a
select actor_id, first_name, last_name from actor where first_name="JOE";
-- 2b
select * from actor where last_name like "%GEN%";
-- 2c
select * from actor where last_name like "%LI%" order by first_name, last_name;
-- 2d
select country_id, country from country where country in ("Afghanistan", "Bangladesh", "China");
-- 3a
alter table actor
add column description blob;
-- 3b
alter table actor
drop column description;
-- 4a
select last_name, count(*) "Count" from actor group by last_name;
-- 4b
select last_name, count(*) "Count" from actor group by last_name having count(*)>1;
-- 4c
update actor
set first_name="HARPO"
where first_name="GROUCHO" and last_name="WILLIAMS"
-- 4d
select if(first_name="HARPO", "GROUCHO", first_name) "First Name", last_name from actor where first_name="HARPO" and last_name="WILLIAMS";
-- 5a
describe  address;
-- 6a
select s.first_name, s.last_name, a.address from staff s join address a on s.address_id=a.address_id;
-- 6b
select s.first_name
	, s.last_name
    , sum(p.amount) "Total AMT" 
from staff s 
join payment p 
	on s.staff_id=p.staff_id 
group by s.first_name, s.last_name;
-- 6c
select f.title, count(fa.actor_id) from film f join film_actor fa on f.film_id=fa.film_id group by f.title;
-- 6d
select count(i.inventory_id) "COUNT"
from inventory i 
join film f 
	on i.film_id=f.film_id
    and f.title="Hunchback Impossible";
-- 6e
select c.first_name
	, c.last_name
    , sum(p.amount) "Total AMT" 
from customer c
join payment p
	on c.customer_id=p.customer_id
group by c.first_name
	, c.last_name
order by c.last_name;
-- 7a
select title 
from film 
where (title like "K%" 
	or title like "Q%" )
    and language_id=(select language_id from language where name="English");
-- 7b
select a.first_name
	, a.last_name 
from actor a
join film_actor fa
	on a.actor_id=fa.actor_id
    and fa.film_id=(select film_id from film where title="Alone Trip")
-- 7c
select first_name, last_name, email from customer where address_id in (
select address_id from address where city_id in(
select city_id from city where country_id in (
select country_id from country where country="Canada")));
-- 7d
select title from film where film_id in (
select film_id from film_category where category_id in (
select category_id from category where name="family"));
-- 7e
select f.title, count(r.rental_date) "Rental Count" from film f 
join inventory i 
	on f.film_id=i.film_id
join rental r 
	on i.inventory_id=r.inventory_id
group by f.title
order by count(r.rental_date) desc;
-- 7f
select s.store_id, sum(amount) "Total" from store s
join staff st 
	on s.store_id=st.store_id
join payment p 
	on st.staff_id=p.staff_id
group by s.store_id;
-- 7g
select s.store_id, c.city, co.country from store s
join address a 
	on s.address_id=a.address_id
join city c 
	on a.city_id=c.city_id
join country co
	on c.country_id=co.country_id;
-- 7h
select  c.name, sum(p.amount) from payment p
join rental r 
	on p.rental_id=r.rental_id
join inventory i
	on r.inventory_id=i.inventory_id
join film f
	on i.film_id=f.film_id
join film_category fc
	on f.film_id=fc.film_id
join category c
	on fc.category_id=c.category_id
group by c.name
order by sum(p.amount) desc
limit 5;
-- 8a
create view top_category as 
select  c.name, sum(p.amount) from payment p
join rental r 
	on p.rental_id=r.rental_id
join inventory i
	on r.inventory_id=i.inventory_id
join film f
	on i.film_id=f.film_id
join film_category fc
	on f.film_id=fc.film_id
join category c
	on fc.category_id=c.category_id
group by c.name
order by sum(p.amount) desc
limit 5;
-- 8b
select * from top_category;
-- 8c
drop view top_category;


