# Install nerd fonts
cd ~

# Create temp fonts download directory
mkdir -p fonts_download
cd fonts_download

# Only copy those three fonts as they are my favorite
curl -LO https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip
curl -LO https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/IBMPlexMono.zip
curl -LO https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Hack.zip

# Unzip the donwloaded archives
unzip FiraCode.zip
unzip Hack.zip
unzip IBMPlexMono.zip

sudo cp *.ttf ~/.fonts

mkdir -p ~/.fonts

