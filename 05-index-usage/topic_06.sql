/*
    ABOUT: Topic 06

    Indexes that share a common left prefix are duplicative.

    CREATE index email on users (email);
    CREATE index email_is_pro on users (email, is_pro);

    So the `email` index is a duplicate of the `email_is_pro` index.
*/
