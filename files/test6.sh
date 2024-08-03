#!/usr/bin/env dash

# Tests for status

SCRIPT_DIR=$(dirname "$0")
. "$SCRIPT_DIR/testHelper.sh"

chmod +x *

test6_1(){
    program=$1
    args=$2
    setOutput "$program" test6_1
   {
    $init
    # Initialized empty grip repository in .grip
    echo 1 >a
    echo 2 >b
    echo 3 >c
    $add a b c
    $commit -m "first commit"
    # Committed as commit 0
    echo 4 >>a
    echo 5 >>b
    echo 6 >>c
    echo 7 >d
    echo 8 >e
    $add b c d e
    echo 9 >b
    echo 0 >d
    $rm --cached a c
    $rm --force --cached b
    $rm --force --cached e
    $rm --force d
    $status
    # a - deleted from index
    # b - deleted from index
    # c - deleted from index
    # e - untracked
   } > "$output" 2>&1

   cat $output
   removeTestFiles a b c d
}

test6_2(){
    program=$1
    args=$2
    setOutput "$program" test6_2
   {
    $init
    # Initialized empty grip repository in .grip
    touch a b c d e f g h
    $add a b c d e f
    $commit -m "first commit"
    # Committed as commit 0
    echo hello >a
    echo hello >b
    echo hello >c
    $add a b
    echo world >a
    rm d
    $rm e
    $add g
    $status
    # a - file changed, different changes staged for commit
    # b - file changed, changes staged for commit
    # c - file changed, changes not staged for commit
    # d - file deleted
    # e - file deleted, deleted from index
    # f - same as repo
    # g - added to index
    # h - untracked
   } > "$output" 2>&1

   cat $output
   removeTestFiles a b c d e f g h
}

test6_3(){
    program=$1
    args=$2
    setOutput "$program" test6_3
   {
    $init
    # Initialized empty grip repository in .grip
    echo hello >a
    $add a
    $commit -m "commit-0"
    # Committed as commit 0
    $rm a
    $status
    # a - file deleted, deleted from index
    $commit -m "commit-1"
    # Committed as commit 1
    echo world >a
    $status
    # a - untracked
    $add a
    $commit -m "commit-2"
    # Committed as commit 2
    $rm a
    $commit -m "commit-3"
    # Committed as commit 3
    $show :a
    # grip-show: error: 'a' not found in index
    $show 0:a
    # hello
    $show 1:a
    # grip-show: error: 'a' not found in commit 1
    $show 2:a
    # world
    $show 3:a
    # grip-show: error: 'a' not found in commit 3
    $show 4:a
    # grip-show: error: unknown commit '4'
   } > "$output" 2>&1

   cat $output
   removeTestFiles a
}

test6_4(){
    program=$1
    args=$2
    setOutput "$program" test6_4
   {
    $init
    # Initialized empty grip repository in .grip
    echo hi >a
    $add a
    $commit -m "message"
    # Committed as commit 0
    echo hello >b
    echo hola >c
    $add b c
    $status
    # a - same as repo
    # b - added to index
    # c - added to index
    echo there >>b
    rm c
    $status
    # a - same as repo
    # b - added to index, file changed
    # c - added to index, file deleted
   } > "$output" 2>&1

   cat $output
   removeTestFiles a b c
}



for i in $(seq 1 4); do
    tests="$tests test6_$i"
done
runTests "$tests"