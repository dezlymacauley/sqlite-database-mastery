/*
    ABOUT: Covering Indexes

    A covering index is not something that you create.

    This is simply what is used by SQLite when you have a query,
    where the all of the columns in the `SELECT` part of the query match
    the columns in the index.

    When this happens, SQLite can use the index directly to ge the results
    of the query.
*/

-------------------------------------------------------------------------------

-- SECTION: How to view a list of the indexes that a table has

/*
    .indexes users;
*/

-------------------------------------------------------------------------------

-- E.g. I created this query 
CREATE INDEX index_birthday_month_day 
ON users (strftime('%m-%d', birthday));

-- So instead of indexing the raw birthday column, 
-- SQLite will run this function `strftime('%m-%d', birthday)` for every row 
-- and index the result of the function.

-------------------------------------------------------------------------------

-- Example 1: Covering index when using an expression index
EXPLAIN QUERY PLAN
SELECT strftime('%m-%d', birthday) AS birthday_md
FROM users
WHERE strftime('%m-%d', birthday) = '02-06';

/*
    ***************************[ 1. row ]***************************
    id      | 3
    parent  | 0
    notused | 53
    detail  | SEARCH users USING COVERING INDEX index_birthday_month_day (<expr>=?)
*/

-------------------------------------------------------------------------------

-- Example 2: Covering index when using a composite index

EXPLAIN QUERY PLAN
SELECT first_name, last_name, birthday FROM users
WHERE first_name = 'Dezly' AND last_name = 'Macauley';

/*
    ***************************[ 1. row ]***************************
    id      | 2
    parent  | 0
    notused | 54
    detail  | SEARCH users USING COVERING INDEX composite_index_fname_lname_bday (first_name=? AND last_name=?)
*/

-------------------------------------------------------------------------------
