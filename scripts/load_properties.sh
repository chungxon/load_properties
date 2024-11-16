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
    
    if [ -z "${file}" ]; then
        echo "Error: File path is required" >&2
        return 1
    fi
    
    if [ ! -f "${file}" ]; then
        echo "Error: File '${file}' not found" >&2
        return 1
    fi
    
    return 0
}

# Load properties from a file and set them as global variables
# If it has duplicate attributes, get the last one
# Input: File name and an optional prefix
# Output: None
# Exit codes:
#   0: Success
#   1: File not found or invalid input
# Usage: Call the function with the properties file and an optional prefix
#   loadProperties <file> [prefix] [separator] [trim_value]
# Example usage: loadProperties examples/example.properties "APP_"
# Example accessing the properties: echo "App Name: $APP_appName"
function loadProperties() {
    local file=$1
    local prefix=${2:-""}
    local separator=${3:-"="}
    local trim_value=${4:-"false"}

    # Validate inputs
    validate_inputs "${file}" || return 1

    debug "Loading properties from '${file}'"
    debug "Using prefix: '${prefix}'"
    debug "Using separator: '${separator}'"
    debug "Trim values: ${trim_value}"

    # Read the file line by line. Include the last line with no new line
    while IFS="${separator}" read -r prop_key value || [ -n "$prop_key" ]; do
        # Skip empty lines and comments
        if [[ -z "${prop_key}" || "${prop_key}" == "#"* ]]; then
            continue
        fi

        # Clean key by trimming whitespace
        prop_key=$(echo "$prop_key" | sed 's/^[ \t]*//;s/[ \t]*$//')

        # Clean up key: replace invalid characters with underscores
        local key=${prop_key//[!a-zA-Z0-9_]/_}

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

        # Ensure keys starting with digits are prefixed with '_'
        if [[ "${prefix}${key}" =~ ^[0-9].* ]]; then
            key="_${key}"
        fi

        # # Use 'declare' for better variable management, only for bash
        # declare -g ${prefix}${key}="${value}"

        debug "Setting property '${prefix}${key}' to '${value}'"

        # Properly escape and assign the variable with eval
        eval "${prefix}${key}=\${value}"
    done < "${file}"

    return 0
}
