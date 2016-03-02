#!/usr/bin/env bash

_get_screen_layouts ()
{
    local home=`echo ~`
    local scripts=(~/.screenlayout/*)
    COMPREPLY=()

    local cur=${COMP_WORDS[COMP_CWORD]}

    for script in ${scripts[@]}; do
        local script_reduced=`echo $script | sed "s@$home/\.screenlayout/\(\w\+\)\.sh@\1@"`
        if [[ $script_reduced == $cur* ]]; then
            COMPREPLY+=( $script_reduced )
        fi
    done

    return 0
}

complete -F _get_screen_layouts setscreen
