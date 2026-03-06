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
# The Python virtual environment
# This is where uv will install the Python version required for the project
# and the project dependencies
.venv/

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

### Add environment variables to your `mise.toml` file

Add this to the end of the file
```sh
[env]
SQLITE_DB_DIR = "sqlite-databases"
LITECLI_CONFIG = "litecli.ini"
```

Note: 
- For obvious security reasons, don't put any sensitive data like
passwords in your `mise.toml` or in any file in the repo.

_______________________________________________________________________________

## Setup a Python virtual environment
_______________________________________________________________________________

### Decide on what version of `Python` you want your project use

Note: 
- I will only be using `mise` to check. 
- Python should NOT be installed by `mise` when setting up a project.
- Use the `uv` that was installed by mise to setup Python.

Use this command check what is the latest version of Python available to
download on your current mise toolchain.
```sh
mise latest python
```

To view a list of available Python versions use this command:
```sh
mise ls-remote python
```
_______________________________________________________________________________

For the guide I have chosen Python version 3.14.2

Initialize the project
```sh
uv init --bare -p 3.14.3
```

This will create a `pyproject.toml` file

_______________________________________________________________________________

Open the `pyproject.toml` file and change `>=` to `==`

So this line:
```toml
requires-python = ">=3.14.3"
```

Should be changed to 
```toml
requires-python = "==3.14.3"
```
_______________________________________________________________________________

Create a .python-version file:

```sh
touch .python-version
```

Add your python version to the file:
```sh
echo 3.14.3 > .python-version
```
_______________________________________________________________________________

Please note:

At this point, your project is NOT using the Python version that is listed 
in your `pyproject.toml` or your `.python-version`

You can confirm this by running `which python`

If you get something like this:
```
/usr/bin/python
```

That means that your project is using the Python version 
of your operating system.

This is because you have not created and activated 
a Python virtual environment.

_______________________________________________________________________________

Run this command to remind yourself of what Python version you chose:
```sh
cat .python-version
```

Create a Python virtual environment.
```sh
uv venv -p 3.14.3
```

This is where `uv` will install the Python version required for this project.

When you install project dependencies later, 
they will also be installed in this directory.
_______________________________________________________________________________

The last step to this:
```sh
uv sync
```

Then exit the project directory
```sh
cd ..
```

And re-enter the project directory
```sh
cd sqlite-database-mastery
```

Now run this command:
```sh
which python
```

If you see this at the end of your path,
then that means that your project is using the virtual enviroment 
that was set by uv.
```
.venv/bin/python
```
_______________________________________________________________________________

### Install LiteCLI

You can check what is the latest version of LiteCLI by checking this link:
```
https://pypi.org/project/litecli/
```

Use uv to install LiteCLI as a development dependency
```sh
uv add --dev litecli==1.17.1
```

I chose LiteCLI version 1.17.1
_______________________________________________________________________________
