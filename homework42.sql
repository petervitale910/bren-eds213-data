-- Homework 4 part 2

-- I want a double table of site person columns
SELECT * FROM Camp_assignment A JOIN Camp_assignment B
    ON (A.Site = B.Site);

-- Great thats people working at the same time 
-- Step 2. We’ve matched up people working at the same site, but they don’t necessarily overlap in time. To the previous ON clause, add another condition that checks that the “A” person’s and the “B” person’s date ranges overlap. If you are unsure of the formula to do this, it may be helpful to consult this StackOverflow post. Your table should be down to 3500 rows

SELECT * FROM Camp_assignment A JOIN Camp_assignment B
    ON ((A.Site = B.Site) and (A.Start <= B.End)  and  (A.End >= B.Start)); -- We select the sites and the date ranges! 

-- Step 3: We have some repitition to get rid of it we include a where (we only want `ikri` site)
SELECT * FROM Camp_assignment A JOIN Camp_assignment B
    ON ((A.Site = B.Site) and (A.Start <= B.End)  and  (A.End >= B.Start))
    WHERE  A.Site = 'lkri' and (A.Observer < B.Observer);


-- Step 4: Select for what we want (and rename the vars to be pretty!)
SELECT A.Site as Site, A.Observer as Observer_1, B.Observer as Observer_2 FROM Camp_assignment A JOIN Camp_assignment B
    ON ((A.Site = B.Site) and (A.Start <= B.End)  and  (A.End >= B.Start))
    WHERE  A.Site = 'lkri' and (A.Observer < B.Observer);

-- Bonus Join 

SELECT A.Site as Site, P1.Name as Name_1, P2.Name as Name_2 FROM Camp_assignment A JOIN Camp_assignment B
    ON ((A.Site = B.Site) and (A.Start <= B.End)  and  (A.End >= B.Start))
JOIN Personnel P1 ON A.Observer = P1.Abbreviation -- DOUBLE JOIN FOR THE WIN 
JOIN Personnel P2 ON B.Observer = P2.Abbreviation
WHERE A.Site = 'lkri' and (A.Observer < B.Observer)
ORDER BY Name_2; -- Order by name 2 to make it consistant
