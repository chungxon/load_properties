# Load Properties Script
This helpful script is used to read properties from a file for use in another script

# Usage

## `loadProperties` function
- Call the function with the properties file and an optional prefix

    ```bash
    loadProperties "$1" "$2"
    ```
- Example usage: loadProperties examples/example.properties
- Example accessing the properties: echo "App Name: $appName"