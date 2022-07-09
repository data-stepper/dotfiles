# This script installs all packages needed for my arch linux setup
# It first reads a list of packages from './pkg_lists/pacman.txt'
# After that it install (using yay) the AUR packages in './pkg_lists/yay.txt'

sudo pacman --noconfirm -Sy - <./pkg_lists/pacman.txt

# Install the AUR packages from the list
yay --noconfirm --nodiffmenu -S $(cat ./pkg_lists/yay.txt)

# Install some packages with npm
sudo npm install -g pyright
sudo npm install -g lua-fmt
