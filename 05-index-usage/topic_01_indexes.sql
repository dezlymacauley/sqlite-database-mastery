/*
    ABOUT: Indexes

    Indexes are used to reduced the amout of time that SQLite 
    takes to complete a query on a database.

    Faster results from your database will speed up your entire application,
    and improve the user experience.

    The concept of indexes is not specific to SQLite, so learning how to use
    indexes in SQLite will give you the skills to optimize other databases
    like Postgres.
    ___________________________________________________________________________
   
    An index is a data structure that contains a duplicated 
    part of your data, and a pointer back to the original data.

    They way your database is used, 
    will guide you on where indexes should be placed.

    ___________________________________________________________________________

*/

-------------------------------------------------------------------------------

-- SECTION: How to view a list of the indexes that a table has

/*
    .indexes users;
*/

-------------------------------------------------------------------------------

-- SECTION: EXPLAIN QUERY PLAN

-- E.g. I have a table called `users` where the birthday of each user
-- is stored in this format

SELECT birthday FROM users limit 2;

/*
    +------------+
    | birthday   |
    +------------+
    | 2005-03-08 |
    | 1982-06-29 |
    +------------+
*/

-- E.g. I want a list of all the users who have a birthday 
-- on the 21st of October.

-- If you add this line before a query, 
-- SQLite will not execute the query, but will instead show you the method
-- that it will use to run that query.

EXPLAIN QUERY PLAN
SELECT * FROM users
WHERE strftime('%m-%d', birthday) = '10-21';

/*
    +----+--------+---------+------------+
    | id | parent | notused | detail     |
    +----+--------+---------+------------+
    | 2  | 0      | 216     | SCAN users |
    +----+--------+---------+------------+
*/

-- This shows that the method that SQLite will use to make 
-- this query is `SCAN users`.

-- This means that it will scan every row of the users table 
-- to get the results of the table.

-------------------------------------------------------------------------------

-- SECTION: How to add an index

-- When deciding where to place an index, you must first examine the query.
-- As a general rule, pay attention to any columns that are used 
-- to filter the results of the query.

/*
    SELECT * FROM users
    WHERE strftime('%m-%d', birthday) = '10-21';
*/


-------------------------------------------------------------------------------


-- Since the `birthday` column is a filter used by the WHERE clause
-- in the query, adding an index to this column can be used to speed up
-- the completion of the query.

CREATE INDEX birthday_index on users(birthday);

-- You can check that the index has been created by running this command:

/*
    .indexes users;
*/

-- The output should look like this:

/*
    +----------------+------------------------------------------------+
    | name           | sql                                            |
    +----------------+------------------------------------------------+
    | birthday_index | CREATE INDEX birthday_index on users(birthday) |
    +----------------+------------------------------------------------+
*/

-------------------------------------------------------------------------------
