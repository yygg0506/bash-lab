# lib_check_input 

lib_check_input(){
	local input_num="$1"
	local output_text="$2"
	local check_num="$3"

    if ! lib_check_int -q "$input_num" 1 "${check_num:=1}"; then
        echo "$output_text">&2; return 1
    fi
}
