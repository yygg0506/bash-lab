# lib_check_number_range

lib_chcek_number_range(){
    ### variables ###
    local input="$1"
    local min="$2"
    local max="$3"

    ### cehck ###
    ! lib_check_number_int "$input" && return 1 #[bad] bad value

    ### main ###
    [ -n "$min" ] && [ "$input" -lt "$min" ] && return 2 #[bad] too small
    [ -n "$max" ] && [ "$input" -gt "$max" ] && return 3 #[bad] too large
    return 0
}


lib_check_number_range_result(){
    local input="$1"

    case "$input" in
        1) echo "[bad] bad value" ;;
        2) echo "[bad] too small" ;;
        3) echo "[bad] too large" ;;
    esac
}
