#!/bin/bash

source $LIB_CORE
lib_use lib_check

validfloat(){
    fvalue="$1"

    if [ ! -z "$(echo $fvalue| sed 's/[^.]//g')" ]; then
        inte_part="$(echo $fvalue | cut -d. -f1)"
        deci_part="${fvalue#*\.}"

        if [ ! -z $inte_part ]; then
           if ! lib_check_range "$inte_part" "" "" ; then
              return 1
           fi
        fi

        if [ "${deci_part%${deci_part#?}}" = "-" ]; then
            echo "Invalid float-point number: "-" not allowed after decimal point." >&2
            return 1
        fi

        if [ "$deci_part" != "" ]; then
           return 1
        fi
    else
        if [ "$fvalue" = "-" ]; then
            echo "Invalid floating-point format." >&2
            return 1
        fi

        if ! lib_check_range "$fvalue" "" "" ; then
            return 1
        fi
    fi

    return 0
}
