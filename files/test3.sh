#!/usr/bin/env dash

# Tests for commit

SCRIPT_DIR=$(dirname "$0")
. "$SCRIPT_DIR/testHelper.sh"

chmod +x *

# add, commit, no change, commit
test3_1(){
    program=$1
    args=$2
    setOutput "$program" test3_1
   {
    $init
    echo 1 > a
    $add a
    $commit -m message1
    touch a
    $add a
    $commit -m message2
   } > "$output" 2>&1

   cat $output
   removeTestFiles a
    
}

tests="test3_1"

runTests "$tests"