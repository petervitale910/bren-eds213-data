-- Let's test this code
SELECT Site_name, MAX(Area) FROM Site;

-- This doesn't work because we are selecting all the site names and trying to then apply one 
-- max value (or average or count) to all the values
-- to fix this you need a group by to know where to apply the values


-- So to select the max_area from across the sites, we do this: 
-- But this will not give us the max area, unless we order by area 
SELECT site_name, MAX(area)
FROM site
GROUP BY site_name
LIMIT 1;

-- vs
SELECT site_name, MAX(area) as max_area
FROM site
GROUP BY site_name
ORDER BY max_area DESC -- Need to order descending, because ascending is the default 
LIMIT 1;

-- Doing this in a single nest (without a limit) would be
SELECT Site_name, Area FROM Site WHERE Area = (SELECT MAX(area) FROM site);