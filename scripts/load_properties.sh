#!/bin/sh

# Load properties from a file and set them as global variables
# If it has duplicate attributes, get the last one
# Input: File name and an optional prefix
# Output: None
# Exit codes:
#   0: Success
#   1: File not found
# Usage: Call the function with the properties file and an optional prefix
#   loadProperties "$1" "$2"
# Example usage: loadProperties examples/example.properties
# Example accessing the properties: echo "App Name: $appName"
function loadProperties() {
  local fileName=$1
  local prefixKey=$2

  if [ ! -f "${fileName}" ]; then
    echo "File ${fileName} not found!"
    return 1
  fi

  # Read the file line by line. Inclue the last line with no new line
  while IFS='=' read -r origKey value || [ -n "$origKey" ]; do
    # Skip empty lines and comments
    if [[ -z "${origKey}" || "${origKey}" == "#"* ]]; then
      continue
    fi

    # Clean up key: replace invalid characters with underscores
    local key=${origKey}
    key=${key//[!a-zA-Z0-9_]/_}

    # Ensure keys starting with digits are prefixed with '_'
    if [[ "${prefixKey}${key}" =~ ^[0-9].* ]]; then
      key="_${key}"
    fi

    # # Use 'declare' for better variable management, only for bash
    # declare -g ${prefixKey}${key}="${value}"

    # Properly escape and assign the variable with eval
    eval "${prefixKey}${key}=\${value}"
  done < "${fileName}"

  return 0
}
