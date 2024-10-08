#!/bin/sh
# set +e

red=$(tput setaf 1)
green=$(tput setaf 2)
none=$(tput sgr0)

# Include the script
. scripts/load_properties.sh

# # Download the script
# curl -s https://raw.githubusercontent.com/chungxon/load_properties/refs/heads/master/scripts/load_properties.sh -o /tmp/load_properties.sh

# # Source the downloaded script
# source /tmp/load_properties.sh

#=============================================================================#
# Load properties from example.properties with prefix
echo "Load properties from example.properties with prefix..."
loadProperties examples/example.properties test_

# echo "appName='${test_appName}'"
# echo "appIcon='${test_appIcon}'"
# echo "a='${test_a}'"
# echo "b='${test_b}'"
# echo "c='${test_c}'"
# echo "d='${test_d}'"
# echo "e='${test_e}'"
# echo "f='${test_f}'"
# echo "g='${test_g}'"
# echo ".@a%^='${test___a__}'"
# echo "a1='${test_a1}'"
# echo "1a='${test_1a}'"
# echo "database.name='${test_database_name}'"
# echo "X='${test_X}'"

# Test loading properties file
if [ "${test_appName}" != "App Name" ]; then
    echo "${red}Error: Property 'appName' is not 'App Name'!${none}"
    exit 1
fi
if [ "${test_appIcon}" != "assets/icons/app_icon.png" ]; then
    echo "${red}Error: Property 'appIcon' is not 'assets/icons/app_icon.png'!${none}"
    exit 1
fi
if [ "${test_a}" != "override value" ]; then
    echo "${red}Error: Property 'a' is not 'override value'!${none}"
    exit 1
fi
if [ "${test_b}" != "what about \`!@#$%^&*()_+[]\?" ]; then
    echo "${red}Error: Property 'b' is not 'what about \`!@#$%^&*()_+[]\?"${none}!
    exit 1
fi
if [ "${test_c}" != "\${a} no expansion" ]; then
    echo "${red}Error: Property 'c' is not '\${a} no expansion'!${none}"
    exit 1
fi
if [ "${test_d}" != "another = (equal sign)" ]; then
    echo "${red}Error: Property 'd' is not 'another = (equal sign)'!${none}"
    exit 1
fi
if [ "${test_e}" != "     5 spaces front and back     " ]; then
    echo "${red}Error: Property 'e' is not '     5 spaces front and back     '!${none}"
    exit 1
fi
if [ "${test_f}" != "" ]; then
    echo "${red}Error: Property 'f' is not ''!${none}"
    exit 1
fi
if [ "${test_g}" != "" ]; then
    echo "${red}Error: Property 'g' is not ''!${none}"
    exit 1
fi
if [ "${test___a__}" != "who named this???" ]; then
    echo "${red}Error: Property '.@a%^' is not 'who named this???'!${none}"
    exit 1
fi
if [ "${test_a1}" != "A-ONE" ]; then
    echo "${red}Error: Property 'a1' is not 'A-ONE'!${none}"
    exit 1
fi
if [ "${test_1a}" != "ONE-A" ]; then
    echo "${red}Error: Property '_1a' is not 'ONE-A'!${none}"
    exit 1
fi
if [ "${test_database_name}" != "test_database" ]; then
    echo "${red}Error: Property 'database.name' is not 'test_database'!${none}"
    exit 1
fi
if [ "${test_X}" != "lastLine with no new line!" ]; then
    echo "${red}Error: Property 'X' is not 'lastLine with no new line!'!${none}"
    exit 1
fi
echo "${green}✅ Properties with prefix loaded successfully!${none}"

#=============================================================================#
# Load properties from example.properties
echo "Load properties from example.properties..."
loadProperties examples/example.properties

# echo "appName='${appName}'"
# echo "appIcon='${appIcon}'"
# echo "a='${a}'"
# echo "b='${b}'"
# echo "c='${c}'"
# echo "d='${d}'"
# echo "e='${e}'"
# echo "f='${f}'"
# echo "g='${g}'"
# echo ".@a%^='${___a__}'"
# echo "a1='${a1}'"
# echo "1a='${_1a}'"
# echo "database.name='${database_name}'"
# echo "X='${X}'"

