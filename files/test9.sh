#!/usr/bin/env dash

# Tests for show error

SCRIPT_DIR=$(dirname "$0")
. "$SCRIPT_DIR/testHelper.sh"

chmod +x *

test9_1(){
    program=$1
    args=$2
    setOutput "$program" test9_1
   {
    $init
    echo gyatt > a
    $add a
    $show 0:a
   } > "$output" 2>&1

   cat $output
   removeTestFiles a b c d
}

test9_2(){
    program=$1
    args=$2
    setOutput "$program" test9_2
   {
    $show 0:a
   } > "$output" 2>&1

   cat $output
   removeTestFiles a b c d
}



for i in $(seq 1 2); do
    tests="$tests test9_$i"
done
runTests "$tests"