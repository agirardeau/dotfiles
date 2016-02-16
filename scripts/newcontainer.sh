#!/usr/bin/env sh
# Open a terminal in a new i3 container and 
wd=`pwd`
run_in_directory_executable=`which run-in-directory`
i3-msg exec "i3-sensible-terminal -e '$run_in_directory_executable $wd $1'"
