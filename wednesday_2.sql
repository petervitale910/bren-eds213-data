-- in toy database
SELECT * FROM A;

SELECT * FROM B;

-- Cross join 
SELECT * FROM A CROSS JOIN B; -- all combinations possible a*b, no key 

-- Select columns 
SELECT acol1, acol2 FROM (SELECT * FROM A CROSS JOIN B);

-- Here we use anyvalue bc acol2 is repeating 3 times per acol1 
SELECT acol1, ANY_VALUE(acol2), COUNT(bcol3) -- ignore null 
    FROM (SELECT * FROM A CROSS JOIN B)
    GROUP BY acol1;



-- I want to join by acol2 = bcol2

SELECT * FROM A FULL JOIN B ON A.acol2 = B.bcol2;


-- Using a condition 
SELECT * FROM A JOIN B ON acol1< bcol1;

-- Inner and outer joins
SELECT * FROM Student;

SELECT * FROM House;

-- INNER 

SELECT * FROM Student AS S JOIN House AS H ON S.House_ID = H.House_ID;

-- Requires same column names 
SELECT * FROM Student JOIN House USING (House_ID);

-- Outer join 
-- Left, Right, FULL 
SELECT * FROM Student FULL JOIN House USING (House_ID);

SELECT * FROM Student LEFT JOIN House USING (House_ID);

SELECT * FROM Student RIGHT JOIN House USING (House_ID);

SELECT * FROM Student CROSS JOIN House;

-- switch topics 
-- I might have to recreate this more for my database :(
CREATE TABLE Snow_cover (
    Site VARCHAR NOT NULL,
    Year INTEGER NOT NULL CHECK (Year BETWEEN 1990 AND 2018),
    Date DATE NOT NULL,
    Plot VARCHAR NOT NULL,
    Location VARCHAR NOT NULL,
    Snow_cover REAL CHECK (Snow_cover BETWEEN 0 AND 130),
    Water_cover REAL CHECK (Water_cover BETWEEN 0 AND 130),
    Land_cover REAL CHECK (Land_cover BETWEEN 0 AND 130),
    Total_cover REAL CHECK (Total_cover BETWEEN 0 AND 130),
    Observer VARCHAR,
    Notes VARCHAR,
    PRIMARY KEY (Site, Plot, Location, Date),
    FOREIGN KEY (Site) REFERENCES Site (Code)
);

-- Our data should not have values
SELECT * FROM Snow_cover LIMIT 5;

-- Copy data 
COPY Snow_cover FROM "../ASDN_csv/snow_survey_fixed.csv" (header TRUE, nullstr "NA");

--  YAY data 
SELECT * FROM Snow_cover LIMIT 5;

-- Temp tables leave after your session 
CREATE TEMP TABLE Camp_assignment_copy AS
   SELECT * FROM Camp_assignment; -- This will leave 

.table
-- 
SELECT * FROM Camp_assignment_copy LIMIT 5;

SELECT * FROM Personnel LIMIT 5;

SELECT Year, Site, Name FROM Camp_assignment_copy 
    JOIN Personnel ON Observer = Abbreviation;

-- Something called view 
-- A lot like a table but not a table 
-- Alot like a function 
-- Like a query 
-- Live  

CREATE VIEW Camp_personnel_v AS
   SELECT Year, Site, Name 
   FROM Camp_assignment_copy JOIN Personnel ON Observer = Abbreviation;

-- Stored in database 
.table

-- DANGER ZONE 
-- Remove BYLO 

-- Start with select
SELECT * FROM Camp_assignment_copy WHERE Site == 'bylo';

DELETE FROM Camp_assignment_copy WHERE Site == 'bylo';

SELECT * FROM Camp_personnel_v WHERE Site == 'bylo';



