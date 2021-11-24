#!/bin/bash -e

CHALLENGEFILE=comparenumbers.py

_check_file_exists () {
    # internal function to exit test if file missing
    # arguments
    # $1 feedback message
    if [ ! -f "$CHALLENGEFILE" ]; then
        echo "$CHALLENGEFILE missing."
        exit 1
    fi
}

_compare () {
    echo -e "$1\n$2" | python $CHALLENGEFILE | sed 's|.*[^0-9]\([0-9]....*[0-9]\)|\1|g'
}

test_equal () {
    _check_file_exists

    for i in {1..20..1}; do
        j=$i
        result=$(_compare $i $j)
        expected="$i is equal to $j"
        if [[ "$result" != "$expected" ]]; then
        echo "Expected: $expected"
        echo "Returned: $result"
        echo "fail"
        exit 1
        fi
    done

    echo "Inputs correctly compared as equal"
    echo "pass"
}

test_greater_than () {
    _check_file_exists

    for i in {1..30..1}; do
        for j in {1..20..2}; do
            less=$(( $i - $j ))
            result=$(_compare $i $less)
            expected="$i is greater than $less"
            if [[ "$result" != "$expected" ]]; then
                echo "Expected: $expected"
                echo "Returned: $result"
                echo "fail"
                exit 1
            fi
        done
    done

    echo "Inputs correctly compared as input 1 greater than input 2"
    echo "pass"
}

test_less_than () {
    _check_file_exists
    
    for i in {1..30..1}; do
        for j in {1..20..2}; do
            more=$(( $i + $j ))
            result=$(_compare $i $more)
            expected="$i is less than $more"
            if [[ "$result" != "$expected" ]]; then
                echo "Expected: $expected"
                echo "Returned: $result"
                echo "fail"
                exit 1
            fi
        done
    done

    echo "Inputs correctly compared as input 1 less than input 2"
    echo "pass"
}

"$@"
