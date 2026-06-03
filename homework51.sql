-- Homework 5 Part 1

-- Step 1 Create Nests_big and eggs_big

CREATE TABLE Nests_big AS SELECT * FROM 'nests_big.csv';

CREATE TABLE Eggs_big AS SELECT * FROM 'eggs_big.csv';

-- Oh wow these are like 10-40x bigger than eggs and nests 

-- Step 2: 3 way join between Nests_big, eggs_big, and species only of calidas alphina

SELECT * FROM eggs_big e
  JOIN nests_big n USING (Nest_ID)
  JOIN Species s ON (n.Species = s.Code)
  WHERE s.Scientific_name == 'Calidris alpina';

-- Yay!!

-- Step 3: We are just going to select the site column and calculate egg volume
SELECT Site, ((3.14/6)* e.Width^2 * e.Length) as Volume FROM eggs_big e
  JOIN nests_big n USING (Nest_ID)
  JOIN Species s ON (n.Species = s.Code)
  WHERE s.Scientific_name == 'Calidris alpina';

-- Lovely!

-- Step 4: Join with the site table and grab longitude
SELECT si.Longitude, ((3.14/6)* e.Width^2 * e.Length) as Volume FROM eggs_big e
  JOIN nests_big n USING (Nest_ID)
  JOIN Species s ON (n.Species = s.Code)
  JOIN Site si ON (n.Site = si.Code)
  WHERE s.Scientific_name == 'Calidris alpina';

  
-- Step 5: Recalculate longitude 
SELECT CASE WHEN si.Longitude > 0  THEN si.Longitude - 360 ELSE si.Longitude END AS Longitude, 
((3.14/6)* e.Width^2 * e.Length) as Volume FROM eggs_big e
  JOIN nests_big n USING (Nest_ID)
  JOIN Species s ON (n.Species = s.Code)
  JOIN Site si ON (n.Site = si.Code)
  WHERE s.Scientific_name == 'Calidris alpina';

-- Step 6: Save as temp table
CREATE TEMP TABLE Temp AS
SELECT CASE WHEN si.Longitude > 0  THEN si.Longitude - 360 ELSE si.Longitude END AS Longitude, 
((3.14/6)* e.Width^2 * e.Length) as Volume FROM eggs_big e
  JOIN nests_big n USING (Nest_ID)
  JOIN Species s ON (n.Species = s.Code)
  JOIN Site si ON (n.Site = si.Code)
  WHERE s.Scientific_name == 'Calidris alpina';

-- Step 7: Run regression 
SELECT 
  regr_slope(Volume, Longitude) AS slope, -- Thank you stack overflow 
  corr(Volume, Longitude)       AS correlation
FROM Temp;

-- QUESTIONS

--Do the tables created automatically by DuckDB guarantee that a nest ID mentioned in the Eggs_big table actually exists in the Nests_big table? If yes, explain how that is guaranteed, if not, explain why not. (6pts)

-- No! DUCKDB infers data types from the csv, so its possible that the values could be different. Furthermore apparently duckdb doesnt keep the integrity of the foreign keys, so that could be a pretty big issue. 

-- What queries did you use (or could you use) to find the minimum and maximum longitude values in the Site table? (2pts)

-- You could use Min() or Max() in the select

-- The interpretation of the Pearson correlation coefficient is: +1 is a perfect positive correlation, -1 is a perfect negative correlation, and 0 is no correlation at all. How would you characterize the correlation between egg volume and longitude for the eggs of Calidris alpina in the Arctic above Canada? (2pts)

-- I would characterize this as a partial negative correlation, but still pretty small. 