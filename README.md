# Load Properties Script
This helpful script is used to read properties from a file for use in another script

# Usage

## 1. `loadProperties` function
- Call the function with the properties file and an optional prefix to load all properties into variables
- The prefix will be prepended to all variable names to avoid naming conflicts

    ```bash
    loadProperties <file> [prefix]
    ```
- Example usage: `loadProperties examples/example.properties "app_"`
- Example accessing the properties: `echo "App Name: $app_appName"`

## 2. `getProperty` function
- Call the function with the properties file and property key to get a single property value
- Optional parameters for separator (default "=") and whether to trim whitespace (default false)

    ```bash
    getProperty <file> <key> [separator] [trim_value]
    ```
- Example usage: `appName=$(getProperty examples/example.properties appName)`
- Example with options: `value=$(getProperty config.ini key ":" true)`

# Demo

![image](https://github.com/user-attachments/assets/4b641531-f7af-41cd-a455-3ffe892edd04)
