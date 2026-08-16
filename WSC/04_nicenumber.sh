#!/bin/bash

DD="."
TD=","

nicenum(){
    inte="$(echo $1 | cut -d. -f1)"
    deci="$(echo $1 | cut -d. -f2)"

    if [ "$deci" != "$1" ]; then
        result="${DD}${deci}"
    fi

    while [ "$inte" -gt 999 ]; do
        rema=$(($inte % 1000))
        while [ ${#inte} -lt 3 ]; do
            inte="0$inte"
        done
        result="${TD}${rema}${result}"
        inte=$(($inte / 1000))
    done

    echo "${inte}${result}"
}

#### main
## getopts
while getopts "d:t:" opt; do
    case $opt in 
        d) DD="$OPTARG";;
        t) TD="$OPTARG";;
    esac
done

shift $(($OPTIND - 1))

## check_input
if [ $# -eq 0 ]; then
    echo "bad"; exit 1
fi

nicenum "$@"
