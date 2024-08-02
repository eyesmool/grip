#!/usr/bin/env dash

# Tests for `show`

SCRIPT_DIR=$(dirname "$0")
. "$SCRIPT_DIR/testHelper.sh"


chmod +x *
# SHOW ME THE MONEY(show me the file in the index)
test2_1(){
    program=$1
    args=$2
    setOutput "$program" test2_1
   {
    $init
    echo SHOW ME THE MONEY > a
    $add a
    $show :a
   } > "$output" 2>&1

   cat $output
   removeTestFiles a
}

# Show the 0th commit
test2_2(){
    program=$1
    args=$2
    setOutput "$program" test2_2
   {
    $init
    echo line 1 > a
    echo hello world >b
    $add a b
    $commit -m 'first commit'
    # ls -aR .grip
    $show 0:a
    $show 0:b
   } > "$output" 2>&1

   cat $output
   removeTestFiles a
}

test2_3(){
    program=$1
    args=$2
    setOutput "$program" test2_3
   {
    $init
    echo 1 > a
    $add a
    echo 2 > a
    $commit -m message
    echo 3 > a
    $show 0:a
    $show :a
   } > "$output" 2>&1

   cat $output
   removeTestFiles a
}
# Tests show errors
test2_4() {
    program=$1
    args=$2
    setOutput "$program" test2_4
   {
    $init
    echo line 1 > a
    echo hello world > b
    $add a b
    $commit -m "first commit"
    $show :c
    $show 0:c
    $show 2:a
   } > "$output" 2>&1

   cat $output
   removeTestFiles a
}

tests="test2_1 test2_2 test2_3 test2_4"

runTests "$tests"