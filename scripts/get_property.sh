#!/bin/sh

# Get the first match property from a file and return the value
# Input: File name and property key
# Output: Property value
# Exit codes:
#   0: Property found and returned value
#   1: File not found
#   2: Property not found and returned empty string
# Usage: Call the function with the properties file and the property key
#   getProperty "$1" "$2"
# Example usage: appName=$(getProperty examples/example.properties appName)
# Example accessing the property: echo "App Name: $appName"
function getProperty() {
  local fileName=$1
  local paramKey=$2
  local separator=$3

  if [ ! -f "${fileName}" ]; then
    echo "File ${fileName} not found!"
    return 1
  fi

  if [ -z "${separator}" ]; then
    separator="="
  fi

  while IFS="${separator}" read -r key value || [ -n "$key" ]; do
    # Skip empty lines and comments
    if [[ -z "${key}" || "${key}" == "#"* ]]; then
      continue
    fi

    # Trim leading/trailing spaces without using xargs (which alters special characters)
    # key=$(echo "$key" | xargs)

    key=$(echo "$key" | sed 's/^[ \t]*//;s/[ \t]*$//')

    # If the key matches the requested parameter, print the value and exit
    if [[ "${key}" == "${paramKey}" ]]; then
      echo "${value}"
      # value=$(printf '%q' "$value")
      return 0
    fi
  done < "${fileName}"  # Directly read from the file without process substitution

  # echo "Parameter ${paramKey} not found in file ${fileName}."
  echo ""
  return 2
}

# # This solution will be slow when reading lots of properties
# function getProperty() {
#   local fileName=$1
#   local paramKey=$2
#   local separator=$3

#   if [ ! -f "${fileName}" ]; then
#     echo "File ${fileName} not found!"
#     return 1
#   fi

#   if [ -z "${separator}" ]; then
#     separator="="
#   fi

#   # # Use grep to find the first line with the key, and cut to extract the value
#   # local value=$(grep "^${paramKey}${separator}" "${fileName}" | head -n 1 | cut -d'${separator}' -f2)

#   # Use grep to find the first line with the key, and cut from the first occurrence of the equal sign
#   local value=$(grep "^${paramKey}${separator}" "${fileName}" | head -n 1 | sed "s/^[^${separator}]*${separator}//")

#   if [ -z "${value}" ]; then
#     # echo "Parameter ${paramKey} not found in file ${fileName}."
#     echo ""
#     return 2
#   fi

#   # Return the value with proper escaping (prevent special character issues)
#   echo "$value"
#   return 0
# }
