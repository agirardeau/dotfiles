# cd into a given directory and run a command there. This script is intended as
# a workaround for the terminal -e option, which doesn't accept "cd foo && bar"
# because cd is a shell builtin and not an executable.
newcwd=$1
shift
cd $newcwd && $@
