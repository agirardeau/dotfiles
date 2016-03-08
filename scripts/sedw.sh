# sed wrapper

printusageandexit() {
    echo "Usage: sedw <pattern> <replacement> <files...>"
    exit 0
}

if [[ $# -lt 3 ]]; then
    printusageandexit
fi

pattern="${1//\//\\/}"
shift
replacement="${1//\//\\/}"
shift
filelist="$@"

sed -i -r "s/$pattern/$replacement/" $filelist
