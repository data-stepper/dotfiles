# Copy some config files
cp .zshrc ~/.zshrc
cp .xinitrc ~/.xinitrc
cp .Xresources ~/.Xresources

# Create i3 config directory and file
mkdir -p ~/.config/i3
cp i3-config ~/.config/i3/config

# Make snippet directory and copy code snippets over
echo "Setting up vim now..."
cp .vimrc ~/.vimrc

# Copy vim snippets over
mkdir -p ~/.vim/UltiSnips
cp ./snippets/* ~/.vim/UltiSnips/

# Coc config file
cp ./coc-settings.json ~/.vim/coc-settings.json

# Setup compton composition manager
cp ./compton.conf ~/.config/compton.conf

# Copy konsole config file
cp ./konsolerc ~/.config/konsolerc

