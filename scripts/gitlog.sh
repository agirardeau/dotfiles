#!/usr/bin/env bash

if [[ "$1" == "-h" ]]; then
    echo "Usage: gitlog [num-commits]"
    exit 0
fi

if [ -z $1 ]
then
    commits=10
else
    commits=$1
fi

git --no-pager log -n $commits --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(reset)%C(bold green)(%ar)%C(reset)%C(bold yellow)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all

echo ""
