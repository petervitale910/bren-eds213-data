7.1.1 Interpolation 
The exact string is 
SELECT *
    FROM Students
    WHERE (name = 'Robert');
    DROP TABLE Students; -- AND year = 2026);

The -- means that everything after will be ignored

The name basically makes it so that the query drops the whole students table. Some sql injection!

7.1.2 
Suppose instead the school system executed the query:

SELECT *
    FROM Students WHERE name = 'Robert');
    DROP TABLE Students; -- 
What slightly different “name” would Little Bobby Tables use to destroy things in that case?

In this case the unmatched parenthesis would error out before even moving into the drop. In this case the error saves our table

