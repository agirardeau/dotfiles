printusageandexit() {
    echo "Usage: sedr <pattern> <replacement> [files]"
    exit 0
}

#!/usr/bin/env bash
if [ $# -eq 2 ]; then
    files=*
elif [ $# -eq 3 ]; then
    files=$3
else
    printusageandexit
fi

pattern="${1//\//\\/}"
replacement="${2//\//\\/}"

find . -name $files -exec sed -i -r "s/$pattern/$replacement/" {} \;
