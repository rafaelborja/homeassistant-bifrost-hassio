#!/bin/bash

echo "Starting Bifrost Configuration..."
chmod +x /config/bifrost/configure.sh
/config/bifrost/configure.sh

echo "Starting Bifrost..."
exec /app/bifrost
