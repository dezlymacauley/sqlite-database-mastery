# SQLite Database Backup Guide
_______________________________________________________________________________

## Method 1

First create a directory where your backup file will be created:

```sh
mkdir $HOME/database-backups
```
_______________________________________________________________________________

Use the built-in backup command `.backup` from the `sqlite3` cli

```sh
sqlite3 path_to_database_file.sqlite \
".backup where-to-save-the-backup/name_backup.sqlite"
```

E.g.
```sh
sqlite3 .sqlite-databases/sqlite_database_mastery.sqlite \
".backup $HOME/database-backups/sdm_backup_10_mar_2026.sqlite"
```
_______________________________________________________________________________

Note: 

When using this method your database WILL not be locked! 

This means that if there changes being made to the database after 
the backup has already started and is in progress, 
will not be reflected.

_______________________________________________________________________________

## Method 2 - A compressed backup

```sh
BACKUP_PATH="where-to-save-the-backup"

sqlite3 path_to_database_file.sqlite \
"vacuum into '$BACKUP_PATH';"
```

E.g.
```sh
BACKUP_PATH="$HOME/database-backups/sdm_compressed_backup_10_mar_2026.sqlite"

sqlite3 .sqlite-databases/sqlite_database_mastery.sqlite \
"VACUUM INTO '$BACKUP_PATH';"
```
_______________________________________________________________________________

## Tip 1: Avoid copying the file manually

Always use one of the built-in methods to avoid data corruption.
_______________________________________________________________________________

## Tip 2: Never delete the `WAL` or the `shm` file

This is data that has not been commited to you main database yet.

_______________________________________________________________________________

## Tip 3: Never open the database file manually

Always use a cli tool like `sqlite3` or `litecli`

_______________________________________________________________________________
