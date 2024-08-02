#!/usr/bin/env dash

# Tests for `init`

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
   } 2> "$output" 2>&1

   cat $output
}
# Tests all of subset 0
test02() {
    setOutput "$program" test02
    {
        $init;
        echo line 1 > a;
        echo hello world >b;
        $add a b
        $commit -m 'first commit'
        echo  line 2 >>a
        $add a
        $commit -m 'second commit'
        $log
        echo line 3 >>a
        $add a
        echo line 4 >>a
        $show 0:a
        $show 1:a
        $show :a
        cat a
        $show 0:b
        $show 1:b
    } 2>> "$output" 2>&1

    removeTestFiles a b
}
tests="test01 test02"

runTests "$tests"
