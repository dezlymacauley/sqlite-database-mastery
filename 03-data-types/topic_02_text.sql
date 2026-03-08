/*
    ABOUT: TEXT

    This data type is used for storing text (aka strings).
    In SQLite text values should always be wrapped in single quotes,
    NOT double quotes like in programming languages.
    
    ---------------------------------------------------------------------------
 
    -- SECTION: In SQLite the `TEXT` data type is used to store dates

    SQLite does not have a specific data type for storing dates,
    so dates are stored as TEXT in `ISO-8601 format`

    The syntax is:
    YYYY-MM-DDTHH:MM:SSZ
   
    `YYYY` = The year. E.g. 2026
    `MM` = The month. E.g. 03 is March
    `DD` = The day of the month. E.g. 8

    `T` = This is just a marker to separate the date from the time,
    the next values after the `T` marker are all related to the current time.

    `HH` is hour
    `MM` is minutes
    `SS` is seconds

    `Z` = The Z marker indicates that the timestamp is in `Zulu time`,
    aka `UTC+0`. That is Cordinated Universal Time with zero offset.
    This ensures that timestamps are consistent accross the database 
    when working with timestamps from different countries.

    ---------------------------------------------------------------------------
   
    -- SECTION: Date functions

    SQLite has built-in functions for working with dates.
    
    ---------------------------------------------------------------------------

    -- SUB_SECTION: `strftime()`
   
    This is the `string-format time` function.
    It is used to get the current time in ISO-8601 format. 

    SELECT strftime('%Y-%m-%dT%H:%M:%SZ','now');

    The output will look like this:

    +--------------------------------------+
    | strftime('%Y-%m-%dT%H:%M:%SZ','now') |
    +--------------------------------------+
    | 2026-03-08T06:51:51Z                 |
    +--------------------------------------+

    ---------------------------------------------------------------------------
    
    -- SUB_SECTION: If you only wanted the date

    SELECT strftime('%Y-%m-%d','now');

    The output will look like this:

    +----------------------------+
    | strftime('%Y-%m-%d','now') |
    +----------------------------+
    | 2026-03-08                 |
    +----------------------------+

    ---------------------------------------------------------------------------
    
    -- SUB_SECTION: If you only wanted the year

    SELECT strftime('%Y','now');

    The output will look like this:

    +----------------------+
    | strftime('%Y','now') |
    +----------------------+
    | 2026                 |
    +----------------------+

    ---------------------------------------------------------------------------

    -- SUB_SECTION: If you only wanted the month

    SELECT strftime('%m','now');

    The output will look like this:
    +----------------------+
    | strftime('%m','now') |
    +----------------------+
    | 03                   |
    +----------------------+
    
    ---------------------------------------------------------------------------

    -- SUB_SECTION: If you only wanted the day

    SELECT strftime('%d','now');

    The output will look like this:
    +----------------------+
    | strftime('%d','now') |
    +----------------------+
    | 08                   |
    +----------------------+
    
    ---------------------------------------------------------------------------
   

    ---------------------------------------------------------------------------

*/

-------------------------------------------------------------------------------
