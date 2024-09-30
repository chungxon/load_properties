#!/bin/sh
set -e

# Include the script
. scripts/get_property.sh

# # Download the script
# curl -s https://raw.githubusercontent.com/chungxon/load_properties/refs/heads/master/scripts/get_property.sh -o /tmp/get_property.sh

# # Source the downloaded script
# source /tmp/get_property.sh

# Define configuration file
configFile="examples/example.properties"
echo "Config file: ${configFile}\n"

echo "========================================\n"

# Load app name
echo "Load app name from ${configFile}...\n"
appName=$(getProperty ${configFile} appName)
echo "App name: ${appName}\n"

echo "========================================\n"

# Load app icon
echo "Load app icon from ${configFile}...\n"
appIcon=$(getProperty ${configFile} appIcon)
echo "App icon: ${appIcon}\n"
