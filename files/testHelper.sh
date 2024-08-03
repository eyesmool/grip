#!/usr/bin/env dash
reset_colour="\e[0m"
red_colour="\e[31m"
pink_colour="\e[38;5;207m"
green_colour="\e[32m"
orange_colour="\e[38;5;208m"
IMPLEMENTATION="./grip"
REFERENCE="2041 grip"

REF_INIT="2041 grip-init"

IMP_INIT="./grip-init"


clear() {
    if [ -d ".grip" ]; then
        rm -Rf .grip/
        echo "${pink_colour}🗑️🗑️🗑️Clearing existing .grip folder🗑️🗑️🗑️\e[0m"
    fi
}

setOutput() {
    program=$1
    test=$2
    if [ "$program" = "$REFERENCE" ]; then
        output="tests/$test""_imp_output.txt"
        init="2041 grip-init"
        add="2041 grip-add"
        commit="2041 grip-commit"
        log="2041 grip-log"
        show="2041 grip-show"
        rm="2041 grip-rm"
        status="2041 grip-status"
    elif [ "$program" = "$IMPLEMENTATION" ]; then
        output="tests/$test""_ref_output.txt"
        init="./grip-init"
        add="./grip-add"
        commit="./grip-commit"
        log="./grip-log"
        show="./grip-show"
        rm="./grip-rm"
        status="./grip-status"
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
    # echo "${red_colour}Message from compareOutputs${reset_colour}"
    # case $? in
    #     0)
    #     echo "Files are identical."
    #     ;;
    #     1)
    #     echo "Files differ."
    #     ;;
    #     2)
    #     echo "Error occurred with diff."
    #     ;;
    # esac
    if [ -n "$diffOutput" ]; then
        echo "${red_colour}========$test failed========${reset_colour}" >&2
        echo "${red_colour}==========ERROR MESSAGE FROM DIFF==========" >&2
        echo "$diffOutput${reset_colour}" >&2
        clear
        removeTestFiles "$output1" "$output2"
        exit 1
    elif [ "$diffOutput" = 2 ]; then
        echo "Trouble" >&2
        echo "$diffOutput${reset_colour}" >&2
        exit 1
    else
        echo "${green_colour}========$test passed!========${reset_colour}"
    fi
}

runTests() {
    tests=$1
    testCount=0
    testFailed=0
    testPass=0
    mkdir tests
    for test in $tests; do
        echo "${pink_colour}"
        echo "----------------------------------------"
        echo "////////////////////////////////////////"
        echo "//////            $test           //////"
        echo "////////////////////////////////////////"
        echo "----------------------------------------"
        echo "${reset_colour}"
    for program in "$REFERENCE" "$IMPLEMENTATION"; do
        clear
        echo "${orange_colour}Running $program${reset_colour}"
        $test "$program" "$args"
    done
        compareOutputs "tests/$test""_imp_output.txt" "tests/$test""_ref_output.txt"
        removeTestFiles "tests/$test""_imp_output.txt" "tests/$test""_ref_output.txt"
        if [ $? -eq 0 ]; then
            testPass=$((testPass + 1))
        else
            testFailed=$((testFailed + 1))
        fi
    testCount=$((testCount + 1))
    done

    echo "${green_colour}$testPass tests out of $testCount passed${reset_colour}"
    if [ "$testFailed" -gt 0 ]; then
        echo "${red_colour}$testFailed tests failed${reset_colour}"
    fi
    clear
}