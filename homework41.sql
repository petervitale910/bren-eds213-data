-- Homework 4 question 1

-- I need code from site and egg_num from bird eggs

-- Method 1:
SELECT Code FROM Site
    WHERE Code NOT IN (SELECT DISTINCT Site FROM Bird_eggs)
    ORDER BY Code;


-- Method 2:
SELECT Code FROM Site
    LEFT OUTER JOIN Bird_eggs ON (Site.Code = Bird_eggs.Site)
    WHERE Bird_eggs.Site IS NULL 
    ORDER BY Code;

-- I prefer the first one!