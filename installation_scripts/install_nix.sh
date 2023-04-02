#!/usr/bin/env sh

#!/usr/bin/env bash

# Install Nix
curl -L https://nixos.org/nix/install | sh

# Add Nix to the PATH
echo ". /home/$USER/.nix-profile/etc/profile.d/nix.sh" >> ~/.bashrc
source ~/.bashrc
