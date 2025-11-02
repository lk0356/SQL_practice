-- https://en.wikibooks.org/wiki/SQL_Exercises/Planet_Express 
SELECT * FROM Employee

-- 7.1 Who receieved a 1.5kg package?

SELECT * FROM Package

SELECT c.Name
FROM Client c
    INNER JOIN Package p
        ON c.AccountNumber = p.Recipient
WHERE p.Weight = 1.5

-- 7.2 What is the total weight of all the packages that he sent?
SELECT SUM(p.weight)
FROM Client c
    INNER JOIN Package p
        ON c.AccountNumber = p.Recipient
WHERE c.Name = 'Al Gores Head'
GROUP BY c.Name
