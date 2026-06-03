
-- Create new table 
CREATE TABLE mytable(
    nums REAL
);

-- Insert values
INSERT INTO mytable (nums)
VALUES (1),(2),(NULL),(4),(5),(NULL),(7);

-- Check if they propegated
SELECT * FROM mytable;

-- Lets see if the average works
Select AVG(nums) FROM mytable;

-- If thats including nulls it should be outputting 19/7, if not it should be outputting 19/5

SELECT 19/7;
SELECT 19/5;

-- It looks like under the hood it is not taking the NULL values into account which makes sense to me. 
-- It's essentially doing na.rm = true in R

-- PART 2
SELECT SUM(nums)/COUNT(*) FROM mytable;
SELECT SUM(nums)/COUNT(nums) FROM mytable;

-- The second is correct, as count * is taking the absolute number of rows, wheras count(nums)
-- is taking the count of the nums columns which only has actual values in 5 rows. 