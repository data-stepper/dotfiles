# Copy some config files
cp -rf ../config_files/aliasrc ~/.aliasrc
cp ../config_files/zshrc ~/.zshrc
cp ../config_files/Xresources ~/.Xresources
cp ../config_files/xinitrc ~/.xinitrc

# Copy alacritty config file
mkdir -p ~/.config/alacritty
cp ../config_files/alacritty.yml ~/.config/alacritty/alacritty.yml

# Create i3 config directory and file
mkdir -p ~/.config/i3
cp ../config_files/i3-config ~/.config/i3/config

# Copy i3status config file
sudo cp ../config_files/i3status.conf /etc/i3status.conf

# Create lf file manager config dir and copy lfrc
mkdir -p ~/.config/lf
cp ../config_files/lfrc ~/.config/lf/lfrc

# Copy zathura config file
sudo cp -rf ../config_files/zathurarc /etc/zathurarc

# Make snippet directory and copy code snippets over
# Still setup old gvim
echo "Setting up vim now..."
# Not using vimrc anymore
# cp ../config_files/init.vim ~/.vimrc

# Now copy all neovim config files
mkdir -p ~/.config/nvim
mkdir -p ~/.config/nvim-qt
cp ../config_files/init.vim ~/.config/nvim/init.vim
cp ../config_files/ginit.vim ~/.config/nvim/ginit.vim
cp ../config_files/nvim-qt.conf ~/.config/nvim-qt/nvim-qt.conf

# Copy nvim snippets over
mkdir -p ~/.config/coc/ultisnips
cp ../snippets/* ~/.config/coc/ultisnips/

# Sets up vim-plug Plugin Manager
# Don't install for old vim anymore, remove this part later on
# curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
#     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Install for neovim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Coc config file
cp ../config_files/coc-settings.json ~/.vim/coc-settings.json
cp ../config_files/coc-settings.json ~/.config/nvim/coc-settings.json

# Setup compton composition manager
cp ../config_files/compton.conf ~/.config/compton.conf

# Copy startup script
sudo cp ../config_files/zprofile ~/.zprofile

# Copy auto python scripts
sudo cp ../utilitiy_scripts/autorunpy /usr/bin/
sudo cp ../utilitiy_scripts/autotestpy /usr/bin/

# Create screenshot directory
mkdir -p ~/screenshots

# Copy screenshot scripts
sudo cp ../utilitiy_scripts/screenshot-anki-card-trigger.py /bin

