#!/usr/bin/env dash

# Tests for add

SCRIPT_DIR=$(dirname "$0")
. "$SCRIPT_DIR/testHelper.sh"

chmod +x *

# test add with no previous init
test01() {
    program=$1
    args=$2
    setOutput "$program" test01
   {
    $add
   } > "$output" 2>&1

   cat $output
}

# test add with no args
test02() {
    program=$1
    args=$2
    setOutput "$program" test02
   {
    $init
    $add
   } > "$output" 2>&1

   cat $output
}

# test add with non-existent file
test03() {
    program=$1
    args=$2
    setOutput "$program" test03
   {
    $init
    $add ligma.txt
   } > "$output" 2>&1

   cat $output
}

# test add with non-existent files (all don't exist)
test04() {
    program=$1
    args=$2
    setOutput "$program" test04
   {
    $init
    $add test.md 2 3
   } 2> "$output" 2>&1

   cat $output
}

# test add with some exist and some don't exist


tests="test01 test02 test03 test04"

runTests "$tests"