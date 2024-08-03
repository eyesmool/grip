#!/usr/bin/env dash

# Tests for add error

SCRIPT_DIR=$(dirname "$0")
. "$SCRIPT_DIR/testHelper.sh"

chmod +x *

test7_1(){
    program=$1
    args=$2
    setOutput "$program" test7_1
   {
    $init
    $add ligma nuts sugma balls skibidi gyatt
   } > "$output" 2>&1

   cat $output
   removeTestFiles a b c d
}

test7_2(){
    program=$1
    args=$2
    setOutput "$program" test7_2
   {
    $init
    $add
   } > "$output" 2>&1

   cat $output
   removeTestFiles a b c d
}

test7_3(){
    program=$1
    args=$2
    setOutput "$program" test7_3
   {
    $init
    touch a b d e
    $add a b c d e
   } > "$output" 2>&1

   cat $output
   removeTestFiles a b c d
}



for i in $(seq 1 3); do
    tests="$tests test7_$i"
done
runTests "$tests"