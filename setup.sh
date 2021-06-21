# Copy some config files
cp ./aliasrc ~/.aliasrc
cp .zshrc ~/.zshrc
cp .Xresources ~/.Xresources

# Create i3 config directory and file
mkdir -p ~/.config/i3
cp i3-config ~/.config/i3/config

# Create lf file manager config dir and copy lfrc
mkdir -p ~/.config/lf
cp ./lfrc ~/.config/lf/lfrc

# Make snippet directory and copy code snippets over
echo "Setting up vim now..."
cp .vimrc ~/.vimrc

# Copy vim snippets over
mkdir -p ~/.vim/UltiSnips
cp ./snippets/* ~/.vim/UltiSnips/

# Sets up vim-plug Plugin Manager
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Coc config file
cp ./coc-settings.json ~/.vim/coc-settings.json

# Setup compton composition manager
cp ./compton.conf ~/.config/compton.conf

# Copy konsole config file
cp ./konsolerc ~/.config/konsolerc

# Copy startup script
sudo cp ./.zprofile ~/.zprofile

