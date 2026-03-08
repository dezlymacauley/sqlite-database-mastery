/*
    ABOUT: NULL

    Null is a data type that is used to indicate that a cell
    does not contain any value.

    You can also chain the keyword `NOT`, which is a logical operator,
    to NULL like this: 
    `NOT NULL` to ensure that all rows must have data for a specific
    column.
*/

-------------------------------------------------------------------------------

CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    age INTEGER NOT NULL,
    email TEXT NOT NULL UNIQUE,
    confirmed_email INTEGER,
    recovery_phone TEXT UNIQUE,
    recovery_email TEXT UNIQUE,
    CHECK (recovery_email IS NULL OR recovery_email != email)
);

-------------------------------------------------------------------------------

INSERT INTO users (
    name, age, email, confirmed_email, 
    recovery_phone, recovery_email
) VALUES
    ('Alice', 25, 'alice@gmail.com', 1, '0821234567', 'alice02@gmail.com'),
    ('Bob', 30, 'bob@gmail.com', NULL, NULL, 'bob02@gmail.com'),
    ('Carol', 22, 'carol@gmail.com', 0, '0839876543', NULL),
    ('Dave', 28, 'dave@gmail.com', 1, NULL, NULL)
;

-- Alice: has both recovery methods
-- Bob: only recovery email
-- Carol: only recovery phone
-- Dave: no recovery methods

-------------------------------------------------------------------------------

-- A query to view users with both recovery enabled

SELECT 
    name, email, recovery_phone, recovery_email
FROM users
WHERE recovery_phone IS NOT NULL AND recovery_email IS NOT NULL;

/*

+-------+-----------------+----------------+-------------------+
| name  | email           | recovery_phone | recovery_email    |
+-------+-----------------+----------------+-------------------+
| Alice | alice@gmail.com | 0821234567     | alice02@gmail.com |
+-------+-----------------+----------------+-------------------+

*/

-------------------------------------------------------------------------------

-- A query to view users with no recovery methods enabled

SELECT 
    name, email, recovery_phone, recovery_email
FROM users
WHERE recovery_phone IS NULL AND recovery_email IS NULL;

/*
    +------+----------------+----------------+----------------+
    | name | email          | recovery_phone | recovery_email |
    +------+----------------+----------------+----------------+
    | Dave | dave@gmail.com | <null>         | <null>         |
    +------+----------------+----------------+----------------+
*/

-------------------------------------------------------------------------------
