#!/bin/bash

source "$LIB_CORE"
lib_use lib_monthNumToName

if [ $# -ne 3 ]; then
    echo "bad"; exit 1
fi

if [ $3 -lt 99 ]; then
    echo "bad"; exit 1
fi

if [ -z "$( echo $1 | sed 's/[[:digit:]]//g')" ]; then
    lib_monthNumToName $1
else
    month="$( echo $1 | cut -c1 | tr [:lower:] [:upper:] )"
    month="$month$( echo $1 | cut -c2-3 | tr [:upper:] [:lower:] )"
fi

echo $month $2 $3

exit 0
