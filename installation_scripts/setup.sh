# Copy some config files
cp -rf ./aliasrc ~/.aliasrc
cp .zshrc ~/.zshrc
cp .Xresources ~/.Xresources

# Copy alacritty config file
mkdir -p ~/.config/alacritty
cp ./alacritty.yml ~/.config/alacritty/alacritty.yml

# Create i3 config directory and file
mkdir -p ~/.config/i3
cp i3-config ~/.config/i3/config

# Copy i3status config file
sudo cp ./i3status.conf /etc/i3status.conf

# Create lf file manager config dir and copy lfrc
mkdir -p ~/.config/lf
cp ./lfrc ~/.config/lf/lfrc

# Copy zathura config file
sudo cp -rf ./zathurarc /etc/zathurarc

# Make snippet directory and copy code snippets over
# Still setup old gvim
echo "Setting up vim now..."
cp ./init.vim ~/.vimrc

# Now copy all neovim config files
mkdir -p ~/.config/nvim
mkdir -p ~/.config/nvim-qt
cp ./init.vim ~/.config/nvim/init.vim
cp ./ginit.vim ~/.config/nvim/ginit.vim
cp ./nvim-qt.conf ~/.config/nvim-qt/nvim-qt.conf

# Copy nvim snippets over
mkdir -p ~/.config/coc/ultisnips
cp ./snippets/* ~/.config/coc/ultisnips/

# Sets up vim-plug Plugin Manager
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Also install for neovim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Coc config file
cp ./coc-settings.json ~/.vim/coc-settings.json
cp ./coc-settings.json ~/.config/nvim/coc-settings.json

# Setup compton composition manager
cp ./compton.conf ~/.config/compton.conf

# Copy konsole config file
cp ./konsolerc ~/.config/konsolerc

# Copy startup script
sudo cp ./.zprofile ~/.zprofile

# Copy auto python scripts
sudo cp ./scripts/autorunpy /usr/bin/
sudo cp ./scripts/autotestpy /usr/bin/

# Create screenshot directory
mkdir -p ~/screenshots

# Copy screenshot scripts
sudo cp ./scripts/screenshot-anki-card-trigger.py /bin
