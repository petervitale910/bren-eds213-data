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

 
