-- https://en.wikibooks.org/wiki/SQL_Exercises/Scientists
-- 6.1 List all the scientists' names, their projects' names, 
    -- and the hours worked by that scientist on each project, 
    -- in alphabetical order of project name, then scientist name.

-- NOTE: You can't actually get the hours worked by each scientist on each project. Only the total hours of each project. 
SELECT s.Name, p.hours, p.Name
FROM AssignedTo a
    JOIN Scientists s
        ON s.SSN = a.Scientist
    JOIN Projects p
        ON p.Code = a.Project
ORDER BY p.Name ASC, s.Name ASC


SELECT s.Name, p.Hours, p.Name
FROM Scientists s
    INNER JOIN AssignedTo a
        ON s.SSN = a.Scientist
    INNER JOIN Projects p
        ON a.Project = p.Code
ORDER BY p.Name ASC, s.Name ASC

-- 6.2 Select the project names which are not assigned yet
SELECT p.Name FROM Projects p
WHERE p.Code NOT IN (SELECT a.Project FROM AssignedTo a)
