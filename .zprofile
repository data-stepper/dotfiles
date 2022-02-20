#!/bin/bash

# Increase key repeat
xset r rate 220 80

# Set wallpaper
nitrogen --set-zoom-fill ~/Documents/Wallpaper &

# Start composition manager
compton &

# Clean the download folder to keep it organized always
rm -rf ~/Downloads/*

