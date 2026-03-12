/*
    ABOUT: Partial Indexes

    A partial index is is simply an index with a WHERE clause.

    This is an index that is placed on a column, but it only cares about
    certain values in that column (rather than a regular indexe that
    duplicates the entire column).

    When would you use this?
    
    E.g. I want to place an index a column like is_pro

    This is a column that stores true or false as INTEGERS (because SQLite
    does not have a boolen type). So 0 = false, and 1 = true

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

-- I'll calculate the Selectivity of the column
SELECT
    printf('%.2f', (COUNT(DISTINCT is_pro) * 1.0) / (COUNT(*) *1.0 ))
 AS "Selectivity of is_pro column"
 FROM users;

/*
    +------------------------------+
    | Selectivity of is_pro column |
    +------------------------------+
    | 0.00                         |
    +------------------------------+
*/

-- This indicates that the column is Low-Selectivity.
-- In simple terms a bad candidate for placing an index.

-- This makes sense because the cardinality is 2.
-- There will only ever be two unique values in this column:
-- 0 which means false, and 1 which means true.

-------------------------------------------------------------------------------

-- SECTION: Where a partial index would help

-- Let's say I have a query that includes the is_pro column,
-- but I only want to see results for users that are pro members.
-- In simple terms `WHERE is_pro = true`

-------------------------------------------------------------------------------

CREATE index partial_index_is_pro_true 
ON users(is_pro)
WHERE is_pro = true;

-------------------------------------------------------------------------------

EXPLAIN QUERY PLAN
SELECT id, first_name, last_name, is_pro
FROM users
WHERE is_pro = true;

/*
    +----+--------+---------+---------------------------------------------------------------+
    | id | parent | notused | detail                                                        |
    +----+--------+---------+---------------------------------------------------------------+
    | 3  | 0      | 61      | SEARCH users USING INDEX partial_index_is_pro_true (is_pro=?) |
    +----+--------+---------+---------------------------------------------------------------+
*/

-------------------------------------------------------------------------------
