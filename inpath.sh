#!/bin/bash
# inpath -- verifies that a specified program is either valid as is 
# or can be found in the PATH directory list.
in_path()
{
    # Given a command and a PATH value, it tries to find the command.
    # Returns 0 is command is found and executable, 1 if not
    # Internal Field Separator is temporarily modified and has to be restored upon completion.
    
    cmd=$1 
    ourpath=$2
    result=1
    oldIFS=$IFS
    IFS=":"

    for directory in "ourpath"
    do
        if [ -x directory/$cmd ]; then
            result=0
        fi
    done # the command is found here, and is executable

    #restore the IFS
    IFS=$oldIFS
    return $result
}

checkForCmdInPath()
{
    var=$1
    
    if [ "$var" != "" ]; then
        if [ "${var:0:1}" = "/" ]; then
            if [ ! -x $var ]; then
                return 1
            fi
        elif ! in_path $var "$PATH"; then
            return 2
        fi
    fi
}

if [ $# -ne 1 ]; then
    echo "Usage: $0 <command>" >&2
    exit 1
fi

checkForCmdInPath "$1"
case $? in 
    0 ) echo "$1 found in PATH" ;;
    1 ) echo "$1 not found or not executable"   ;;
    2 ) echo "$1 is not found in PATH"  ;;
esac

exit 0
