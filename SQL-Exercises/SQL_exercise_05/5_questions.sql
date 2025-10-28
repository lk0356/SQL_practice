-- https://en.wikibooks.org/wiki/SQL_Exercises/Pieces_and_providers
SELECT * FROM Pieces
SELECT * FROM Provides
SELECT * FROM Providers
-- 5.1 Select the name of all the pieces. 
SELECT * FROM Pieces

-- 5.2  Select all the providers' data. 
SELECT * FROM Providers

-- 5.3 Obtain the average price of each piece (show only the piece code and the average price).
SELECT AVG(m.Price), m.Piece
FROM Provides m -- m for matching table
GROUP BY m.Piece

-- 5.4  Obtain the names of all providers who supply piece 1.
SELECT prov.Name
FROM Providers prov
JOIN Provides m 
ON prov.Code = m.Provider
WHERE m.Piece = 1

-- 5.5 Select the name of pieces provided by provider with code "HAL".
SELECT Pieces.Name
FROM Pieces
JOIN Provides 
ON Pieces.Code = Provides.Piece
WHERE Provides.Provider = 'HAL'

-- 5.6
-- ---------------------------------------------
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
-- Interesting and important one.
-- For each piece, find the most expensive offering of that piece and include the piece name, provider name, and price 
-- (note that there could be two providers who supply the same piece at the most expensive price).


-- ---------------------------------------------
-- 5.7 Add an entry to the database to indicate that "Skellington Supplies" (code "TNBC") will provide sprockets (code "1") for 7 cents each.
-- 5.8 Increase all prices by one cent.
-- 5.9 Update the database to reflect that "Susan Calvin Corp." (code "RBT") will not supply bolts (code 4).
-- 5.10 Update the database to reflect that "Susan Calvin Corp." (code "RBT") will not supply any pieces 
    -- (the provider should still remain in the database).
