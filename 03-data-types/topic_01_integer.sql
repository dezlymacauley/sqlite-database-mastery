/*
    ABOUT: INTEGER

    The INTEGER data type is used to store whole numbers.
    These are numbers that have no decimal part.
    You can store both positive and negative numbers.

    The integer type is also used when you want to store money,
    without loosing any precision.

*/

-------------------------------------------------------------------------------

-- CREATE a table

-- `PRIMARY KEY` is a column constraint (also called a column modifier).
-- A column constraint is used to set a strict rule for what kind of data
-- can be stored in a column.

-- `INTEGER PRIMARY KEY` tells SQLite that each row in the user_info table 
-- must always have a unique INTEGER value in the user_id column.

-- SQLite does not have a boolean data type. 
-- It understands `false` and `true` but it will store them 
-- as INTEGER values.

-- false = 0
-- true = 1
CREATE TABLE user_info(
    user_id INTEGER PRIMARY KEY,
    has_premium INTEGER
) STRICT;

-- The keyword `STRICT` is a table modifier.
-- This makes SQLite reject any insertation of data into a column that does
-- not match the data type that you specified when creating the table.

-------------------------------------------------------------------------------

-- Insert six rows of data

-- Also note that SQLITE does not care about the casing of false and true.
-- As long as they are spelled correctly, SQLite will convert them.

INSERT INTO user_info (user_id, has_premium)
VALUES 
    (112, 0),
    (208, false),
    (502, FALSE),
    (754, 1),
    (811, true),
    (920, TRUE)
;

-------------------------------------------------------------------------------

-- View the values in ascending order (lowest user_id at the top)

SELECT * FROM user_info
ORDER BY user_id ASC;

/*
    +---------+-------------+
    | user_id | has_premium |
    +---------+-------------+
    | 112     | 0           |
    | 208     | 0           |
    | 502     | 0           |
    | 754     | 1           |
    | 811     | 1           |
    | 920     | 1           |
    +---------+-------------+
    6 rows in set
    Time: 0.004s
*/

-- This shows that the query returned 6 rows
-- And that it took 0.004 seconds for SQLite to complete this query.

-------------------------------------------------------------------------------

-- To delete a table

DROP TABLE user_info;

-------------------------------------------------------------------------------
