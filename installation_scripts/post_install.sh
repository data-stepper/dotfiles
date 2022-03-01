# Run this script after you have installed arch linux completely
# Also it shall be run as a user in the wheel group

if [ "$EUID" -eq 0 ]
	then echo "Please run this script as a user and not root"
	exit
fi

# First install most of the packages as root
sudo sh ./additional_scripts/arch_post_install.sh
sudo sh ./additional_scripts/additional_packages.sh
sudo sh ./additional_scripts/nerd_fonts_install.sh

echo "You did it!"
echo "If you want to use nvidia drivers, run following command assuming you have the newest GPU"
echo "sudo pacman -S nvidia"
echo "Otherwise you should install the regular video drivers like so:"
echo "sudo pacman -S xf86-video-intel"
echo "IMPORTANT: ^^^ Install video drivers"

echo "After you have installed the video drivers, install miniconda with the script"
echo "sh Miniconda3-py39_4.11.0-Linux-x86_64.sh"
echo "You will find it in you ~. Do NOT use sudo to execute that script!"


