#!/usr/bin/env dash
SCRIPT_DIR=$(dirname "$0")
. "$SCRIPT_DIR/testHelper.sh"

chmod +x *

for i in $(seq 0 5); do
    echo "${pink_colour} Running test$i.sh${reset_colour}"
    "./test$i.sh" > /dev/null
    if [ $? -eq 0 ]; then
        echo "${green_colour}Test$i.sh Passed${reset_colour}"
    else
        echo "${red_colour}Test$i.sh failed${reset_colour}"
    fi
done