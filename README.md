<div align="center">

# Netflix Movies and TV Shows Data Analysis using SQL

![logo](https://github.com/user-attachments/assets/6dee2937-eb98-4596-8a28-938e6817ba6c)

</div>

## Overview
This project involves a comprehensive analysis of Netflix's movies and TV shows data using SQL. The goal is to extract valuable insights and answer various business questions based on the dataset. The following README provides a detailed account of the project's objectives, business problems, solutions, findings, and conclusions.

## Objectives

- Analyze the distribution of content types (movies vs TV shows).
- Identify the most common ratings for movies and TV shows.
- List and analyze content based on release years, countries, and durations.
- Explore and categorize content based on specific criteria and keywords.

## Dataset

The data for this project is sourced from the Kaggle dataset:

- **Dataset Link:** [Movies Dataset](https://www.kaggle.com/datasets/shivamb/netflix-shows?resource=download)

## Schema

```sql
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
```

## Business Problems and Solutions

### 1. Count the Number of Movies vs TV Shows

```sql
select
type ,
count (*) as total_content
from netflix 
group by type
```

**Objective:** Determine the distribution of content types on Netflix.

### 2. List All Movies Released in a Specific Year (e.g., 2020)

```sql
select * from netflix 
where 
type = 'movie'
and 
release_year = 2020
```

**Objective:** Retrieve all movies released in a specific year.

### 3. Find the Top 5 Countries with the Most Content on Netflix

```sql
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
```

**Objective:** Identify the top 5 countries with the highest number of content items.

### 4. Identify the Longest Movie

```sql
select  * from netflix
where type = 'Movie'
order by split_part(duration, ' ', 1)::int desc;
```

**Objective:** Find the movie with the longest duration.

### 5. Find Content Added in the Last 5 Years

```sql
select *
from netflix
where to_date(date_added, 'month dd, yyyy') >= current_date - interval '5 years';
```

**Objective:** Retrieve content added to Netflix in the last 5 years.

### 6. List All TV Shows with More Than 5 Seasons

```sql
select *
from netflix
where 
	type = 'tv show'
	and
	split_part(duration, ' ', 1)::int > 5
```

**Objective:** Identify TV shows with more than 5 seasons.

### 7. Count the Number of Content Items in Each Genre

```sql
select
unnest(string_to_array(listed_in,',')) as genre,
count(show_id) as total_content
from netflix 
group by 1 
```

**Objective:** Count the number of content items in each genre.

### 8. List All Movies that are Documentaries

```sql
select * from netflix 
where
listed_in ilike '%documentaries%'
```

**Objective:** Retrieve all movies classified as documentaries.

### 9. Find All Content Without a Director

```sql
select * from netflix 
where
director is null
```

**Objective:** List content that does not have a director.

### 10. Find the Top 10 Actors Who Have Appeared in the Highest Number of Movies Produced in India

```sql
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
```

**Objective:** Identify the top 10 actors with the most appearances in Indian-produced movies.


## Findings and Conclusion

- **Content Distribution:** The dataset contains a diverse range of movies and TV shows with varying ratings and genres.
- **Common Ratings:** Insights into the most common ratings provide an understanding of the content's target audience.
- **Geographical Insights:** The top countries and the average content releases by India highlight regional content distribution.
- **Content Categorization:** Categorizing content based on specific keywords helps in understanding the nature of content available on Netflix.

This analysis provides a comprehensive view of Netflix's content and can help inform content strategy and decision-making.



Thank you for your support, and I look forward to connecting with you!
