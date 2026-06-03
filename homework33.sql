-- Recreating table
-- Create temp table
CREATE TEMP TABLE Averages AS
    SELECT Nest_ID, AVG((3.14/6) * (Width **2) * Length ) AS Avg_volume -- I was unsure if this formula would work but it did!
        FROM Bird_eggs
        GROUP BY Nest_ID; 


-- Recreate the table
SELECT Scientific_name, MAX(Avg_volume) AS Max_Avg_Volume -- This trips me up! We call something that isn't joined yet! But we select these
    FROM Bird_nests -- From This
    JOIN Averages USING (Nest_ID) -- Joined on this and
    JOIN Species ON (Bird_nests.Species = Species.Code) -- Second join in one!
    GROUP BY Scientific_name -- Group it by scientific name
    ORDER BY Max_Avg_Volume DESC; -- Order it descending

-- Looks good! 