lib_check_alnum(){
    local input="$1"
    local check="$(echo "$input" | sed 's/[[:alnum:]]//g')"

    [ -n "$check" ] && return 1 #[bad] check_alnum: bad input
    return 0
}

lib_check_alnum_result(){
    local input="$1"
    case $input in
        1) echo "[bad] check_alnum: bad input" >&2
    esac
}
