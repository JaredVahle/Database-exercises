
-- FOR THIS ASSIGNMENT I WOULD WRITE THE CODE AND USE THAT CODE TO ANSWER THE QUESTION BELOW.


SELECT * FROM albums;

-- how many rows are in the table?
-- 31 rows

SELECT DISTINCT artist
FROM albums;

-- how many unique artist names are in the albums table?
-- 23

SELECT id,artist FROM albums;

-- What is the primary key for the albums table?
-- id

SELECT MIN(release_date), MAX(release_date)
FROM albums;

-- what is the oldest release date for any album in the albums table? What is the most recent release date?
-- oldest(1967) youngest(2011)

SELECT *
FROM albums
WHERE artist = "Pink Floyd";

-- The name of all the pink floyd albums
-- The Dark Side of the Moon, The Wall

SELECT *
FROM albums
WHERE name = "Sgt. Pepper's Lonely Hearts Club Band";

-- What year was Sgt. Pepper's Lonely Hearts Club Band released?
-- 1967

SELECT genre
FROM albums
WHERE name = "Nevermind";

-- What genre is the album Nevermind
-- Grunge, Alternative rock

SELECT *
FROM albums
WHERE release_date BETWEEN 1990 AND 1999;

-- Which albums were released in the 1990s?
-- 11 albums Run code for answer because i dont want to write 11 album names.

SELECT *
FROM albums
WHERE sales < 20;

-- Which albums had less than 20 million certified sales
-- 13 albums Run code for answer

SELECT *
FROM albums
WHERE genre = "Rock";

-- All the albums with a genra of "Rock". Why do these query results not include albums with a genra of "Hard rock" or "Progressive rock"
-- The computer is only looking for the specified search of ROCK, and it will not comb through a statement to find the words

SELECT *
FROM albums
WHERE genre IN ("Rock","Progressive Rock",'Hard Rock');

