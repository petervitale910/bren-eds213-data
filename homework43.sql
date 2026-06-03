-- Homework 4 part 3 

-- Who's the culprit
-- I'm thinking we have the days, we have the weights. Join and restrict
.table

-- Wait bird nests has everything we need

Select Count(DISTINCT Nest_ID) FROM Bird_nests 
    WHERE (Site = 'nome' AND Year >= 1998 AND YEAR <= 2008 AND ageMethod = 'float');

-- Ope I need to join on the names 
Select List(DISTINCT P.Name ORDER BY P.name) AS Name, -- Thank you duckdb help files
    Count(DISTINCT B.Nest_ID) AS Num_floated_nests FROM Bird_nests B 
    JOIN Personnel P ON (B.Observer = P.Abbreviation)
    WHERE (B.Site = 'nome' AND B.Year >= 1998 AND B.YEAR <= 2008 AND B.ageMethod = 'float');

-- Ope I misread the question, 1 name 36 nests
Select P.name AS Name, Count(B.Nest_ID) AS Num_floated_nests FROM Bird_nests B
    JOIN Personnel P ON (B.Observer = P.Abbreviation)
    WHERE (Site = 'nome' AND B.Year >= 1998 AND B.YEAR <= 2008 AND B.ageMethod = 'float' )
    GROUP BY Name HAVING (Num_floated_nests = 36); -- Having can be used after group by

-- YAY. Fun fact in Italian 'nome' means name. We found the name who was lame at name.  