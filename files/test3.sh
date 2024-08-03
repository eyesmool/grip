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

test3_2(){
    program=$1
    args=$2
    setOutput "$program" test3_2
   {
    $init
    echo hello >a
    echo world >b
    $add a b
    $commit -m "first commit"
    echo line 2 >>a
    $commit -a -m "second commit"
    $show 0:a
    $show 1:a
    $show :a
   } > "$output" 2>&1

   cat $output
   removeTestFiles a b
}

tests="test3_1 test3_2"

runTests "$tests"