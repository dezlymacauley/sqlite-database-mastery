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

### Decide on what version of `uv` you want your project use

Use this command check what is the latest version of uv available to
download on your current mise toolchain.
```sh
mise latest uv
```

To view a list of available uv versions use this command:
```sh
mise ls-remote uv
```
_______________________________________________________________________________

### Set the uv version for your project

I have decided to use uv version 0.10.8
```sh
mise use uv@0.10.8
```
_______________________________________________________________________________

### Create a `LiteCLI` config file

```sh
touch litecli.ini
```

Add this to the file:
```sh
[main]

# Hides the startup and exit message
less_chatty = True

# Show/hide the informational toolbar with function keymap at the footer.
show_bottom_toolbar = False 

# No history file
# history_file = /dev/null

prompt = "\x1b[1;38;5;134m\d\x1b[0m 🪶 \n"

# Changes the colour theme.
# I find this theme more readable since my terminal has a darak background.
syntax_style = fruity

use_local_timezone = False

# Multi-line mode allows breaking up the sql statements into multiple lines. If
# this is set to True, then the end of the statements must have a semi-colon.
# If this is set to False then sql statements can't be split into multiple
# lines. End of line (return) is considered as the end of the statement.
multi_line = True 
```
_______________________________________________________________________________

### Enable uv to automatically setup the Python virtual environment 

Add this to the end of your `mise.toml` file
```toml
[settings]
python.uv_venv_auto = true
```
_______________________________________________________________________________
