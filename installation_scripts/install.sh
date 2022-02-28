# Install the base packages first
# and update the system

pacman -Syu
pacman -S xorg

echo "Downloading patched nerd fonts now..."
. ./nerd_fonts_install.sh

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

# Not sure if npm is still needed (maybe remove this?)
# sudo apt install npm

# Install latex environment
sudo pacman --noconfirm -Sy texlive texlive-latex-extra texlive-lang-german texlive-pictures
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
. ./setup.sh

pacman -Syu

# Now instruct the user to change the shell
echo "Installed everything..."
echo "Now you should change your default shell to zsh with the following command:"
echo "\tchsh -s /usr/bin/zsh"
