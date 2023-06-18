/*
 * Aquellas usadas para insertar, modificar y eliminar un Customer, Staff y Actor.
 */

-- insertar Customer
insert into customer(
	active,
	store_id,
	address_id,
	first_name,
	last_name,
	email
)
values(
	0,
	(select store_id from store order by random() limit 1),
	(select address_id from address order by random() limit 1),
	'mary',
	'davis',
	'marydavis@mailcustomer.org'
)
;
-- modificar Customer 
update customer
set email = 'mdavis@mail.com', active = '1'
where customer_id = ( select max(customer_id) from customer )
;
-- eliminar Customer
delete from customer
where customer_id = ( select max(customer_id) from customer )
;


-- insertar Staff
insert into staff(
	first_name,
	last_name,
	address_id,
	email,
	store_id,
	username,
	"password"
)
values(
	'mary',
	'davis',
	(select address_id from address order by random() limit 1),
	'marydavis@mailcustomer.org',
	(select store_id from store order by random() limit 1),
	'mdavis',
	'md123'
)
;
-- modificar Staff
update staff
set email = 'mdavis_staff@staffmail.com'
where staff_id = ( select max(staff_id) from staff )
;
-- borrar Staff
delete from staff
where staff_id = ( select max(staff_id) from staff )
;


-- insertar Actor
insert into actor (
	first_name,
	last_name
)
values(
	'marry',
	'davvis'
)
;
-- modificar Actor
update actor 
set first_name= 'mary', last_name='davis'
where  actor_id = ( select max(actor_id) from actor )
;
-- borrar Actor
delete from actor
where  actor_id = ( select max(actor_id) from actor )
;



/*
 * Listar todas las “rental” con los datos del “customer” dado un año y mes.
 */
select * from country c ;
select
	r.rental_id "ID rental",
	r.rental_date::date "Fecha de renta",
	cl.*
from rental r
inner join customer_list cl on cl.id  = r.customer_id
where
	extract(year from r.rental_date) = 2006
	and
	extract(month from r.rental_date) = 2
order by "Fecha de renta" asc
;



/*
 * Listar Número, Fecha (payment_date) y Total (amount) de todas las “payment”.
 */
select
	p.payment_id "Número",
	p.payment_date::date "Fecha",
	p.amount "Total"
from payment p
order by "Número", "Fecha"
;



/*
 * Listar todas las “film” del año 2006 que contengan un (rental_rate) mayor a 4.0.
 */
select *
from film f
where
	f.rental_rate > 4 
	and
	f.release_year = 2006
order by f.film_id
;



/*
 * Realiza un Diccionario de datos que contenga el nombre de las tablas y columnas, si éstas pueden ser nulas, y su tipo de dato correspondiente.
 */
select
	ic.table_name "Tabla",
	ic.column_name "Columna",
	ic.udt_name "Tipo de dato",
	case ic.is_nullable
		when 'YES' then 'SI'
		else 'NO'
	end "¿Puede ser nulo?",
	case
		when ic2.foreign_table_name is null then 'NO'
		else 'SI'
	end "¿Es llave foranea?",
	coalesce(ic2.foreign_table_name, '-' ) "Entidad asociada",
	coalesce(ic2.foreign_column_name, '-' ) "Columna referenciada"
from information_schema.columns ic
left join (
	SELECT
	    tc.table_name, 
	    kcu.column_name, 
	    ccu.table_name AS foreign_table_name,
	    ccu.column_name AS foreign_column_name 
	FROM 
	    information_schema.table_constraints AS tc 
	    JOIN information_schema.key_column_usage AS kcu
	      ON tc.constraint_name = kcu.constraint_name
	      AND tc.table_schema = kcu.table_schema
	    JOIN information_schema.constraint_column_usage AS ccu
	      ON ccu.constraint_name = tc.constraint_name
	      AND ccu.table_schema = tc.table_schema
	WHERE tc.constraint_type = 'FOREIGN KEY' and tc.table_schema = 'public'
) ic2 on ic2.table_name = ic.table_name and ic2.column_name = ic.column_name
right join (
	select table_name from information_schema.tables
	where table_type = 'BASE TABLE' and table_schema = 'public'
) it on ic.table_name = it.table_name
order by "Tabla", "Columna"
;




