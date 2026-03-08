/*
    ABOUT: Counting Rows

    SQLite has a built-in aggregate function called `COUNT`

*/

-------------------------------------------------------------------------------

-- Use this to get the total number of rows in a table
SELECT COUNT(*) FROM users;

/*
    SELECT COUNT(*) FROM users;
    +----------+
    | COUNT(*) |
    +----------+
    | 989908   |
    +----------+
*/

-------------------------------------------------------------------------------
