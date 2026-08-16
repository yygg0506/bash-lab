#!/bin/bash

check_alnum(){
    input="$1"
    check="$(echo $input|sed 's/[^[:alnum:]]//g')"

    if [ "$input" != "$check" ]; then
        return 1
    fi
}

printf '%s\n' "Plesae input: "
read anser

if check_alnum "$anser"; then
    echo "good"; exit 0
else
    echo "bad" >&2; exit 1
fi
