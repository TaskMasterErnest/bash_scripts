#!/bin/bash
# nicenum -- When given a number, it shows it in a comma-separated form.
# it expects a delimiter for decimal notation DD (.), a delimiter for a thousands delimiter TD (,).
# it is instantiated immediately or if a second arg is introduced, the output is sent to stdout.

#the funtion
nicenumber() {
    # the delimiters are assumed to be like they are in mathematics. (.) and (,)
    # the delimiters can be re-specified with the -d flag by the user

    integer=$(echo $1 | cut -d. -f1) #specifies the integers (left of decimal)
    decimal=$(echo $1 | cut -d. -f2) #specifies the decimals (right of decimal delimiter)

    #check if number has integers or not
    if [ "$decimal" != "$1" ]; then
        #there has to be a fractional part, include it
        result="${DD:= '.'}$decimal"
    fi 

    thousands=$integer

    while [ $thousands -gt 999 ]; do
        remainder=$(($thousands % 1000)) #setting it to three significant figures
        #remainder has to be three digits, we force leading zeros if not 3 zeros.
        while [ ${#remainder} -lt 3 ]; do
            remainder="0$remainder"
        done

        result="${TD:=","}${remainder}${result}"
        thousands=$(($thousands / 1000))
    done

    nicenum="${thousands}${result}"
    if [ ! -z $2 ]; then
        echo $nicenum
    fi
}

DD="." # decimal delimiter, to separate whole and fractional values
TD="," # thousancs delimiter, to separate every three digits

#MAIN SCRIPT

while getopts "d:t:" opt; do
    case $opt in 
        d ) DD="$OPTARG" ;;
        t ) TD="$OPTARG" ;;
    esac
done
shift $(($OPTIND -1))

#input validation
if [ $# -eq 0 ]; then
    echo "Usage: $(basename $0) [-d c] [-t c] number"
    echo " -d specifies the decimal delimiter"
    echo " -t specifies the thousands delimiter"
    exit 0
fi

nicenumber $1 1  # second arg forces the output to stdout
exit 0