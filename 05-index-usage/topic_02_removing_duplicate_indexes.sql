/*
    ABOUT: Removing duplicate indexes


    An index is considered a duplicate if it shares the same first column
    as another index.

    E.g.

    CREATE index index_email on users (email);
    CREATE index index_email_is_pro on users (email, is_pro);

    So the index called `index_email` is a duplicate of 
    the index called `indexemail_is_pro`.

    To save on disk space (a smaller database file),
    and improve the speed of writes to the database.

    You should remove the index with the least amount of columns.
    So you can delete the index called `index_email`.

    Why does this improve the speed of writes to the database?

    Remember that each index maintains a copy of some column values from
    a table in your database, so everytime you update your table, 
    each index has to be updated as well
    to keep things in sync.
*/
