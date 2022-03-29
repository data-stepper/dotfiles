# Get user home directory
HOME_DIR=$(eval echo ~$user)
DOTFILES_DIR=$HOME_DIR/git/dotfiles

# Inform user of the install
echo "Installing dotfiles from $DOTFILES_DIR to $HOME_DIR"

# Copy all config files now
# This copies all config files recursively to the user's home directory
cp -Rf $DOTFILES_DIR/home_dir/. $HOME_DIR

# Install vim-plug as plugin manager for neovim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Copy auto python scripts
sudo cp ../utilitiy_scripts/autorunpy /usr/bin/
sudo cp ../utilitiy_scripts/autotestpy /usr/bin/

# Create screenshot directory
mkdir -p $HOME_DIR/screenshots

# Copy screenshot scripts
sudo cp ../utilitiy_scripts/screenshot-anki-card-trigger.py /bin
