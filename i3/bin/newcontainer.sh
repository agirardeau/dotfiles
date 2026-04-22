# Open a terminal in a new i3 container and have it execute the given commands
wd=`pwd`
run_in_directory_executable=`which run-in-directory`
i3-msg exec "i3-sensible-terminal -e '$run_in_directory_executable $wd $@'"
