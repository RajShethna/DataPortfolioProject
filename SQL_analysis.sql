-- Data_Source: kaggle datasets download -d harshitshankhdhar/imdb-dataset-of-top-1000-movies-and-tv-shows

--round off the IMDB values
Update imdb_data
set IMDB_rating = round(IMDB_rating,2)


--IMDB_rating vs Gross(in millions)
select IMDB_Rating, avg(Gross/1000000.000) as Gross_in_millions_avg
from imdb_data
where gross is not null
group by IMDB_Rating
order by IMDB_Rating


--Gross value of all the movies made by a Director
select director, sum(gross/1000000.00) as Gross_in_millions_sum
from imdb_data
where gross is not null
group by Director
order by Gross_in_millions_sum desc


--Effect of runtime on Gross(in million)
--convert runtime from char to int and trimming the char ' min' from the runtime coloumn
select cast(trim(' min' from runtime) as int) as Runtime, avg(gross/1000000.00) as Gross_in_millions_avg
from imdb_data
where gross is not null
group by Runtime
order by Runtime asc


--Total gross(in miilions) of movies for every year
select released_year, sum(gross/1000000.00) as Gross_in_millions_sum
from imdb_data
where gross is not null
group by Released_Year
order by Released_Year asc




--Create View to store data for later visualization 

create view IMDBRating_vs_Gross as
--IMDB_rating vs Gross(in millions)
select IMDB_Rating, avg(Gross/1000000.000) as Gross_in_millions_avg
from imdb_data
where gross is not null
group by IMDB_Rating
--order by IMDB_Rating

create view GrossValueOfAllMovies_ByDirector as
--Gross value of all the movies made by a Director
select director, sum(gross/1000000.00) as Gross_in_millions_sum
from imdb_data
where gross is not null
group by Director
--order by Gross_in_millions_sum desc

create view Runtime_vs_Gross as
--Effect of runtime on Gross(in million)
--convert runtime from char to int and trimming the char ' min' from the runtime coloumn
select cast(trim(' min' from runtime) as int) as Runtime, avg(gross/1000000.00) as Gross_in_millions_avg
from imdb_data
where gross is not null
group by Runtime
--order by Runtime asc

create view Year_vs_TotalGross as
--Total gross(in miilions) of movies for every year
select released_year, sum(gross/1000000.00) as Gross_in_millions_sum
from imdb_data
where gross is not null
group by Released_Year
--order by Released_Year asc