/* Music Database Project

Easy

1) Who is the Senior most employee based on job title? */

Select * from album;
Select * from artist;
Select * from customer;
Select * from employee;
Select * from genre;
Select * from invoice;
Select * from invoice_line;
Select * from media_type;
Select * from playlist;
Select * from playlist_track;
Select * from track;

Select first_name || ' ' || last_name as employee_name,title as job_title,min(hire_date) as joining_date
from employee group by employee_name,job_title 
order by joining_date;

-- 2) Which Country have most invoices?

Select billing_country, count(invoice_id) as number_of_invoices 
from invoice group by billing_country order by number_of_invoices desc limit 1 ;

-- 3) What are the top 3 values of total invoices?

select ROUND(total::numeric,2) as invoice_total from invoice order by total desc limit 3 ;\

/* 4) Which city has the best customers? We would like to throw a promotional music festival in the city 
we made the most money. Write a query that returns one city that has the highest sum of invoice totals.
Return the city name and sum of all invoice totals. */

Select billing_city, sum(total) as invoice_amount_total from invoice group by billing_city
order by invoice_amount_total desc limit 1;

/* 5) Who is the best customer? the customer who has spent the most money will be delared the best customer
Write a query that returns the person who has spent the most money */

Select I.customer_id , concat(C.first_name|| ' ' || C.last_name) as Customer_name, 
ROUND(sum(I.total)::numeric,2) as spent_money  from invoice I
join customer C 
on I.customer_id = C.customer_id
group by I.customer_id,C.first_name , C.last_name order by spent_money
desc limit 1 ;

-- Moderate

/* 1) Write query to return the email, first_name , last_name  & genre of all  rock music listners.
Return the list ordered alphabetically by email starting with A */

Select distinct C.email, C.first_name , C.last_name, G.name as Genre from customer C
join invoice i on C.customer_id = i.customer_id 
join invoice_line il on i.invoice_id = il.invoice_id
join track T on il.track_id = T.track_id
join genre G on T.genre_id = G.genre_id
where G.name like '%Rock%'
order by email;

/* 2) Let's invite the artist who have written the most rcok music in our dataset.
Write a query that return the artist name and total track count of the top 10 rock bands.  */

Select A.name as artist_name , count(T.track_id) as track_count from artist A
join album al on A.artist_id = al.artist_id
join track T on al.album_id = T.album_id
join genre G on T.genre_id = G.genre_id
where G.name like '%Rock%'
group by artist_name
order by track_count desc
limit 10;

/* 3) Return all the track names that have a song length longer than the average song length.
Return the name and milliseconds for each track. Order by the song length with longest song listed first.*/

Select name as song_name, milliseconds as song_length from track where milliseconds >
(Select avg(milliseconds) from track) order by song_length desc;

-- Advanced
/*1) Find how much amount spent by each customer on artists? Write a query to return customer name ,
artist name and total spent? */

Select (C.first_name || ' ' || C.last_name) as customer_name , a.name as artist_name , sum(i.total) as total_spent
from Customer C
join invoice i on C.customer_id = i.customer_id
join invoice_line il on i.invoice_id = il.invoice_id
join track T on il.track_id = T.track_id
join album al on T.album_id = al.album_id
join artist a on al.artist_id = a.artist_id
group by customer_name,artist_name
order by total_spent desc;













	 





