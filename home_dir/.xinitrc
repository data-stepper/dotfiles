#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
	for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
		[ -x "$f" ] && . "$f"
	done
	unset f
fi

# Now start the x server with my configuration
sudo dhcpcd # Launch dynamic ip address DHCP
sudo systemctl start iwd # Start the wireless interface
rm -rf ~/Downloads/* # Remove all contents of the Download folder to keep it clean
autorandr --load home # Try to load the standard xrandr settings
nitrogen --head=0 --set-zoom-fill ~/Documents/Wallpapers/Wallpaper
nitrogen --head=1 --set-zoom-fill ~/Documents/Wallpapers/Wallpaper

# Not using compton anymore
# compton --backend glx --vsync &
xset r rate 220 80
exec i3
