/*
    ABOUT: Cardinality and Selectivity

    Cardinality = The number of unique values in a column.
    Cardinality is used to calculate Selectivity.
    
    Selectivity is often expressed as a ratio from 0.00 to 1.00.
    It is the Cardinality divided by the number of rows in a table.

    To calculate the number of unique values in a column, use this:
    count(DISTINCT name_of_column)

    To calculate the number of rows in a table use this:
    count(*)

    Since Selectivity is a ratio from 0.00 to 1.00,
    you want to ensure that you are performing floating point division and
    not integer division.

    The easiest way to do this is to multiply both values by 1.0. 

    So the formula for Selectivity is:
    (count(DISTINCT birthday) * 1.0) / (count(*) * 1.0)

    And finally, to round the answer to 2 decimal places,
    you can use SQLite's built-in `round` function:
    round((count(DISTINCT birthday) * 1.0) / (count(*) * 1.0), 2)

    What is Selectivity used for?

    1. Selectivity is used to figure out if it is practical to place an
    index on a column.

    2. If you make a query that involves more than one column where you have
    placed a index on multiple columns, 
    Selectivity is used by SQLite to choose which of the indexes to use to
    complete the query as quickly as possible.

*/

-------------------------------------------------------------------------------

-- SECTION: How to calculate the Cardinality

SELECT count(DISTINCT birthday) FROM users;

/*
    +--------------------------+
    | count(DISTINCT birthday) |
    +--------------------------+
    | 10950                    |
    +--------------------------+
*/

-- This shows that the cardinality of the `birthday` column 
-- is 10950. That's 10950 unique birthday's.

-------------------------------------------------------------------------------

-- SECTION: How to calculate the Selectivity

-- NOTE: I'm using printf with the format specifier `%.2f` to ensure that the
-- output displayed is always two decimals.

SELECT 
   printf('%.2f', (COUNT(DISTINCT birthday)*1.0)/(COUNT(*)*1.0))
AS "Selectivity of birthday column"
FROM users;

/*
    +--------------------------------+
    | Selectivity of birthday column |
    +--------------------------------+
    | 0.01                           |
    +--------------------------------+
*/

-- Selectivity is a ratio between 0.00 and 1.00
-- Low-Selectivity means the number is closer to 0.00
-- High-Selectivity means tha the number is closer to 1.00

-- A Selectivity of 0.01 means that the column has many duplicate values, 
-- so an index may not significantly improve performance for most queries.

-- However, there are situations where you would place an index 
-- with a low Selectivity if you have a query that is looking for a very
-- specific set of values in that column.

-- E.g. Like this expression index I created, 
-- which can be useful for birthday reminders and marketing campaigns.

/*
    CREATE INDEX index_birthday_month_day 
    ON users (strftime('%m-%d', birthday));
*/

-------------------------------------------------------------------------------
