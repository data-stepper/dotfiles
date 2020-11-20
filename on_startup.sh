xrandr --output DP-0 --auto --output HDMI-0 --auto --scale 1.5x1.5

xset r rate 220 40

nitrogen --set-zoom-fill ~/Documents/Wallpapers/Mojave Night.jpg

compton -cCGfF -b -i 0.75

# Runs the script to update and format uptime for the status bar
while /bin/true; do
	sleep 300
	~/dotfiles/scripts/uptime_fmt.py
done &
