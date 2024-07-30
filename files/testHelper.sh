#!/usr/bin/env dash
reset_colour="\e[0m"
red_colour="\e[31m"
pink_colour="\e[38;5;207m"
green_colour="\e[32m"
orange_colour="\e[38;5;208m"
IMPLEMENTATION="./grip"
REFERENCE="2041 grip"

REF_INIT="2041 grip-init"

IMP_INIT="./grip-init.py"


clear() {
    if [ -d ".grip" ]; then
        rm -R .grip/
        echo "${pink_colour}🗑️🗑️🗑️Clearing existing .grip folder🗑️🗑️🗑️\e[0m"
    fi
}

setOutput() {
    program=$1
    test=$2
    if [ "$program" = "$IMPLEMENTATION" ]; then
        output="$test""_imp_output.txt"
        init="2041 grip-init"
        add="2041 grip-add"
        commit="2041 grip-commit"
    elif [ "$program" = "$REFERENCE" ]; then
        output="$test""_ref_output.txt"
        init="./grip-init.py"
        add="./grip-add.py"
        commit="./grip-commit.py"
    fi
}

removeTestFiles() {
    for file in "$@"; do
        if [ -f "$file" ]; then
            rm -R -v "$file"
        fi
    done
}

compareOutputs() {
    output1=$1
    output2=$2
    diffOutput=$(diff "$output1" "$output2")
    echo "${red_colour}Message from compareOutputs${reset_colour}"
    case $? in
        0)
        echo "Files are identical."
        ;;
        1)
        echo "Files differ."
        ;;
        2)
        echo "Error occurred with diff."
        ;;
    esac
    if [ -n "$diffOutput" ]; then
        echo "${red_colour} failed ❌ $test${reset_colour}" >&2
        echo "${red_colour}==========ERROR MESSAGE FROM DIFF=========="
        echo "$diffOutput${reset_colour}"
        clear
        removeTestFiles "$output1" "$output2"
        exit 1
    elif [ "$diffOutput" = 2 ]; then
        echo "Trouble"
        echo "$diffOutput${reset_colour}"
        exit 1
    else
        echo "${green_colour}========$test passed!========${reset_colour}"
    fi
}