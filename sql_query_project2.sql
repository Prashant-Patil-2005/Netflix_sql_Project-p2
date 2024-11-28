-- Netflix Project 
drop table if exists  netflix ;
create table netflix 
(
show_id	varchar(6),
type 	varchar(10),
title 	varchar(150),
director 	varchar(208),
casts 	varchar(1000),
country 	varchar(150),
date_added 	varchar(50),
release_year int,
rating 	varchar(10),
duration 	varchar(15),
listed_in 	varchar(100),
description varchar(250)

);

select * from netflix ;

select 
count (*) as total_content
from netflix ;

select 
distinct type 
from netflix ;

-- 15 Business Problems & Solutions

--1. Count the number of Movies vs TV Shows

select
type ,
count (*) as total_content
from netflix 
group by type

--2. List all movies released in a specific year (e.g., 2020)

select * from netflix 
where 
type = 'movie'
and 
release_year = 2020

--3. Find the top 5 countries with the most content on Netflix

select * 
from
(
select 
unnest(string_to_array(country, ',')) as country,
count (*) as total_content
from netflix
group by 1
) as t1
where country is not null
order by  total_content desc
limit 5;

--4. Identify the longest movie

select  * from netflix
where type = 'Movie'
order by split_part(duration, ' ', 1)::int desc;

--5. Find content added in the last 5 years
select *
from netflix
where to_date(date_added, 'month dd, yyyy') >= current_date - interval '5 years';

--6. List all TV shows with more than 5 seasons

select *
from netflix
where 
	type = 'tv show'
	and
	split_part(duration, ' ', 1)::int > 5

--7. Count the number of content items in each genre

select
unnest(string_to_array(listed_in,',')) as genre,
count(show_id) as total_content
from netflix 
group by 1 

--8. List all movies that are documentaries

select * from netflix 
where
listed_in ilike '%documentaries%'

--9. Find all content without a director

select * from netflix 
where
director is null






--10. Find the top 10 actors who have appeared in the highest number of movies produced in India.

select 
--show_id ,
--casts , 
unnest (string_to_array(casts,','))as actors ,
count (*) as total_content
from netflix 
where country ilike '%india%'
group by 1 
order by 2 desc 
limit 10



























































