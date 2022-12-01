#!/bin/bash
# ch_date--standardizes the month field in the date specification to three letters, 
#   with the first letter capitalized. Exits with a 0 if no error.

# dealing with the month
monthNumToName()
{
    #sets the 'month' valeu to the appropriate value
    case $1 in
    1 ) month="Jan" ;;  2 ) month="Feb" ;;
    3 ) month="Mar" ;;  4 ) month="Apr" ;;
    5 ) month="May" ;;  6 ) month="Jun" ;;
    7 ) month="Jul" ;;  8 ) month="Aug" ;;
    9 ) month="Sep" ;;  10) month="Oct" ;;
    11) month="Nov" ;;  12) month="Dec" ;;
    * ) echo "$0: Unknown month value" >&2
        exit 1
    esac
    return 0
}

# Main piece of code to change date
# input validation
if [ $# -ne 3 ]; then
    echo "Usage: $0 month day year" >&2
    echo "Formats are August 4 2002 or 8 4 2002" >&2
    exit 1
fi
if [ $3 -le 999 ]; then
    echo "$0: expected a 4-digit year value" >&2
    exit 1
fi

# this next piece checks if the month field contains a number and changes it accordingly.
# is the mot=nth inout format a number?
if [ -z$(echo $1 |sed 's/[[:digit:]]//g') ]; then
    monthNumToName $1
else
# normalize the first 3 letters, first upper-, then lowercase.
    month="$(echo $1 | cut -c1 | tr '[:lower:]' '[:upper:]')"
    month="$month$(echo $1|cut -c2-3|tr '[:upper:]' '[:lower:]')"
fi

echo $month $2 $3

exit 0