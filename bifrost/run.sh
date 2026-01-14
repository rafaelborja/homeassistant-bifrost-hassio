#!/bin/bash

echo "Starting Bifrost Configuration..."
mkdir -p /config/bifrost
/usr/local/bin/configure.sh

echo "Starting Bifrost..."
cd /config/bifrost
exec /app/bifrost
