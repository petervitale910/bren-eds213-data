
.table
-- Tri value logic
-- Expressions can have a value (if Boolean, TRUE or FALSE), but can be null
-- In selecting rows NULL doesnt count as true

SELECT COUNT (*) FROM Bird_nests
    WHERE floatAge < 7 OR floatAge >= 7;

SELECT COUNT(*) FROM Bird_nests 
    WHERE floatAge IS NULL;

-- Review item: relational algebra
-- Everything is a table and returns a table. 
-- simple count(*) returns a table

SELECT COUNT (*) FROM Bird_nests;

-- Looked at one example of nesting SELECTs

SELECT Scientific_name 
    FROM Species
    WHERE Code NOT IN (SELECT DISTINCT Species FROM Bird_nests);

-- Let's pretend that SQL didn't have a having clause. Can we get the same functionality
-- Back to example where we used a HAVING CLAUSE
SELECT location, MAX(Area) AS Max_area
    FROM Site
    WHERE Location LIKE '%Canada'
    GROUP BY Location
    HAVING Max_area > 200;

-- Reminder:
SELECT * FROM Site LIMIT 5;

-- Check this fly shit out (gives the same answer)
SELECT * FROM
    (SELECT location, MAX(Area) AS Max_area
    FROM Site
    WHERE Location LIKE '%Canada'
    GROUP BY Location)
    WHERE Max_area > 200;

-- JOINS (PAY ATTENTION)
-- Switch to toy.duckdb 

-- In some databases, you would just do a join without condition -- inner join 
SELECT * FROM A CROSS JOIN B; 

-- Lets add Join condition, which can be *any* expression 
SELECT * FROM A JOIN B ON acol1 < bcol1;

-- Outer join: adding rows from one table that never got matched
SELECT * FROM A RIGHT JOIN B ON acol1 < bcol1;

SELECT * FROM A LEFT JOIN B ON acol1 < bcol1;

--  More rare but:

SELECT * FROM A FULL OUTER JOIN B ON acol1 < bcol1;

-- Joining on foreign key relationship is way more common 
.schema

-- Look at data
SELECT * FROM House;
SELECT * FROM Student;

-- Typical workflow (inner is default )
SELECT * FROM Student S JOIN House H ON S.House_ID = H.House_ID;

-- One benefit of joining on a column that has a same name, can use using clause

SELECT * FROM Student JOIN House USING (House_ID);

-- Go back to bird data 
SELECT COUNT(*) FROM Bird_eggs;

-- For better viewing :
.mode line

SELECT * FROM Bird_eggs LIMIT 1;

SELECT * FROM Bird_eggs JOIN Bird_nests USING (Nest_ID) LIMIT 1;


SELECT COUNT(*) FROM Bird_eggs JOIN Bird_nests USING (Nest_ID);

.mode duckbox

-- Important point : ordering lost during join so don't say this: 
-- Ordering sjould always be LAST

SELECT * FROM 
(SELECT * FROM Bird_eggs ORDER BY Width)
JOIN Bird_nests
USING (Nest_ID);

-- Gotcha with DUCKDB its not as smart 
SELECT Nest_ID, COUNT(*) 
    FROM Bird_nests JOIN Bird_eggs USING (NEST_ID)
    GROUP BY Nest_ID;

-- Some databases let you: 
SELECT Nest_ID, Species, COUNT(*) 
    FROM Bird_nests JOIN Bird_eggs USING (NEST_ID)
    GROUP BY Nest_ID;

-- Workarounds: 
SELECT Nest_ID, ANY_VALUE(Species) AS Species, COUNT(*) 
    FROM Bird_nests JOIN Bird_eggs USING (NEST_ID)
    GROUP BY Nest_ID;

SELECT Nest_ID, Species, COUNT(*) 
    FROM Bird_nests JOIN Bird_eggs USING (NEST_ID)
    GROUP BY Nest_ID, Species;

SELECT Nest_ID, Species, Egg_num, Width, Length FROM 
    Bird_eggs JOIN Bird_nests USING (NEST_ID)
    ORDER BY Nest_ID
    LIMIT 10;

-- More any_value
SELECT Nest_ID, ANY_VALUE(Width) -- randomly select 1 
FROM Bird_eggs
Group By NEST_ID;