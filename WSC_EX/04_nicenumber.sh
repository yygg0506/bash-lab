#!/bin/bash

DD="."
TD=","

nicenum(){
    symbol="$( echo $1 | sed -e 's/[[:digit:]]//g')"
    if [ ! -n "$symbol" ]; then
        inte="$1"
        deci="$1"
    else
        inte="$( echo $1 | cut "-d$symbol" -f1)"
        deci="$( echo $1 | cut "-d$symbol" -f2)"
    fi

    if [ "$deci" != "$1" ]; then
        result="${DD}${deci}"
    fi

    while [ "$inte" -gt 999 ]; do
        rema=$(($inte % 1000))
        while [ "${#rema}" -lt 3 ]; do
            rema="0$rema"
        done
        result="${TD}${rema}${result}"
        inte=$(($inte / 1000))
    done

    nicenum="${inte}${result}"
    echo "$nicenum"
}

#### main ####
## getopts
while getopts "d:t:" opt; do
    case $opt in
        d ) DD="$OPTARG";;
        t ) TD="$OPTARG";;
    esac
done
shift $(($OPTIND - 1))

## check_input
if [ "$#" -eq 0 ]; then
    echo "bad"; exit 1
fi

## nicenum
nicenum "$@"
