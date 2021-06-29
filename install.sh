
# And install all required packages
echo "Installing required packages now..."
sudo apt install -y zathura vim-gtk3 i3 compton entr zsh nitrogen curl sxiv htop

# Qutebrowser my main go-to browser now
sudo apt install -y qutebrowser

# Install nodejs and npm for coc language server
# Install nodejs version 12
curl -fsSL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt-get install -y nodejs

# Not sure if npm is still needed (maybe remove this?)
# sudo apt install npm

sudo apt install -y texlive texlive-latex-extra texlive-lang-german texlive-pictures

# Copy all files
. ./setup.sh

# Now instruct the user to change the shell
echo "Installed everything..."
echo "Now you should change your default shell to zsh with the following command:"
echo "\tchsh -s /usr/bin/zsh"
