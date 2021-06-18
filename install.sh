
# Copy all files
. ./setup.sh

# And install all required packages
echo "Installing required packages now..."
sudo apt install -y zathura vim-gtk3 i3 compton entr zsh

sudo apt install -y texlive texlive-latex-extra texlive-lang-german texlive-pictures

# Now instruct the user to change the shell
echo "Installed everything..."
echo "Now you should change your default shell to zsh with the following command:"
echo "\tchsh -s /usr/bin/zsh"

