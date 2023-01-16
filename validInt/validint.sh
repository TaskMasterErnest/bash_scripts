#!/bin/bash
# validInt, validates user integer input, allowing negative numbers too

validint() {
    # validate the first field and test the value against the second parameter $2 (min value)
    # and/or the third parameter (max value). 
    # the function fails if the values are not in range, or it's not composed of digits.

    number="$1";    min="$2";   max="$3"

    if [ -z $number ]; then
        echo "You didn't enter anything. Please enter a number." >&2
        return 1
    fi

    # Is the first character of the integer a '-' sign?
    if [ "${number%${number#?}}" = "-" ]; then
        testvalue="${number#?}"   #take all but the first character
    else
        testvalue="$number"
    fi

    # TESTING THE VALUE
    # create a version of the testvalue that has not digits
    nodigits="$( echo $testvalue | sed 's/[[:digit:]]//g' )"

    # check for non-digit characters
    if [ ! -z $nodigits ]; then
        echo "Invalid number format! Only digits, no spaces, no commas etc." >&2
        return 1
    fi

    if [ ! -z $min ]; then
        # is the number less than the minimun value?
        if [ "$number" -lt "$min" ]; then
            echo "Your value is too small: smallest number acceptable is $min." >&2
            return 1
        fi
    fi

    if [ ! -z $max ]; then
        # is the number greater than the maximum value?
        if [ "$number" -gt "$max" ]; then
            echo "Your value is too large: largest number acceptable is $max." >&2
            return 1
        fi
    fi

    return 0
}

# RUNNING THE SCRIPT
# validating the input
if validint "$1" "$2" "$3" ; then
    echo "Input is a valid integer within your constraints."
fi