## Recap: Views
-- View = shorcut
-- Similar to a function In a programming language 

-- Example: suppose we want to to look at bird nests, but we would rather see cientific names, not species codes

CREATE VIEW Nest_view AS 
    SELECT Book_page, Year, Site, Nest_ID, Scientific_name, Observer
    FROM Bird_nests JOIN species
    ON Species = Code;

SELECT * FROM Nest_view LIMIT 1;

-- Let's our view for more substantial purpose 
-- COunt eggs, but we'd like to see the nest ID and the scientidic name for each nest

SELECT Nest_ID, ANY_VALUE(Scientific_name) AS Scientific_name, COUNT(*) AS Num_eggs
    FROM Nest_view JOIN Bird_eggs
    USING (Nest_ID)
    GROUP BY Nest_ID;

-- Another option is use with clause
WITH x AS(
SELECT Nest_ID, ANY_VALUE(Scientific_name) AS Scientific_name, COUNT(*) AS Num_eggs
    FROM Nest_view JOIN Bird_eggs
    USING (Nest_ID)
    GROUP BY Nest_ID
) SELECT Scientific_name, AVG(Num_eggs) AS Avg_num_eggs FROM x
  GROUP BY Scientific_name;

  -- The variable `x` fizzles after the statement 
  Select * from x;

-- No more X

-- Can do set operations on tables
-- Duplicates are eleminated in UNIONS
-- But, if you do want to preserve all rows, UNION ALL 

-- Union example:

-- Want: bird nests and egg counts

SELECT Nest_ID, COUNT(Egg_num) AS Num_eggs
    FROM Bird_nests LEFT JOIN Bird_eggs
    USING(Nest_ID)
    GROUP BY Nest_ID;


-- Let's try solving the same problem, using union

SELECT Nest_ID, COUNT(*) AS Num_eggs
    FROM Bird_eggs
    GROUP BY Nest_ID

UNION

SELECT Nest_ID, 0 AS Num_eggs
    FROM Bird_nests
    where Nest_ID NOT IN (SELECT DISTINCT Nest_ID FROM Bird_eggs);

-- Except example: 

-- Which species do we NOT have data for 

-- 3 ways

-- Way #1 

SELECT Code FROM Species
    WHERE Code NOT IN (SELECT DISTINCT Species FROM Bird_nests);

-- Way #2 

SELECT Code
    FROM Bird_nests RIGHT JOIN Species
    On Species = Code
    WHERE Species IS NULL;

-- Way #3

SELECT Code FROM Species
EXCEPT
SELECT DISTINCT Species from Bird_nests;

## Data management statements 

-- Insert statements 
SELECT * FROM Personnel;

INSERT INTO Personnel VALUES ('jmomma', 'Joe Momma');

-- A good practice for safer code: name the columns 
INSERT INTO Personnel (Abbreviation, Name) VALUES ('mhawk', 'Mike Hawk');

-- ALso when you insert a row in a table, dont need to specify all the values. 

-- Thats another reason for spelling out the column names 

-- Databases typically have some kind of load functions to load data in bulk 

-- Updates and Deletes 

Select * FROM Bird_nests LIMIT 10; 

Update Bird_nests SET floatAge = 6.5, ageMethod = 'float'
    WHERE Nest_ID = '14HPE1';

-- Delete FROM ... WHERE ...;

-- Update and delete are very dangerous 
-- The weird/terrible behavior: if no where clause operate on all rows in table 

DELETE FROM Personnel WHERE Abbreviation = 'jmomma';
DELETE FROM Personnel WHERE Abbreviation = 'mhawk';

UPDATE Bird_nests SET floatAge = NULL; -- destroys everything 

-- Get out of duckdb

-- Whats a strategy to not make this mistake
-- One idea:
-- First do a select and then edit the statement to update 

-- Another idea: use a fake table name, then change to the real name
