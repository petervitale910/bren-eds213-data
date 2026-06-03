-- Homework 6 part 2

-- LLM Review

-- I am sharing these queries with others as to not compound prompts!

-- Evaluate the SQL LLMs returned.
-- claude ai ---
SELECT p.Name
FROM Bird_nests bn
JOIN Personnel p ON bn.Observer = p.Abbreviation
WHERE bn.Site = 'nome' AND bn.Year BETWEEN 1998 AND 2008 AND bn.ageMethod = 'float'
GROUP BY bn.Observer, p.Name
HAVING COUNT(*) = 36;

-- Chatgpt ---
SELECT p.Name
FROM Bird_nests AS b
JOIN Personnel AS p ON b.Observer = p.Abbreviation
WHERE b.Site = 'nome' AND b.Year BETWEEN 1998 AND 2008 AND b.ageMethod = 'float'
GROUP BY p.Name
HAVING COUNT(*) = 36;

-- Gemini --
SELECT p.Name
FROM Bird_nests n
JOIN Personnel p ON n.Observer = p.Abbreviation
JOIN Site s ON n.Site = s.Code
WHERE s.Site_name = 'nome' AND n.Year BETWEEN 1998 AND 2008 AND n.ageMethod = 'float'
GROUP BY p.Name
HAVING COUNT(n.Nest_ID) = 36;

-- Discussion:
-- Both Claude and ChatGPT had essentially the same query and resulted in the correct answer. The only difference between the two 
-- is that Claude grouped on both observer and name. Since Chat was able to acheive the same outcome with just the name it understood the
-- better. Gemini's resulted in an empty name list (WRONG) and used count of nest_ID instead of count (*). Important to note, none of the 
-- queries had number of eggs floated in the output. 