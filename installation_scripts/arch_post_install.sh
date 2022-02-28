# Run this script after installing arch linux
# It needs to install a lot of packages and will take quite some time

if [ "$EUID" -ne 0 ]
	then echo "Please run this script as root"
	exit
fi

# Update the system first
pacman -Syu

# Install the yay AUR helper
pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ~

# Install the snap store
git clone https://aur.archlinux.org/snapd.git
cd snapd
makepkg -si
sudo systemctl enable --now snapd.socket
sudo ln -s /var/lib/snapd/snap /snap
sudo snap install snap-store
cd ~

sudo snap install alacritty --classic

# Install some important packages
pacman --noconfirm -S xorg ttf-ubuntu-font-family xorg-server
pacman --noconfirm -S xorg-xinit unzip zip xterm i3-gaps
pacman --noconfirm -S firefox xclip scrot

yay -S google-chrome-beta

yay -Syu
pacman -Syu

echo "If you want to use nvidia drivers, run following command assuming you have the newest GPU"
echo "sudo pacman -S nvidia"

