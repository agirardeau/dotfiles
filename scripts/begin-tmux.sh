#!/usr/bin/env bash

if [ $# -eq 0 ]; then
    SESSIONNAME="default"
else
    SESSIONNAME=$1
fi

tmux has-session -t $SESSIONNAME &> /dev/null

if [ $? != 0 ]; then
    tmux new-session -s $SESSIONNAME -n script -d
    tmux send-keys -t $SESSIONNAME "~/bin/setup-tmux-windows.sh" C-m
fi

tmux attach -t $SESSIONNAME
