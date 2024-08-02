#!/usr/bin/env dash

# Tests for log

SCRIPT_DIR=$(dirname "$0")
. "$SCRIPT_DIR/testHelper.sh"

chmod +x *

test4_1(){
    program=$1
    args=$2
    setOutput "$program" test4_1
   {
    $init
    echo line 1 > a
    echo hello world >b
    $add a b
    $commit -m 'first commit'
    echo  line 2 >>a
    $add a
    $commit -m 'second commit'
    $log
   } > "$output" 2>&1

   cat $output
   removeTestFiles a
}

tests="test4_1"

runTests "$tests"