#!/bin/bash

in_path(){
    cmd=$1
    path=$2
    result=1

    oldIFS="$IFS"
    IFS=":"

    for dir in $path; do
        if [ -x "$dir"/"$cmd" ]; then
            result=0
        fi
    done

    return $result
}

in_path_check(){
    cmd=$1
    
    if [ "${cmd:0:1}" = "/" ]; then
        if [ ! -x "$cmd" ]; then
            return 1
        fi
    elif ! in_path "$cmd" "$PATH"; then
        return 2
    fi
}

if [ $# = 0 ]; then
    echo "[bad]: no input" >&2 ; exit 0
fi

in_path_check "$1"
case $? in
    0 ) echo "[good]: in path";;
    1 ) echo "[bad]: not avalible path" >&2;;
    2 ) echo "[bad]: not in \$PATH" >&2;;
esac
exit 0
