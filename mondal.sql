-- Start the DB at the terminal: duckdb
duckdb 

-- To verify that we have the "right" database open, look what tables are in the database:
.table 

-- to see duckdb-specific commands:
.help
-- to exit:
.exit
-- In sql, comments are delimited with --

-- .schema -- lists the whole schems
.schema

-- select
SELECT * FROM Species;

-- gotchas:
-- end every line with ;
-- CAPS is convention, not case dependent
-- watch for missing closing quotes
-- control c to interrupt but not exit


-- To see `limited` number of rows
SELECT * FROM Species LIMIT 5;

-- Page through the rows
SELECT * FROM Species LIMIT 5 OFFSET 5;

-- Select columns we want 

SELECT Code, Scientific_name FROM Species;

-- Another handy query to explore data (distinct)

SELECT DISTINCT Species FROM Bird_nests;

-- Can also get distinct pairs or tuples that occur
SELECT DISTINCT Species, Observer FROM Bird_nests;

-- can ask that the results be ordered

SELECT Scientific_name FROM Species;
SELECT Scientific_name FROM Species ORDER BY Scientific_name;

-- Default `undefined` ordering can be subtle

SELECT DISTINCT Code FROM Species;
SELECT DISTINCT Code FROM Species LIMIT 3;

-- Try again, asking for the results be ordered 
SELECT DISTINCT Code FROM Species ORDER BY Code;
SELECT DISTINCT Code FROM Species ORDER BY Code LIMIT 3;

-- In-class challenge:
-- Select distinct locations from the Site table; are they in order? of not order them 
SELECT DISTINCT Location FROM Site; --NO!
SELECT DISTINCT Location FROM Site ORDER BY Location;