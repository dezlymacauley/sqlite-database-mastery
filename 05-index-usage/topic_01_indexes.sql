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

-- The birthday column is used to filter the results of the query,
-- however for this example, placing an index on the birthday column would be
-- pointless because a column can only be used as an index when it is directly
-- used as a filter.

-- In this example the column `birthday` is used by the `string-format time` 
-- function to extract only the month and date from the birthday.

-------------------------------------------------------------------------------

-- The solution is to create an `expression index`
CREATE INDEX index_birthday_month_day 
ON users (strftime('%m-%d', birthday));

-- So instead of indexing the raw birthday column, 
-- SQLite will run this function `strftime('%m-%d', birthday)` for every row 
-- and index the result of the function.

-------------------------------------------------------------------------------

-- You can check that the index has been created by running this command:

/*
    .indexes users;
*/

-- The output should look like this:

/*
    +--------------------------+----------------------------------------+
    | name                     | sql                                    |
    +--------------------------+----------------------------------------+
    | index_birthday_month_day | CREATE INDEX index_birthday_month_day  |
    |                          | ON users (strftime('%m-%d', birthday)) |
    +--------------------------+----------------------------------------+
*/

-------------------------------------------------------------------------------

-- SECTION: How to check that you setup your index correctly.

-- I use `EXPLAIN QUERY PLAN` on the original query again,
-- that will search for all users who have a birthday 
-- on the 21st of October.
EXPLAIN QUERY PLAN
SELECT * FROM users
WHERE strftime('%m-%d', birthday) = '10-21';

/*
    +----+--------+---------+--------------------------------------------------------------+
    | id | parent | notused | detail                                                       |
    +----+--------+---------+--------------------------------------------------------------+
    | 3  | 0      | 61      | SEARCH users USING INDEX index_birthday_month_day (<expr>=?) |
    +----+--------+---------+--------------------------------------------------------------+
*/

-- This proves that SQLite is using the index `index_birthday_month_day` to
-- get the results of the query. This is more efficient than scanning every 
-- row in the table.

-------------------------------------------------------------------------------

-- SECTION: How prove that the index is actually making the query faster?

-- STEP: 1 => First log out of the `litecli` prompt 
-- and log into the `sqlite3` prompt

/*
    sqlite3 name_of_database.sqlite

    Your prompt should look like this now:

    SQLite version 3.51.2 2026-01-09 17:27:48
    Enter ".help" for usage hints.
    sqlite>

    Press `Ctrl l` to clear the prompt

    STEP: 2 => Turn on the timer with this dot command.

    .timer on

    The `.timer on` command is not available in `litecli`, 
    that is why you have to log into `sqlite3`

    STEP: 3 => Delete the index

   DROP INDEX index_birthday_month_day;
    
    STEP: 4 => Confirm that the index is gone

    .indexes users;
    
   STEP: 5 => Run the query without the index

    SELECT * FROM users WHERE strftime('%m-%d', birthday) = '10-21';

    You should see this at the end:
    Run Time: real 0.708384 user 0.657272 sys 0.041475

    The value you want to look at is `real`. 
    This shows that the query took 0.7 seconds (rounded up to 2 decimals)
   
    STEP: 6 => Create the index again

    CREATE INDEX index_birthday_month_day ON users (strftime('%m-%d', birthday));
   
    STEP: 7 => Confirm that SQLite is using the index

    QUERY PLAN
    SELECT * FROM users
    WHERE strftime('%m-%d', birthday) = '10-21';

    You should see this:

    QUERY PLAN
    `--SEARCH users USING INDEX index_birthday_month_day (<expr>=?)

    STEP: 8 => Run the query again

    SELECT * FROM users WHERE strftime('%m-%d', birthday) = '10-21';

    You should see this at the end:
    Run Time: real 0.135979 user 0.019420 sys 0.029258

    This shows that the query took 0.14 seconds (rounded up to 2 decimals)

    To exit the sqlite prompt just use `.quit`

*/

-------------------------------------------------------------------------------
