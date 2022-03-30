# Run this script after you have installed arch linux completely
# Also it shall be run as a user in the wheel group

if [ "$EUID" -eq 0 ]; then
    echo "Please run this script as a user and not root"
    exit
fi

# The user must be in the wheel group to run this script
# This is necessary to run sudo commands as well as non-sudo commands
if [ $(groups | grep -c "wheel") -eq 0 ]; then
    echo "Please run this script as a user in the wheel group"
    exit
fi

# Get the user's home directory path
HOME_DIR=$(getent passwd $USER | cut -d: -f6)

# CD into that directory
cd $HOME_DIR

# And tell the user where everything will be installed
echo "Installing Arch Linux additional packages to $HOME_DIR"

# And install the video drivers
echo "Select which video driver to install"
echo "  1) nvidia for modern nvidia gpus"
echo "  2) intel for integrated graphics"

# Inform the user which video driver will be installed
read n
case $n in
1)
    echo "Installing nvidia drivers"
    sudo pacman -S nvidia
    ;;
2)
    echo "Installing intel drivers"
    sudo pacman -S xf86-video-intel mesa
    ;;
*) echo "invalid option, not installing video drivers" ;;
esac

# Update the system first
sudo pacman -Syu

# Now do the big pacman install
# Put ALL pacman packages in that package list
sudo pacman --noconfirm -Sy - <./pkg_lists/pacman.txt

# Install the yay, AUR helper
cd $HOME_DIR
sudo pacman --noconfirm -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd $HOME_DIR

# Install the AUR packages from the list
yay --noconfirm -S $(cat ./pkg_lists/yay.txt)

# Tell the user that most of the packages are installed
echo "Installed most of the packages, updating the system now"

yay -Syu
pacman -Syu

cd ~
curl -LO https://repo.anaconda.com/miniconda/Miniconda3-py39_4.11.0-Linux-x86_64.sh

# sudo sh ./additional_scripts/additional_packages.sh
echo "Installing lf file manager now..."
cd ~
curl -LO https://github.com/gokcehan/lf/releases/download/r26/lf-linux-amd64.tar.gz
tar xf lf-linux-amd64.tar.gz
sudo chmod +x lf
sudo mv lf /usr/bin/
rm lf-linux-amd64.tar.gz

# Install nodejs and npm for coc language server
# Install nodejs version 12
# curl -fsSL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo pacman --noconfirm -Sy nodejs

# Install latex environment
# The latex packages don't work right now, check later why that is
# Or look for different arch packages
# sudo pacman --noconfirm -Sy texlive texlive-latex-extra texlive-lang-german texlive-pictures

# Install nativefier
sudo npm install -g nativefier

# Create nativefied directory
mkdir -p ~/.nativefied

# And create nativefied apps for gmail and notion
nativefier -n "Gmail" https://mail.google.com/mail/u/0/#inbox ~/.nativefied/
nativefier -n "Notion" https://www.notion.so/Dashboard-4e94ded4b284488d84191448ae841e2c ~/.nativefied/

# Now symlink both apps so they can be launched from dmenu
sudo ln -s ~/.nativefied/Gmail-linux-x64/Gmail /usr/bin/gmail
sudo ln -s ~/.nativefied/Notion-linux-x64/Notion /usr/bin/notion

# Copy all files
. ./setup.sh

sh ./additional_scripts/nerd_fonts_install.sh

echo "You did it!"

# That script needs to be run as user and not root
sh Miniconda3-py39_4.11.0-Linux-x86_64.sh

# Now instruct the user to change the shell
echo "Installed everything..."
echo "Now you should change your default shell to zsh with the following command:"
echo "\tchsh -s /usr/bin/zsh"
