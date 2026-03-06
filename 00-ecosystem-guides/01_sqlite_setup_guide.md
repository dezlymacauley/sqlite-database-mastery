# SQLite Setup Guide
_______________________________________________________________________________

## Part 1: System Configuration

- Install `mise`

_______________________________________________________________________________

## Part 2: Project Configuration

Create the project directory
```sh
mkdir sqlite-database-mastery
```

Enter the project directory
```sh
cd sqlite-database-mastery
```

For the rest of this guide, all commands must be run from this directory.
_______________________________________________________________________________

Create a directory for your databases
```sh
mkdir sqlite-databases
```
_______________________________________________________________________________

Create a `.gitignore` file

```sh
touch .gitignore
```

Add this to the file:
```gitignore
# SQLite Database Files
sqlite-databases/
```
_______________________________________________________________________________

### Decide on what version of `SQLite` you want your project use

Use this command check what is the latest version of SQLite available to
download on your current mise toolchain.
```sh
mise latest sqlite
```

To view a list of available SQLite versions use this command:
```sh
mise ls-remote sqlite
```
_______________________________________________________________________________

### Set the SQLite version for your project

I have decided to use SQLite version 3.51.2
```sh
mise use sqlite@3.51.2
```
_______________________________________________________________________________

_______________________________________________________________________________
