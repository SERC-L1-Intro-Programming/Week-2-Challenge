#!/bin/bash -e

CHALLENGEFILE=allthenumbers.py

_check_file_exists () {
    # internal function to exit test if file missing
    # arguments
    # $1 feedback message
    if [ ! -f "$CHALLENGEFILE" ]; then
        echo "$CHALLENGEFILE missing."
        exit 1
    fi
}

_run () {
    echo -e "$1" | python $CHALLENGEFILE
}

test_numbers () {
    _check_file_exists

    for i in {1..30..1}; do
        result=$(_run $i)
        expected=$(seq 1 $i)
        if [[ "$result" != *"$expected" ]]; then
            echo "Expected: $expected"
            echo "Returned: $result"
            echo "fail"
            exit 1
        fi
    done

    echo "Numbers output for given input number"
    echo "pass"
}

test_not_number () {
    _check_file_exists

    words=("hello" "world" "eggs" "ham" "spam")

    for word in ${words[@]}; do

        result=$(_run $word)
        expected="input is not a number"
        if [[ "$result" != *"$expected" ]]; then
            echo "Expected: $expected"
            echo "Returned: $result"
            echo "fail"
            exit 1
        fi
        # echo "try: $word"
    done

    echo "Non number inputs identified correctly"
    echo "pass"
}

"$@"
