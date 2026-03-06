#!/usr/bin/env bash
#MISE description="Connect to a database using litecli"
#MISE quiet=true

litecli \
--liteclirc "$LITECLI_CONFIG" \
--database "$SQLITE_DB"
