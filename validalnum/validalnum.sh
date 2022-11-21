#!/bin/bash
# validalnum script ensures that the input contains only alphabetical
# and numeric characters.

validAlphaNum()
{
    # validate args. returns 0 if all are upper+lower+digits, 1 if otherwise.
    # Remove all unacceptable characters
    validchars="$(echo $1 | sed -e 's/[^[:alnum:]]//g')"

    if [ "$validchars" = "$1" ]; then
        return 0
    else
        return 1
    fi
}

# BEGIN MAIN SCRIPT
/bin/echo -n "Enter input: "
read input

#Input Validation
if ! validAlphaNum "$input"; then
    echo "UsageError: Please enter only letters and numbers." >&2
    exit 1
else
    echo "Input is valid."
fi

exit 0