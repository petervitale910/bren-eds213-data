Homework 7_2
-- Location: Washington Square Park, New York City, NY
-- Lat: 40.7308, Long: --73.9966
-- State: New York (STATEFP = 36)
 
duckdb walkability.duckdb
-- Install extensions
INSTALL spatial;

INSTALL httpfs;
SET enable_http_metadata_cache = false;
SET enable_object_cache = false;
SET memory_limit = '4GB';
SET threads = 2;
SET preserve_insertion_order = false;

-- Load extensions
LOAD spatial;

LOAD httpfs;
 
-- Data Import
 
-- Create Fips table from CSV 

CREATE TABLE Fips AS
    SELECT * FROM read_csv('https://apps.bren.ucsb.edu/eds213-data/walkability/fips_state_county.csv');

SELECT * FROM Fips WHERE State_name = 'NEW YORK';
 
-- Create Walkability_ny view filtered to New York 
CREATE VIEW Walkability_ny AS
    SELECT GEOID10, STATEFP, COUNTYFP, TRACTCE, BLKGRPCE, CBSA, CBSA_Name, TotPop, NatWalkInd, geom_wgs84 
    FROM read_parquet('https://apps.bren.ucsb.edu/eds213-data/walkability/walkability_wgs84.parquet') 
    WHERE STATEFP = '36';
 
-- Join tables
 
-- create view with joined data
CREATE VIEW Walkind_ny AS
    SELECT w.*, f.State_name, f.County_name FROM Walkability_ny w
    JOIN Fips f USING (STATEFP, COUNTYFP);
 
-- Walkability at my sisters house

-- 1. one location: point in washington square park
SELECT NatWalkInd FROM Walkind_ny
    WHERE ST_WITHIN(st_point(-73.9966, 40.7308), geom_wgs84);

 -- A walkability score of 14.333 is way less than I expected!


-- 2. one tract: tract that contains when my neice was censused!
SELECT TRACTCE, COUNT(*) AS block_count, ROUND(AVG(NatWalkInd), 2) AS avg_walk_index
    FROM Walkind_ny
    WHERE TRACTCE = (
        SELECT TRACTCE FROM Walkind_ny
        WHERE ST_WITHIN(st_point(-73.9966, 40.7308), geom_wgs84)
    )
    GROUP BY TRACTCE;

-- 22 blocks with a score of 12.9. Wow the crosstreets are lowering this quickly.

-- 3. New York County
SELECT COUNTYFP, County_name, COUNT(*) AS block_count, ROUND(AVG(NatWalkInd), 2) AS avg_walk_index
    FROM Walkind_ny
    WHERE County_name = (
        SELECT County_name FROM Walkind_ny
        WHERE ST_WITHIN(st_point(-73.9966, 40.7308), geom_wgs84)
    ) GROUP BY COUNTYFP, County_name;

    -- 13.03 so compared to the whole county the park is higher, while the tract is lower. 

-- export table

-- create aggregated variable for tract
CREATE TEMP TABLE tract_agg AS
SELECT TRACTCE, ROUND(AVG(NatWalkInd), 2) AS avg_tract_index
    FROM Walkind_ny
    WHERE TRACTCE = (
        SELECT TRACTCE FROM Walkind_ny
        WHERE ST_WITHIN(st_point(-73.9966, 40.7308), geom_wgs84)
    ) GROUP BY TRACTCE;

-- create aggregated variable for county
CREATE TEMP TABLE county_agg AS
SELECT County_name, ROUND(AVG(NatWalkInd), 2) AS avg_county_index
    FROM Walkind_ny
    WHERE County_name = (
        SELECT County_name FROM Walkind_ny
        WHERE ST_WITHIN(st_point(-73.9966, 40.7308), geom_wgs84)
    ) GROUP BY County_name;

-- join temp tables to original observations
CREATE view export_table AS
SELECT *
    FROM Walkind_ny
    JOIN tract_agg USING (TRACTCE)
    JOIN county_agg USING (County_name)
    WHERE TRACTCE = (
        SELECT TRACTCE FROM Walkind_ny
        WHERE ST_WITHIN(st_point(-73.9966, 40.7308), geom_wgs84)
    );

-- export table to csv
COPY export_table TO 'export_table.csv';

-- Upon opening in another window the geometry encoding vanished, as csv's aren't made for that. Geodatabase could be used!
 