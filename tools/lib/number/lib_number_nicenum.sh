# lib_number_nicenum

lib_number_nicenum(){
    ### variables ###
    local input="$1"
    local rema
    local nicenum
    local DD="."
    local TD=","

    local sym="$(echo "$input" | sed "s/[^$DD]//g" )"
    if [ -z "$sym" ]; then
        local inte="$input"
        local deci=""
    else
        local inte="${input%$DD*}"
        local deci="${input#*$DD}"
    fi

    ### check ###
    lib_check_number_int "$inte" || return 1 # "[bad] bad input (inte)"
    [ -z "$deci" ] || lib_check_number_range "$deci" 0 "" || return 2 # "[bad] bad input (deci)"

    ### main ###
    if [ "${inte%${inte#?}}" = "-" ]; then
        inte="${inte#?}"
        nicenum="-$(lib_number_nicenum_main "$inte" "$deci")"
    else
        nicenum="$(lib_number_nicenum_main "$inte" "$deci")"
    fi

    echo $nicenum
}

lib_number_nicenum_main(){
    local inte="$1"
    local deci="$2"
    local result
    local nicenum

    [ -n "$deci" ] && result="${DD}${deci}"

    while [ "$inte" -gt 999 ]; do
        rema=$(($inte % 1000))
        while [ "${#rema}" -lt 3 ]; do
            rema="0$rema"
        done
        result="${TD}${rema}${result}"
        inte=$(($inte / 1000))
    done

    nicenum="${inte}${result}"
    echo $nicenum
}

lib_number_nicenum_result(){
    local input="$1"

    case $input in
        1) echo "[bad] bad input (inte)";;
        2) echo "[bad] bad input (deci)";;
    esac
}
