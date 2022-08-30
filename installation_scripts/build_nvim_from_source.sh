# Change to the git directory
cd ~/git/

# Clone the repository
git clone https://github.com/neovim/neovim
cd neovim

# We want to build Release builds since they are the fastest
make CMAKE_BUILD_TYPE=Release

# Build the neovim binary
sudo make install
