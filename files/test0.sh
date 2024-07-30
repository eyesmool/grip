#!/usr/bin/env dash

SCRIPT_DIR=$(dirname "$0")
. "$SCRIPT_DIR/testHelper.sh"

chmod +x *

test01() {
    program=$1
    args=$2
    setOutput "$program" test01
   {
    ls -d .grip;
    $init
    ls -d .grip;
    $init
   } 2> "$output"

   cat $output
}

test02() {
    setOutput "$program" test02
    echo $init 
    echo $add
    echo $commit
    {
        $init;
        echo line 1 > a;
        echo hello world >b;
        $add a b
        $commit -m 'first commit'


    } 2>> "$output"

    removeTestFiles a b
}
tests="test01 test02"

for test in $tests; do
    echo "${pink_colour}"
    echo "----------------------------------------"
    echo "////////////////////////////////////////"
    echo "//////            $test           //////"
    echo "////////////////////////////////////////"
    echo "----------------------------------------"
    echo "${reset_colour}"
    for program in "$IMPLEMENTATION" "$REFERENCE"; do
        clear
        echo "${orange_colour}Running $program${reset_colour}"
        $test "$program" "$args"
    done
        compareOutputs "$test""_imp_output.txt" "$test""_ref_output.txt"
        removeTestFiles "$test""_imp_output.txt" "$test""_ref_output.txt"
done

clear
