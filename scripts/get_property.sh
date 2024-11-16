#!/bin/sh

# Debug mode flag
DEBUG=${DEBUG:-false}

# Debug logging function
debug() {
    if [ "${DEBUG}" = "true" ]; then
        echo "[DEBUG] $1" >&2
    fi
}

# Input validation function
validate_inputs() {
    local file=$1
    local key=$2
    
    if [ -z "${file}" ]; then
        echo "Error: File path is required" >&2
        return 1
    fi
    
    if [ -z "${key}" ]; then
        echo "Error: Property key is required" >&2
        return 1
    fi
    
    if [ ! -f "${file}" ]; then
        echo "Error: File '${file}' not found" >&2
        return 1
    fi
    
    return 0
}

# Get the first match property from a file and return the value
# Input: File name and property key
# Output: Property value
# Exit codes:
#   0: Property found and returned value
#   1: File not found or invalid input
#   2: Property not found and returned empty string
# Usage: Call the function with the properties file and the property key
#   getProperty <file> <key> [separator] [trim_value]
# Example usage: appName=$(getProperty examples/example.properties appName)
# And accessing the property: echo "App Name: $appName"
getProperty() {
    local file=$1
    local key=$2
    local separator=${3:-"="}
    local trim_value=${4:-"false"}
    
    # Validate inputs
    validate_inputs "${file}" "${key}" || return 1
    
    debug "Reading property '${key}' from file '${file}'"
    debug "Using separator: '${separator}'"
    
    while IFS="${separator}" read -r prop_key value || [ -n "$prop_key" ]; do
        # Skip empty lines and comments
        if [[ -z "${key}" || "${key}" == "#"* ]]; then
          continue
        fi

        # Clean key by trimming whitespace
        prop_key=$(echo "$prop_key" | sed 's/^[ \t]*//;s/[ \t]*$//')

        # # Trim leading/trailing spaces without using xargs (which alters special characters)
        # prop_key=$(echo "$prop_key" | xargs)
        
        # Remove any inline comments from the value
        # Preserve everything up to the first # as the value, unless it's inside quotes
        if [[ "${value}" =~ ^[\'\"](.*)[\'\"]$ ]]; then
            # If value is quoted, remove surrounding quotes only
            value=${BASH_REMATCH[1]}
        else
            # Strip out the inline comment that starts with #, but preserve part before #
            value=$(echo "$value" | sed 's/[ \t]* #.*//')
        fi

        # Trim value if requested
        if [ "${trim_value}" = "true" ]; then
            value=$(echo "$value" | sed 's/^[ \t]*//;s/[ \t]*$//')
        fi

        # If the key matches the requested parameter, print the value and exit
        if [ "${prop_key}" = "${key}" ]; then
            debug "Found value: '${value}'"
            echo "${value}"
            return 0
        fi
    done < "${file}"
    
    debug "Property '${key}' not found"
    echo ""
    return 2
}

# # This solution will be slow when reading lots of properties
# function getProperty() {
#     local file=$1
#     local key=$2
#     local separator=${3:-"="}
#     local trim_value=${4:-"false"}

#     # Validate inputs
#     validate_inputs "${file}" "${key}" || return 1

#     debug "Reading property '${key}' from file '${file}'"
#     debug "Using separator: '${separator}'"
    
#     # # Use grep to find the first line with the key, and cut to extract the value
#     # local value=$(grep "^${key}${separator}" "${file}" | head -n 1 | cut -d'${separator}' -f2)

#     # Use grep to find the first line with the key, and cut from the first occurrence of the equal sign
#     local value=$(grep "^${key}${separator}" "${file}" | head -n 1 | sed "s/^[^${separator}]*${separator}//")

#     # Remove any inline comments from the value
#     # Preserve everything up to the first # as the value, unless it's inside quotes
#     if [[ "${value}" =~ ^[\'\"](.*)[\'\"]$ ]]; then
#         # If value is quoted, remove surrounding quotes only
#         value=${BASH_REMATCH[1]}
#     else
#         # Strip out the inline comment that starts with #, but preserve part before #
#         value=$(echo "$value" | sed 's/[ \t]* #.*//')
#     fi

#     if [[ "${trim_value}" == "true" ]]; then
#         value=$(echo "$value" | sed 's/^[ \t]*//;s/[ \t]*$//')
#     fi

#     if [ -z "${value}" ]; then
#         debug "Property '${key}' not found"
#         echo ""
#         return 2
#     fi

#     # Return the value with proper escaping (prevent special character issues)
#     debug "Found value: '${value}'"
#     echo "$value"
#     return 0
# }
