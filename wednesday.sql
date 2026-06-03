.table 

SELECT DISTINCT Location
    FROM Site
    ORDER BY Location
    LIMIT 3;

-- FILTERING 
-- looks like in R or Python 
SELECT * FROM Site WHERE Area<200; -- Where is keyword
SELECT * FROM Site WHERE Area < 200 AND Latitude > 60; --AND, OR, NOT are all available 

-- older style operators 
SELECT * FROM Site WHERE Code <> 'iglo'; -- Not equals == <>

-- expression: the usual operators, plus functions like regex

-- EXPRESSIONS
-- Can do computation

SELECT Site_name, Area * 2.47 FROM Site; -- Conversion from acres

-- Handy to give a name to columns 
SELECT Site_name, Area * 2.47 as Area_acres FROM Site;

-- Say we want to cocatinate site name and location
-- old style: ||
SELECT Site_name || ', ' || Location as Full_name FROM Site;

-- Fancy calculator 
SELECT 2+2

-- AGGREGATION AND GROUPING

-- how many rows are in this table?
SELECT COUNT(*) AS Count FROM Bird_nests; -- * is count all rows

-- how many non null ?

SELECT COUNT(Scientific_name) AS Count_SCI_name FROM Species;

-- Count number of distinct things 
SELECT COUNT(DISTINCT Location) AS Num_distinct_location FROM Site;

-- compared to just location
SELECT COUNT(Location) AS Num_location FROM Site;

-- 7 vs 16 
-- What are the locations? 
SELECT DISTINCT Location FROM Site;

-- Usual aggregation functions

Select AVG(Area) FROM Site;
Select MIN(Area) FROM Site;

-- This won't work, but suppose we want to list 7 locations in site table 
-- along with average areas 
SELECT Location, AVG(Area) FROM Site; 

-- enter grouping 
SELECT Location, AVG(Area) FROM Site GROUP BY Location;  

-- similar for counting
SELECT Location, COUNT(*) AS Num_rows FROM Site GROUP BY Location;  

-- We can still have WHERE clauses
SELECT Location, COUNT(*) AS Num_rows FROM Site 
WHERE Location LIKE '%Canada' 
GROUP BY Location; 

-- Order of clauses reflect order of the processing
-- But what if you want to do some filtering on your groups, i.e., *after* you've done the grouping?
SELECT location, MAX(Area) as Max_area
    FROM Site
    WHERE Location LIKE '%Canada'
    GROUP BY Location
    HAVING Max_area > 200
    ORDER BY Max_area;

-- RELATIONAL ALGEBRA 
-- Everything is a table, every query and statement returns a table 
SELECT COUNT(*) FROM Site; -- dis a table 

-- You can save tbales, nest queries 
SELECT COUNT(*) FROM ( SELECT COUNT(*) FROM Site);

-- You can nest queries 
SELECT DISTINCT Species FROM Bird_nests;

SELECT Code FROM Species
    WHERE Code NOT IN (SELECT DISTINCT Species FROM Bird_nests);

-- NULL PROCESSING
-- Null is infectious 
-- Null in table means no data
-- In expression, means unknown 

SELECT COUNT(*) FROM Bird_nests WHERE ageMethod = 'float';
SELECT COUNT(*) FROM Bird_nests WHERE ageMethod <> 'float';

-- Special syntax for null rows 
-- this won't work 
SELECT COUNT(*) FROM Bird_nests WHERE ageMethod = NULL;

-- This will (ONLY WAY)
SELECT COUNT(*) AS Num_null FROM Bird_nests WHERE ageMethod IS NULL;
SELECT COUNT(*) AS Num_real FROM Bird_nests WHERE ageMethod IS NOT NULL;

-- JOINS 
-- 90% of time, we join tables on foreign key relationship 
SELECT * FROM Camp_assignment;
SELECT * FROM Camp_assignment JOIN Personnel
    ON Observer = Abbreviation
    LIMIT 10;

-- Join is general operation, can be applied to any tables, with any expression joining them 
-- Fundamentally binds all objects
SELECT * FROM Site CROSS JOIN Species;

-- Lets see if this makes sense 
SELECT COUNT(*) FROM Site;
SELECT COUNT(*) FROM Species;
SELECT 99*16;

-- Any condition can be expression, we have complete freedom

-- But when there *is* a fk then
-- result is the same as table with the fk, but with aditional columns

SELECT * FROM Bird_nests BN JOIN Species S -- Bird_nests AS BN 
    ON BN.Species = S.Code -- The COLUMNS in each 
    LIMIT 5;

SELECT * FROM Bird_nests BN JOIN Species S 
    ON BN.Species = S.Code;

-- Table aliases: 
-- if column name are ambiguous where theyre coming from, 
-- We need to qualify them 


