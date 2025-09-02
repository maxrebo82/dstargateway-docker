#!/bin/sh

# This script starts the necessary services for the DStarGateway container.

# Start the DGW Time Server in the background
echo "Starting dgwtimeserver..."
/usr/local/bin/dgwtimeserver &

# Start the DStarGateway in the foreground
# This keeps the container running.
echo "Starting dstargateway..."
/usr/local/bin/dstargateway
