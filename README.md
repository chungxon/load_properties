# Load Properties Script
This helpful script is used to read properties from a file for use in another script

# Usage

## 1. `loadProperties` function
- Call the function with the properties file and an optional prefix

    ```bash
    loadProperties "$1" "$2"
    ```
- Example usage: loadProperties examples/example.properties
- Example accessing the properties: echo "App Name: $appName"

## 2. `getProperty` function
- Call the function with the properties file and the property key

    ```bash
    getProperty "$1" "$2"
    ```
- Example usage: appName=$(getProperty examples/example.properties appName)
- Example accessing the property: echo "App Name: $appName"
