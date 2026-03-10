/*
    ABOUT: Composite Indexes

    This is when you have an index that is placed on multiple columns.

*/

-------------------------------------------------------------------------------

-- This is how to declare a composite index
CREATE INDEX composite_index_fname_lname_bday 
on users (first_name, last_name, birthday);

-- TIP: When declaring the columns in the index, the order matters
-- as you will see in the examples below

-- E.g. 

PRAGMA table_info(users);

/*
    +-----+------------+----------+---------+------------+----+
    | cid | name       | type     | notnull | dflt_value | pk |
    +-----+------------+----------+---------+------------+----+
    | 0   | id         | INTEGER  | 1       | <null>     | 1  |
    | 1   | first_name | varchar  | 1       | <null>     | 0  |
    | 2   | last_name  | varchar  | 1       | <null>     | 0  |
    | 3   | email      | varchar  | 1       | <null>     | 0  |
    | 4   | birthday   | varchar  | 0       | <null>     | 0  |
    | 5   | is_pro     | INTEGER  | 1       | '0'        | 0  |
    | 6   | deleted_at | varchar  | 0       | <null>     | 0  |
    | 7   | created_at | datetime | 0       | <null>     | 0  |
    | 8   | updated_at | datetime | 0       | <null>     | 0  |
    +-----+------------+----------+---------+------------+----+
*/

-------------------------------------------------------------------------------

-- To view information about an index

PRAGMA index_info("composite_index_fname_lname_bday");

/*
    +-------+-----+------------+
    | seqno | cid | name       |
    +-------+-----+------------+
    | 0     | 1   | first_name |
    | 1     | 2   | last_name  |
    | 2     | 4   | birthday   |
    +-------+-----+------------+
*/

-------------------------------------------------------------------------------

-- SECTION: Why the order of the columns matters when using a composite index

-- When the composite index was declared,
-- the order was: first_name, last_name, birthday

-- CREATE INDEX composite_index_fname_lname_bday 
-- on users (first_name, last_name, birthday);

-------------------------------------------------------------------------------

-- First I set the mode to vertical just to make the output 
-- of the command easier.

.mode vertical;

-------------------------------------------------------------------------------

-- Example 1
EXPLAIN QUERY PLAN
SELECT * FROM users WHERE first_name = 'Dezly';

/*
    ***************************[ 1. row ]***************************
    id      | 3
    parent  | 0
    notused | 62
    detail  | SEARCH users USING INDEX composite_index_fname_lname_bday (first_name=?)
*/

-- As you can see, the composite index will be used:
-- As long as the column `first_name` appears in your query, the condition
-- is satified. It does not matter if `last_name` and `birthday` are not
-- being used in the query.

-------------------------------------------------------------------------------

-- Example 2
EXPLAIN QUERY PLAN
SELECT * FROM users 
WHERE last_name = 'Macauley';

/*
    ***************************[ 1. row ]***************************
    id      | 2
    parent  | 0
    notused | 216
    detail  | SCAN users
*/

-- As you can see, the composite index will NOT be used
-- This is because a query must use the `first_name` column first.

-------------------------------------------------------------------------------

-- Example 3
EXPLAIN QUERY PLAN
SELECT * FROM users 
WHERE first_name = 'Dezly' AND last_name = 'Macauley';

/*
    ***************************[ 1. row ]***************************
    id      | 3
    parent  | 0
    notused | 61
    detail  | SEARCH users USING INDEX composite_index_fname_lname_bday (first_name=? AND last_name=?)
*/

-- As you can see, the composite index WILL be be used in this case,
-- because the query contains `first_name` and `last_name`

-------------------------------------------------------------------------------

-- Example 4
EXPLAIN QUERY PLAN
SELECT * FROM users 
WHERE last_name = 'Macauley' AND first_name = 'Dezly';

/*
    ***************************[ 1. row ]***************************
    id      | 3
    parent  | 0
    notused | 61
    detail  | SEARCH users USING INDEX composite_index_fname_lname_bday (first_name=? AND last_name=?)
*/

-- As you can see, the composite index WILL be be used in this case.
-- This is because SQLite will reorder the conditions of your query.
-- It looks for `first_name` and then `last_name` and then executes.

-------------------------------------------------------------------------------

-- Example 5
EXPLAIN QUERY PLAN
SELECT * FROM users 
WHERE first_name = 'Tim' AND birthday = '1995-02-06';

/*
    ***************************[ 1. row ]***************************
    id      | 3
    parent  | 0
    notused | 62
    detail  | SEARCH users USING INDEX composite_index_fname_lname_bday (first_name=?)
*/

-- This works... but it is only partially using the composite index
-- You'll noticed that the index on `birthday` column is not being used.
-- This is because SQLite looks for `first_name` in the query,
-- then `last_name`, and then `birthday`.
-- There is no `last_name` in the query, 
-- so the index on `birthday` can't be used.

-------------------------------------------------------------------------------

-- Example 5

-- NOTE: Any indexes in the query that are after the first `range condition`
-- in a query will not be used.

EXPLAIN QUERY PLAN
SELECT *
FROM users
WHERE first_name = 'Tim'
AND last_name >= 'M'
AND birthday = '1995-02-06';

/*
    ***************************[ 1. row ]***************************
    id      | 3
    parent  | 0
    notused | 51
    detail  | SEARCH users USING INDEX composite_index_fname_lname_bday (first_name=? AND last_name>?)
*/

-- The range condition is `AND last_name >= 'M`
-- Any indexes in the query after the rang

-------------------------------------------------------------------------------
