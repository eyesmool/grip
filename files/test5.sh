#!/usr/bin/env dash

# Tests forrm

SCRIPT_DIR=$(dirname "$0")
. "$SCRIPT_DIR/testHelper.sh"

chmod +x *

test5_1(){
    program=$1
    args=$2
    setOutput "$program" test5_1
   {
    $init
    echo 1 >a
    echo 2 >b
    $add a b
    $commit -m "first commit"
    echo 3 >c
    echo 4 >d
    $add c d
    $rm --cached  a c
    $commit -m "second commit"
    $show 0:a
    $show 1:a
    $show :a
   } > "$output" 2>&1

   cat $output
   removeTestFiles a b c d
}

test5_2() {
    program=$1
    args=$2
    setOutput "$program" test5_2
   {
    $init
    # Initialized empty grip repository in .grip
    touch a b
    $add a b
    $commit -m "first commit"
    # Committed as commit 0
    rm a
    $commit -m "second commit"
    # nothing to commit
    $add a
    $commit -m "second commit"
    # Committed as commit 1
    $rm --cached b
    $commit -m "second commit"
    # Committed as commit 2
    $rm b
    #rm: error: 'b' is not in the grip repository
    $add b
    $rm b
    #rm: error: 'b' has staged changes in the index
    $commit -m "third commit"
    # Committed as commit 3
    $rm b
    $commit -m "fourth commit"
    # Committed as commit 4
   } > "$output" 2>&1

   cat $output
   removeTestFiles a b
}

test5_3() {
    program=$1
    args=$2
    setOutput "$program" test5_3
   {
    $init
    # Initialized empty grip repository in .grip
    touch a b
    $add a b
    $commit -m "first commit"
    # Committed as commit 0
    rm a
    $commit -m "second commit"
    # nothing to commit
    $add a
    $show :a
   } > "$output" 2>&1

   cat $output
   removeTestFiles a b
}

test5_4() {
    program=$1
    args=$2
    setOutput "$program" test5_4
   {
    $init
    #Initialized empty grip repository in .grip
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
    $add b c d
    echo 9 >b
    $rm a
    # grip-rm: error: 'a' in the repository is different to the working file
    $rm b
    # grip-rm: error: 'b' in index is different to both the working file and the repository
    $rm c
    # grip-rm: error: 'c' has staged changes in the index
    $rm d
    # grip-rm: error: 'd' has staged changes in the index
    $rm e
    # grip-rm: error: 'e' is not in the grip repository
    $rm --cached a
    $rm --cached b
    # grip-rm: error: 'b' in index is different to both the working file and the repository
    $rm --cached c
    $rm --cached d
    $rm --cached e
    # grip-rm: error: 'e' is not in the grip repository
    $rm --force a
    # grip-rm: error: 'a' is not in the grip repository
    $rm --force b
    $rm --force c
    # grip-rm: error: 'c' is not in the grip repository
    $rm --force d
    # grip-rm: error: 'd' is not in the grip repository
    $rm --force e
    # grip-rm: error: 'e' is not in the grip repository
   } > "$output" 2>&1

   cat $output
   removeTestFiles a b c d e
}

for i in $(seq 4 4); do
    tests="$tests test5_$i"
done
runTests "$tests"