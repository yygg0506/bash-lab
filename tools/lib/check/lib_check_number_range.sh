# lib_check_number_range

lib_check_number_range(){
    ### variables ###
    local input="$1"
    local min="$2"
    local max="$3"

    ### cehck ###
    lib_check_number_int "$input" || return 1 #[bad] bad value
	[ -z "$mix" ] || lib_check_number_int "$min" || return 2 #[bad] bad value
	[ -z "$max" ] || lib_check_number_int "$max" || return 3 #[bad] bad value

    ### main ###
    [ -n "$min" ] && [ "$input" -lt "$min" ] && return 4 #[bad] too small
    [ -n "$max" ] && [ "$input" -gt "$max" ] && return 5 #[bad] too large
    return 0
}


lib_check_number_range_result(){
    local input="$1"

    case "$input" in
        1) echo "[bad] bad value (input)" ;;
        2) echo "[bad] bad value (min)" ;;
        3) echo "[bad] bad value (max)" ;;
        4) echo "[bad] too small" ;;
        5) echo "[bad] too large" ;;
    esac
}
