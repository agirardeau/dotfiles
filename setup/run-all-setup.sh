directory=`dirname $0`

echo "==================================="
echo "Running setup-pathogen.sh..."
$directory/setup-pathogen.sh

echo "==================================="
echo "Running clone-vim-plugins.sh..."
$directory/clone-vim-plugins.sh

echo "==================================="
echo "Running configure-solarized.sh..."
$directory/configure-solarized.sh

echo "==================================="
echo "Running dotfile-link-setup.py..."
$directory/dotfile-link-setup.py
