#!/bin/sh
# set +e

red=$(tput setaf 1)
green=$(tput setaf 2)
none=$(tput sgr0)

# Include the script
. scripts/get_property.sh

#=============================================================================#
# Load property from example.properties
echo "Load property from example.properties..."
appName=$(getProperty examples/example.properties appName)
appIcon=$(getProperty examples/example.properties appIcon)
a=$(getProperty examples/example.properties a)
b=$(getProperty examples/example.properties b)
c=$(getProperty examples/example.properties c)
d=$(getProperty examples/example.properties d)
e=$(getProperty examples/example.properties e)
f=$(getProperty examples/example.properties f)
g=$(getProperty examples/example.properties g)
__a__=$(getProperty examples/example.properties .@a%^)
a1=$(getProperty examples/example.properties a1)
_1a=$(getProperty examples/example.properties 1a)
database_name=$(getProperty examples/example.properties database.name)
X=$(getProperty examples/example.properties X)

# echo "appName='${appName}'"
# echo "appIcon='${appIcon}'"
# echo "a='${a}'"
# echo "b='${b}'"
# echo "c='${c}'"
# echo "d='${d}'"
# echo "e='${e}'"
# echo "f='${f}'"
# echo "g='${g}'"
# echo ".@a%^='${__a__}'"
# echo "a1='${a1}'"
# echo "1a='${_1a}'"
# echo "database.name='${database_name}'"
# echo "X='${X}'"

# Test loading property
if [ "${appName}" != "App Name" ]; then
    echo "${red}Error: Property 'appName' is not 'App Name'!${none}"
    exit 1
fi
if [ "${appIcon}" != "assets/icons/app_icon.png" ]; then
    echo "${red}Error: Property 'appIcon' is not 'assets/icons/app_icon.png'!${none}"
    exit 1
fi
if [ "${a}" != "value" ]; then
    echo "${red}Error: Property 'a' is not 'value'!${none}"
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
