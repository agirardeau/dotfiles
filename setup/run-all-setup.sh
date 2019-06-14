directory=`dirname $0`

echo "==================================="
echo "Running dotfile-link-setup.py..."
$directory/dotfile-link-setup.py

echo "==================================="
echo "Running misc-setup..."
$directory/misc-setup
