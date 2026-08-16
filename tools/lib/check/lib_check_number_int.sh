# lib_check_number_int

lib_check_number_int(){
    local input="$1"
    local testvalue
    local nodigit

    [ -z "$input" ] && return 1 #[bad] no input

    if  [ "${input%${input#?}}" = "-" ]; then
        testvalue="${input#?}"
    else
        testvalue="$input"
    fi

    [ -z "$testvalue" ] && return 2 #[bad] can't just dash

    nodigit="$(echo "$testvalue" | sed 's/[[:digit:]]//g')"

    [ -n "$nodigit" ] && return 3 #[bad] bad value

    return 0
}

lib_check_number_int_result(){
    local input="$1"

    case "$input" in
        1) echo "[bad] no input" ;;
        2) echo "[bad] can't just dash" ;;
        3) echo "[bad] bad value" ;;
    esac
}
