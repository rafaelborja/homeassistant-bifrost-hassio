#!/bin/bash

echo "Starting Bifrost Configuration..."
mkdir -p /config/bifrost
/usr/local/bin/configure.sh

# Check debug mode
OPTIONS_FILE="/data/options.json"
DEBUG_MODE=$(jq -r '.debug // false' "$OPTIONS_FILE")

if [ "$DEBUG_MODE" = "true" ]; then
    echo "Debug mode enabled"
    export RUST_LOG=debug
else
    # Default log level if not set
    # export RUST_LOG=info 
    # Use existing default or whatever the container uses
    :
fi

echo "Starting Bifrost..."
cd /config/bifrost
exec /app/bifrost
