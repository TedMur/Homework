use sakila;

# 1a. Display the first and last names of all actors from the table actor.
select first_name, last_name from actor;
# 1b. Display the first and last name of each actor in a single column in upper case letters. 
#	  Name the column Actor Name.
select concat(first_name, ' ', last_name) as 'Actor Name' from actor;


# 2a. You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." 
#	  What is one query would you use to obtain this information?
select actor_id, first_name, last_name from actor
where first_name = 'Joe';

# 2b. Find all actors whose last name contain the letters GEN:
select * from actor
where last_name like '%gen%';

# 2c. Find all actors whose last names contain the letters LI. 
#	  This time, order the rows by last name and first name, in that order:
select last_name, first_name from actor
where
last_name like '%LI%';

# 2d. Using IN, display the country_id and country columns of the following countries:
# 	  Afghanistan, Bangladesh, and China:
select country_id, country from country where country in ('Afghanistan', 'Bangladesh', 'China');


/* 3a. You want to keep a description of each actor. 
	You don't think you will be performing queries on a description, 
	so create a column in the table actor named description 
    and use the data type BLOB (Make sure to research the type BLOB, 
    as the difference between it and VARCHAR are significant). */
describe actor;
select * from actor;




/* 3b. Very quickly you realize that entering descriptions for each actor is too much effort.
	Delete the description column.*/ 
use sakila;
alter table actor
drop column `description`;
select * from actor;

# 4a. List the last names of actors, as well as how many actors have that last name.
select last_name, count(*) as `Count` from actor
group by last_name; # Why do we need?

/*4b. List last names of actors and the number of actors who have that last name, 
	  but only for names that are shared by at least two actors*/ 
select last_name, count(*) as `Count` from actor
group by last_name
having Count > 2;    
    
/*4c. The actor HARPO WILLIAMS was accidentally entered in the actor table as GROUCHO WILLIAMS. 
	Write a query to fix the record.*/
select * from actor
where (first_name = 'GROUCHO' and last_name = 'WILLIAMS');

update actor 
set first_name = 'HARPO'
where actor_id = '172';
select * from actor where actor_id = '172';

/*4d. Perhaps we were too hasty in changing GROUCHO to HARPO. 
	It turns out that GROUCHO was the correct name after all! In a single query, 
    if the first name of the actor is currently HARPO, change it to GROUCHO.*/
update actor
set first_name = 'GROUCHO'
where (first_name = 'HARPO' and last_name = 'WILLIAMS');
select * from actor where actor_id = '172';

/*
5a. You cannot locate the schema of the address table. Which query would you use to re-create it?
Hint: https://dev.mysql.com/doc/refman/5.7/en/show-create-table.html*/
show create table address;


/*6a. Use JOIN to display the first and last names, as well as the address, 
	of each staff member. Use the tables staff and address:*/
select first_name, last_name, address 
from address a 
join staff s
on s.address_id = a.address_id;

/*6b. Use JOIN to display the total amount rung up by each staff member in August of 2005. 
	Use tables staff and payment.*/
select s.first_name, s.last_name, sum(p.amount) as 'Total'
from staff s
join payment p
on s.staff_id = p.staff_id
group by s.staff_id
having s.last_update ;

    
    
/*6c. List each film and the number of actors who are listed for that film. 
	  Use tables film_actor and film. Use inner join.*/ 
select f.title, count(actor_id) as 'Total'
from film f
inner join film_actor fa
on f.film_id = fa.film_id
group by f.title;
    


# 6d. How many copies of the film Hunchback Impossible exist in the inventory system?
select f.title, count(i.film_id) as '# of copies'
from inventory i
join film f
on i.film_id = f.film_id
where f.title = 'Hunchback Impossible';

/*6e. Using the tables payment and customer and the JOIN command, 
	list the total paid by each customer. 
	List the customers alphabetically by last name:*/
select concat(first_name, ' ', last_name) as 'Name', sum(amount) as 'Total Paid'
from customer c
join payment p
on c.customer_id = p.customer_id
group by c.customer_id;

/*7a. The music of Queen and Kris Kristofferson have seen an unlikely resurgence.
	  As an unintended consequence, films starting with the letters K and Q have also soared in popularity. 
      Use subqueries to display the titles of movies starting with the letters K and Q whose language is English.*/
      
select f.title
from film f
where language_id in (
	select language_id 
	from language 
	where name = 'English')
having title like 'K%' or title like 'Q%';
      
# 7b. Use subqueries to display all actors who appear in the film Alone Trip.
select concat(first_name, ' ', last_name) as 'Actors in "Alone Trip"'
from actor
where actor_id in (
	select actor_id 
    from film_actor
    where film_id in (
		select film_id 
        from film
        where title = 'Alone Trip') );
    
/*7c. You want to run an email marketing campaign in Canada, 
	  for which you will need the names and email addresses of all Canadian customers. 
	  Use joins to retrieve this information.*/

select concat(first_name, ' ', last_name) as 'First / Last', 
c.email as 'E-mail'
from customer c
join address a
on c.address_id = a.address_id
join city ct
on a.city_id = ct.city_id
join country cnt
on ct.country_id = cnt.country_id
where country = 'Canada';


/*7d. Sales have been lagging among young families, and you wish to target all family movies for a promotion.
	  Identify all movies categorized as family films.*/

select title as 'Family films'
from film f
left join film_category fc
on f.film_id = fc.film_id
left join category c
on fc.category_id = c.category_id
#where c.category_id = 8
where c.name = 'Family';


# 7e. Display the most frequently rented movies in descending order.
rental inventory film

# 7f. Write a query to display how much business, in dollars, each store brought in.
use sakila;
select * from store;
# 7g. Write a query to display for each store its store ID, city, and country.
select s.store_id, c.city, ctry.country 
from store s
left join address a
on s.address_id = a.address_id
left join city c
on a.city_id = c.city_id
left join country ctry
on c.city_id = ctry.country_id;

/*7h. List the top five genres in gross revenue in descending order. 
	  (Hint: you may need to use the following tables: category, film_category, inventory, payment, and rental.)*/
select c.name, sum(amount) as 'Gross revenue'
from category c 
left join film_category f
on c.category_id = f.category_id
left join inventory i
on f.film_id = i.film_id
left join rental r
on i.inventory_id = r.inventory_id
left join payment p
on r.rental_id = p.rental_id
group by c.name
limit 5;

/*8a. In your new role as an executive, you would like to have an easy way of viewing 
	  the Top five genres by gross revenue. Use the solution from the problem above to create a view. 
      If you haven't solved 7h, you can substitute another query to create a view.*/
create view top_five_genres as 
select c.name, sum(amount) as 'Gross revenue'
from category c 
left join film_category f
on c.category_id = f.category_id
left join inventory i
on f.film_id = i.film_id
left join rental r
on i.inventory_id = r.inventory_id
left join payment p
on r.rental_id = p.rental_id
group by c.name
limit 5;

# 8b. How would you display the view that you created in 8a?
select * from top_five_genres;

# 8c. You find that you no longer need the view top_five_genres. Write a query to delete it.
drop view top_five_genres;







