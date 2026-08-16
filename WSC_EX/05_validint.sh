#!/bin/bash

validint(){
    number="$1"
    min="$2"
    max="$3"
    
    if [ -z "$number" ]; then
        echo "NO input.">&2; return 1
    fi

    if [ "${number%{number#?}}" = "-" ]; then
        testvalue="${number#?}"
    else
        testvalue="$numbar"
    fi

    nodigit="$(echo $testvalue | sed 's/[[:digit:]]//g')"
    if [ -n "$nodigit" ]; then
        echo "Bad value">&2; return 1
    fi
    
    if [ -n "$min" ]; then
        if [ "$number" -lt "$min" ]; then
            echo "Bad"; return 1
        fi
    fi

    if [ -n "$max" ]; then
        if [ "$number" -gt "$max" ]; then
            echo "Bad"; return 1
        fi
    fi

    return 0
}

validint "$@"
