/*
    ABOUT: Composite Indexes

    This is when you have an index that is placed on multiple columns.

*/

-------------------------------------------------------------------------------

-- This is how to declare a composite index
CREATE INDEX composite_index_fname_lname_bday 
on users (first_name, last_name, birthday);

-- TIP: When declaring the columns, 
-- declare them in the order that they appear in the table.

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

EXPLAIN QUERY PLAN
SELECT * FROM users WHERE last_name = 'Dezly';



-------------------------------------------------------------------------------
