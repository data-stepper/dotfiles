#!/bin/bash

# This install script is based on the following arch wiki article:
# https://wiki.archlinux.de/title/Anleitung_f%C3%BCr_Einsteiger

echo "Welcome to Bent's arch bootstrap script\n"

read -r -p "Please enter your username: " -a arr
HOSTNAME=${arr[0]}

read -r -p "Please enter the password you want to use: " -a arr
USERPASSWORD=${arr[0]}

read -r -p "Please enter the diskname you want to install arch linux on: " -a arr
DISKNAME=${arr[0]}

# Use openssl as it is installed by default
# Use it to generate a safe password
ROOT_PASSWORD=$(openssl rand -base64 24)

# Remove this line later, just to check if the install works now
ROOT_PASSWORD=$USERPASSWORD

read -r -p "Your root password is '$ROOT_PASSWORD', please write it down" -a arr

# First delete all partitions on the disk
printf "d\n\nd\n\nd\n\nd\n\nd\n\nd\n\nd\n\nd\n\nd\n\nw\n" | fdisk /dev/$DISKNAME

# Commands taken from here: https://wiki.archlinux.de/title/Gdisk
printf "o\ny\nn\n\n\n+512M\nef00\nn\n\n\n\n8300\nw\ny\n" | gdisk /dev/$DISKNAME

# Now create the file systems

# Create the filesystem for EFI partition
yes | mkfs.fat -F 32 -n BOOT /dev/$DISKNAME'p1'
yes | mkfs.ext4 -L ROOT /dev/$DISKNAME'p2'

# Possibly also create swap but we usually don't need it
# Note that this would require creating a swap partition above
# mkswap -L SWAP /dev/SWAP_PARTITION

# Mount the partitions
mount -L ROOT /mnt

mkdir /mnt/boot
mount -L BOOT /mnt/boot

# Now install some basic packages
yes | pacstrap /mnt base base-devel linux linux-firmware dhcpcd nano vim iwd

# --> Change this if you have an amd cpu <-- !!
yes | pacman --root /mnt -S intel-ucode
# yes | pacman --root /mnt -S amd-ucode

# Generate file system table (fstab)
genfstab -U /mnt >> /mnt/etc/fstab

echo $USERNAME's-linux-box' > /mnt/etc/hostname

# Download the inside_chroot.sh script
curl -LO raw.githubusercontent.com/data-stepper/dotfiles/main/inside_chroot.sh

# Chroot into root file system
arch-chroot /mnt

# Now reboot the system and the post-install script shall be run
umount /mnt/boot
umount /mnt

reboot


