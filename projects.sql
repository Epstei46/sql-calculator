---------------------------For Reference---------------------------
-- After going through the setup instrctions, I opened pgAdmin 4 to verify that the tables were created and to check what the names of the tables were, then I checked the data in each table (shown below).
-- To test my query, run 'psql projects' in the terminal, then copy-paste my query. '\q' to exit.

-- SELECT * FROM grades;
---------------------grades table---------------------
--  id | student_github |  project_title  | grade
-- ----+----------------+-----------------+-------
--   1 | jhacks         | News Aggregator |    10
--   4 | sdevelops      | News Aggregator |    50
--   2 | jhacks         | Snake Game      |     2
--   3 | sdevelops      | Snake Game      |   100
--   5 | tcodes         | Snake Game      |   100
--   6 | tcodes         | Snake Game      |   100
--   7 | alearns        | Snake Game      |     0
--   8 | rpractices     | Snake Game      |   100
--   9 | banalyzes      | Snake Game      |     0
--  10 | ctypes         | Snake Game      |    97
--  11 | wcodes         | Snake Game      |    96
--  12 | lgifs          | Snake Game      |    50
--  13 | casks          | Snake Game      |    64

-- SELECT * FROM projects;
-----------------------------projects table-----------------------------
--  id |      title      |                   description                    | max_grade
-- ----+-----------------+--------------------------------------------------+-----------
--   5 | Recipe Storage  | An app to let users keep track of family recipes | 150
--   1 | Snake Game      | An interactive puzzle game                       | 50
--   2 | News Aggregator | Custom news filter with auto-tagging system      | 10

-- SELECT * FROM students;
----------------students table----------------
--  id | first_name | last_name |  github
-- ----+------------+-----------+-----------
--   1 | Jane       | Hacker    | jhacks
--   2 | Sarah      | Developer | sdevelops





------------------------BASIC INFO------------------------

-- Problem 1: What is the average grade for the project called News Aggregator? Be sure to use the AVG aggregate function in your query.
SELECT AVG(grade) FROM grades WHERE project_title = 'News Aggregator';
-- Result: 30.0000000000000000



-- Problem 2: What is the sum of all points that the entire class received on the project called Recipe Storage? Be sure to use the SUM aggregate function in your query.
SELECT COALESCE(SUM(grade), 0) as sum FROM grades WHERE project_title = 'Recipe Storage';
-- Result: 0



-- Problem 3: How many total projects are there? Be sure to use the COUNT aggregate function in your query.
SELECT COUNT(title) FROM projects;
-- Result: 3



-- Problem 4: What is the maximum grade that students received on the project called News Aggregator? Be sure to use the MAX function in your query.
SELECT MAX(grade) FROM grades WHERE project_title = 'News Aggregator';
-- Result: 50



-- Problem 5: What is the minimum project that any student received on ANY project? Be sure to use the MIN function in your query.
SELECT MIN(grade) FROM grades;
-- Result: 0





------------------------JOINs------------------------

-- Problem 1: Produce a result set that shows each grade, the project title, and the student name for that grade. (You will need to JOIN the grades and students table.)
SELECT CONCAT(s.first_name,' ',s.last_name) AS name, g.project_title, g.grade FROM students s
JOIN grades g ON (s.github = g.student_github) ORDER BY name;
-- Result:
--       name       |  project_title  | grade
-- -----------------+-----------------+-------
--  Jane Hacker     | News Aggregator |    10
--  Jane Hacker     | Snake Game      |     2
--  Sarah Developer | News Aggregator |    50
--  Sarah Developer | Snake Game      |   100



-- Problem 2: Produce a result set that shows each project, project id, and the number of grades that exist for that project. You will need to JOIN the projects and grades table.
SELECT p.title, p.id, COALESCE(COUNT(g.grade), 0) FROM projects p
LEFT JOIN grades g ON (p.title = g.project_title)
GROUP BY p.title, p.id;
-- Result:
--       title      | id | coalesce
-- -----------------+----+----------
--  Recipe Storage  |  5 |        0
--  Snake Game      |  1 |       11
--  News Aggregator |  2 |        2





----------------Filtering Using Aggregates----------------
-- The following queries can be written using either a JOIN or a sub-query.

-- Problem 1: How many scores for the News Aggregator project were above the average score?
SELECT COUNT(grade) FROM grades
WHERE project_title = 'News Aggregator' AND grade > (
    SELECT AVG(grade) FROM grades
    WHERE project_title = 'News Aggregator'
); -- if we delete above line, AVG for all grades == 59 so result would be 0
-- Result: 1



-- Problem 2: How many scores for the Snake Game were equal to the maximum score?
SELECT COUNT(grade) FROM grades
WHERE grade = (
    SELECT MAX(grade) FROM grades
    WHERE project_title = 'Snake Game'
);
-- Result: 4



-- Problem 3: Which projects have at least 5 grades in the grades table?
SELECT p.title FROM projects p
LEFT JOIN grades g ON (p.title = g.project_title)
GROUP BY p.title HAVING COUNT(g.grade) > 5;
-- Result: Snake Game





-------------------Working with Strings-------------------

-- Problem 1: You need to generate text for a grade report that will go out to each student. Produce a result set for students who received a grade of 90 or above that says "Congrats STUDENT_NAME, you received a SCORE on PROJECT_NAME". You will need to use string concatenation in SQL for this problem.

-- Result:



-- Problem 2: Produce a similar report as you did in problem #9, but instead, produce a result set for students who received a score of 70 or less. The report should say "Your assignment needs improvement, you received a SCORE on PROJECT_NAME".

-- Result:



-- Problem 3: There is another database that categorizes students with a student id which is their firstname-lastname. Note that this id is all lowercase with a dash in between. Produce a result set which is the id for the other database for each student. You will need to lower case the first and last name for each student and concatenate strings together to make the full ID.

-- Result:


--------------------Discussion Questions--------------------
-- Using what you learned in the Advanced SQL videos, answer the following questions as comments in your database.sql file.

-- Question 1: What is the significance of transactions in SQL? When would you want to use a transaction? What is the syntax for executing a transaction?

-- Answer: 



-- Question 2: What is the difference between implicit and explicit type conversion in SQL? Give an example of how you can execute explicit type conversion using SQL synax.

-- Answer: 