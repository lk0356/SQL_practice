-- https://en.wikibooks.org/wiki/SQL_Exercises/Movie_theatres
SELECT * FROM Movies
SELECT * FROM MovieTheaters
-- 4.1 Select the title of all movies.
SELECT Title FROM Movies
-- 4.2 Show all the distinct ratings in the database.
SELECT DISTINCT(Rating) FROM Movies
-- 4.3  Show all unrated movies.
SELECT * FROM Movies WHERE Rating IS NULL
-- 4.4 Select all movie theaters that are not currently showing a movie.
SELECT * 
FROM MovieTheaters 
WHERE Movie IS NULL

-- 4.5 Select all data from all movie theaters 
SELECT * FROM MovieTheaters
    -- and, additionally, the data from the movie that is being shown in the theater (if one is being shown).
SELECT *
FROM MovieTheaters mt
LEFT JOIN Movies m ON mt.Movie = m.Code
ORDER BY mt.Movie asc

-- 4.6 Select all data from all movies and, if that movie is being shown in a theater, show the data from the theater.
SELECT *
FROM Movies m
LEFT JOIN MovieTheaters mt
ON mt.Movie = m.Code
WHERE mt.code IS NOT NULL

-- 4.7 Show the titles of movies not currently being shown in any theaters.
SELECT m.title
FROM Movies m
LEFT JOIN MovieTheaters mt
ON mt.Movie = m.Code
WHERE mt.code IS NULL

-- 4.8 Add the unrated movie "One, Two, Three".
INSERT INTO Movies values (9, 'One, Two, Three', NULL)

-- 4.9 Set the rating of all unrated movies to "G".
UPDATE Movies SET Rating = 'G' WHERE Rating IS NULL

-- 4.10 Remove movie theaters projecting movies rated "NC-17".
DELETE FROM MovieTheaters WHERE Movie IN (
    SELECT m.Code
    FROM Movies m
    WHERE m.Rating = 'NC-17'
)
