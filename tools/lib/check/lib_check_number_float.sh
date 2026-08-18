#!/bin/bash

lib_check_number_float(){
    ### getopts ###
    local opt
    local OPTIND=1
    local debug=0
    while getopts "d" opt; do
        case "$opt" in
            d) debug=1; clear ;;
        esac
    done

    shift $(($OPTIND - 1))

    #debug 
    [ "$debug" -eq 1 ] && echo "[debug] lib_check_number_float: ready" >&2

    ### vari ###
    local float="$1"
    local sym="$(echo "$float" | sed 's/[^.]//g')"
    local inte; local deci
    [ -n "$sym" ] && { inte="${float%.*}"; deci="${float#*.}"; }

    #debug
    [ "$debug" -eq 1 ] && printf '%s\n\t%s\n\t%s\n\t%s\n\t%s\n' "[debug] lib_check_number_float:" "float=$float" "sym=$sym" "inte=$inte" "deci=$deci" >&2
    
    ### check ###
    if [ -n "$sym" ]; then
        #debug
        [ "$debug" -eq 1 ] && echo "[debug] lib_check_number_float: [ -n \$sym ]: yes" >&2

        [ "${#sym}" -ne 1 ] && return 7 #[bad] check_number_float: (sym) bad input
        lib_check_number_int "$inte" || return 1 #[bad] check_number_float: (inte) bad input
        [ -n "$deci" ] || return 2 #[bad] check_number_float: (deci) no input
        [ "${deci:0:1}" = "-" ] && return 3 #[bad] check_number_float: (deci) not allow "-" for deci
        lib_check_number_int "$deci" || return 4 #[bad] check_number_float: (deci) bad input
    else
        #debug
        [ "$debug" -eq 1 ] && echo "[debug] lib_check_number_float: [ -n \$sym ]: no" >&2

        [ "$float" = "-" ] && return 5 #[bad] check_number_float: (float) bad input, can't just input "-"
        lib_check_number_int "$float" || return 6 #[bad] check_number_float: (float) bad input, not valid number
    fi

    #debug
    [ "$debug" -eq 1 ] && echo "[debug] lib_check_number_float[0]: good" >&2

    return 0
}

lib_check_number_float_result(){
    local input="$1"
    case "$input" in
        1) echo "[bad] check_number_float[1]: (inte) bad input" >&2 ;;
        2) echo "[bad] check_number_float[2]: (deci) no input" >&2 ;;
        3) echo "[bad] check_number_float[3]: (deci) not allow "-" for deci" >&2 ;;
        4) echo "[bad] check_number_float[4]: (deci) bad input" >&2 ;;
        5) echo "[bad] check_number_float[5]: (float) bad input, can't just input "-"" >&2 ;;
        6) echo "[bad] check_number_float[6]: (float) bad input, not valid number" >&2 ;;
        7) echo "[bad] check_number_float[7]: (sym) bad input" >&2 ;;
    esac
}
