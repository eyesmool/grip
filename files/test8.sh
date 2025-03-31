#!/usr/bin/env dash

# Tests for commit error

SCRIPT_DIR=$(dirname "$0")
. "$SCRIPT_DIR/testHelper.sh"

chmod +x *

test8_1(){
    program=$1
    args=$2
    setOutput "$program" test8_1
   {
    $init
    echo gyatt > a
    $add a
    $commit -m
   } > "$output" 2>&1

   cat $output
   removeTestFiles a b c d
}

test8_2(){
    program=$1
    args=$2
    setOutput "$program" test8_2
   {
    $init
    echo gyatt > a
    $add a
    $commit -m melanin
    $commit -m melanin
   } > "$output" 2>&1

   cat $output
   removeTestFiles a b c d
}

test8_3(){
    program=$1
    args=$2
    setOutput "$program" test8_3
   {
    $init
    echo gyatt > a
    $commit -m melanin
   } > "$output" 2>&1

   cat $output
   removeTestFiles a b c d
}

test8_4(){
    program=$1
    args=$2
    setOutput "$program" test8_4
   {
    $commit -m melanin
   } > "$output" 2>&1

   cat $output
   removeTestFiles a b c d
}


for i in $(seq 1 4); do
    tests="$tests test8_$i"
done
runTests "$tests"