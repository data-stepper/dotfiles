# Run this script after you have installed arch linux completely
# Also it shall be run as a user in the wheel group

if [ "$EUID" -eq 0 ]
	then echo "Please run this script as a user and not root"
	exit
fi

# Here I combined the install scripts as their order was wrong

# And install the video drivers
echo "Select which video driver to install"
echo "  1) nvidia for modern nvidia gpus"
echo "  2) intel for integrated graphics"

read n
case $n in
  1) echo "Installing nvidia drivers"; sudo pacman -S nvidia;;
  2) echo "Installing intel drivers"; sudo pacman -S xf86-video-intel mesa;;
  *) echo "invalid option, not installing video drivers";;
esac

# Update the system first
sudo pacman -Syu

# Now do the big pacman install
sudo pacman --noconfirm -Sy - < ./pkg_lists/pacman.txt

# Install the yay AUR helper
cd ~
sudo pacman --noconfirm -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ~

# Install some important packages
pacman --noconfirm -S xorg ttf-ubuntu-font-family xorg-server \
xorg-xinit unzip zip xterm i3-gaps \
firefox opera xclip scrot

yay -S google-chrome-beta
yay --noconfirm -S npm termdown

yay -Syu
pacman -Syu

cd ~
curl -LO https://repo.anaconda.com/miniconda/Miniconda3-py39_4.11.0-Linux-x86_64.sh

# That script needs to be run as user and not root
# sh Miniconda3-py39_4.11.0-Linux-x86_64.sh

# sudo sh ./additional_scripts/additional_packages.sh
echo "Installing lf file manager now..."
cd ~
curl -LO https://github.com/gokcehan/lf/releases/download/r26/lf-linux-amd64.tar.gz
tar xf lf-linux-amd64.tar.gz
sudo chmod +x lf
sudo mv lf /usr/bin/
rm lf-linux-amd64.tar.gz

# And install all required packages
echo "Installing required packages now..."
sudo pacman --noconfirm -Sy zathura i3 compton entr zsh nitrogen curl sxiv htop scrot

# Install all versions of vim for best compatibility
sudo pacman --noconfirm -Sy vim-gtk3 neovim-qt neovim vim

# Install nodejs and npm for coc language server
# Install nodejs version 12
curl -fsSL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo pacman --noconfirm -Sy nodejs

# Install latex environment
sudo pacman --noconfirm -Sy texlive texlive-latex-extra texlive-lang-german texlive-pictures
sudo pacman --noconfirm -Sy ctags usbutils # Need for neovim
sudo pacman --noconfirm -Sy latexmk

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

# Install alacritty terminal emulator
sudo snap install alacritty --classic

# Copy all files
./setup.sh

pacman -Syu

# Now instruct the user to change the shell
echo "Installed everything..."
echo "Now you should change your default shell to zsh with the following command:"
echo "\tchsh -s /usr/bin/zsh"


sh ./additional_scripts/nerd_fonts_install.sh

echo "You did it!"
echo "If you want to use nvidia drivers, run following command assuming you have the newest GPU"
echo "sudo pacman -S nvidia"
echo "Otherwise you should install the regular video drivers like so:"
echo "sudo pacman -S xf86-video-intel"
echo "IMPORTANT: ^^^ Install video drivers"

echo "After you have installed the video drivers, install miniconda with the script"
echo "sh Miniconda3-py39_4.11.0-Linux-x86_64.sh"
echo "You will find it in you ~. Do NOT use sudo to execute that script!"


