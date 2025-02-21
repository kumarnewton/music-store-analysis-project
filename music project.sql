select * from album
select * from employee
select * from genre
select * from customer
select * from invoice

q1: who is the senior most employee based on job title ?

select * from employee
order by levels desc
limit 1

q2: which countries have the most invoices ?

select count (*) as c, billing_country
from invoice
group by billing_country
order by c desc
limit 1

q3. what are top 3 values of total invoice ?

select total from invoice
order by total desc
limit 3

---- q4: which city has the best customers ? we would like to throw a promotional music festival in the city we made the most money.
-- write a query that returns one city that has the highest sum of total invoice totals.
-- return both the city name and sum of all invoice totals 

select sum(total) as invoice_total, billing_city
from invoice
group by billing_city
order  by invoice_total desc

-- q5: who is the best customer ? the customer who has spent the most money will be decleared the best customer. 
-- write a query that returns the persons who has spent the most money?

select customer.customer_id, customer.first_name, customer.last_name, sum(invoice.total) as total
from customer
join invoice on customer.customer_id = invoice.customer_id
group by customer.customer_id
order by total desc
limit 1

-- modn

-- write a query to return the email, first name, last name, genre of all rock music listerns. 
-- return your list ordered alphabatically by the email starting with A.

select distinct email,first_name, last_name
from customer
join invoice on customer.customer_id = invoice.customer_id
join invoice_line on invoice.invoice_id = invoice_line.invoice_id
where track_id in(
select track_id from track
join genre on track.genre_id = genre.genre_id
where genre.name like 'Rock'
)
order by email;

--0R

SELECT DISTINCT email, first_name, last_name
FROM customer
JOIN invoice ON customer.customer_id = invoice.customer_id
JOIN invoice_line ON invoice.invoice_id = invoice_line.invoice_id
JOIN track ON invoice_line.track_id = track.track_id
JOIN genre ON track.genre_id = genre.genre_id
WHERE genre.name LIKE 'Rock'
ORDER BY email;


-- Let's invite the artist who have written the most rock music in our dataset. 
-- write a query that returns the artist name and total track count of the 10 rocks bands

select artist.artist_id, artist.name, count(artist.artist_id) as number_of_songs
from track
join album on album.album_id = track.album_id
join artist on artist .artist_id = album.artist_id
join genre on genre.genre_id = track.genre_id
where genre.name like 'Rock'
group by artist.artist_id
order by number_of_songs desc
limit 10;

-- Return all the track names that have a song length longer than the average song length. 
-- return the name nd mileseconds for each track. order by the song length with the longest songs listed first.

select name,milliseconds
from track
where milliseconds > (
select avg(milliseconds) as avg_track_length
from track)
order by milliseconds desc;