# Test loading properties file
if [ "${appName}" != "App Name" ]; then
    echo "${red}Error: Property 'appName' is not 'App Name'!${none}"
    exit 1
fi
if [ "${appIcon}" != "assets/icons/app_icon.png" ]; then
    echo "${red}Error: Property 'appIcon' is not 'assets/icons/app_icon.png'!${none}"
    exit 1
fi
if [ "${a}" != "override value" ]; then
    echo "${red}Error: Property 'a' is not 'override value'!${none}"
    exit 1
fi
if [ "${b}" != "what about \`!@#$%^&*()_+[]\?" ]; then
    echo "${red}Error: Property 'b' is not 'what about \`!@#$%^&*()_+[]\?"${none}!
    exit 1
fi
if [ "${c}" != "\${a} no expansion" ]; then
    echo "${red}Error: Property 'c' is not '\${a} no expansion'!${none}"
    exit 1
fi
if [ "${d}" != "another = (equal sign)" ]; then
    echo "${red}Error: Property 'd' is not 'another = (equal sign)'!${none}"
    exit 1
fi
if [ "${e}" != "     5 spaces front and back     " ]; then
    echo "${red}Error: Property 'e' is not '     5 spaces front and back     '!${none}"
    exit 1
fi
if [ "${f}" != "" ]; then
    echo "${red}Error: Property 'f' is not ''!${none}"
    exit 1
fi
if [ "${g}" != "" ]; then
    echo "${red}Error: Property 'g' is not ''!${none}"
    exit 1
fi
if [ "${__a__}" != "who named this???" ]; then
    echo "${red}Error: Property '.@a%^' is not 'who named this???'!${none}"
    exit 1
fi
if [ "${a1}" != "A-ONE" ]; then
    echo "${red}Error: Property 'a1' is not 'A-ONE'!${none}"
    exit 1
fi
if [ "${_1a}" != "ONE-A" ]; then
    echo "${red}Error: Property '_1a' is not 'ONE-A'!${none}"
    exit 1
fi
if [ "${database_name}" != "test_database" ]; then
    echo "${red}Error: Property 'database.name' is not 'test_database'!${none}"
    exit 1
fi
if [ "${X}" != "lastLine with no new line!" ]; then
    echo "${red}Error: Property 'X' is not 'lastLine with no new line!'!${none}"
    exit 1
fi
echo "${green}✅ Properties loaded successfully!${none}"

#=============================================================================#
# Load special properties from example.props file
echo "Load special properties from example.props..."
loadProperties examples/example.props

# echo "x='${x}'"
# echo "y='${y}'"
# echo "z='${z}'"

# Test loading props file
if [ "${x}" != "Tên app" ]; then
    echo "${red}Error: Property 'x' is not 'Tên app'!${none}"
    exit 1
fi
if [ "${y}" != "قيمة" ]; then
    echo "${red}Error: Property 'y' is not 'قيمة'!${none}"
    exit 1
fi
if [ "${z}" != "🙂" ]; then
    echo "${red}Error: Property 'z' is not '🙂'!${none}"
    exit 1
fi
echo "${green}✅ Special properties loaded successfully!${none}"

#=============================================================================#
# Load properties from example.yaml
echo "Load properties from example.yaml..."
loadProperties examples/example.yaml "" ":" true

# echo "name='${name}'"
# echo "description='${description}'"
# echo "publish_to='${publish_to}'"
# echo "version='${version}'"

# Test loading property
if [ "${name}" != "example" ]; then
    echo "${red}Error: Property 'name' is not 'example'!${none}"
    exit 1
fi
if [ "${description}" != '"A new Flutter project."' ]; then
    echo "${red}Error: Property 'description' is not '\"A new Flutter project.\"'!${none}"
    exit 1
fi
if [ "${publish_to}" != "'none'" ]; then
    echo "${red}Error: Property 'publish_to' is not ''none''!${none}"
    exit 1
fi
if [ "${version}" != "1.0.0+1" ]; then
    echo "${red}Error: Property 'b' is not '1.0.0+1"${none}!
    exit 1
fi
echo "${green}✅ Properties loaded successfully!${none}"
