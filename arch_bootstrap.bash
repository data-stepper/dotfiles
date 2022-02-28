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

read -r -p "Your root password is '$ROOT_PASSWORD', please write it down" -a arr

DISKNAME=nvme0n1

# Commands taken from here: https://wiki.archlinux.de/title/Gdisk
printf "o\ny\nn\n\n\n+512M\nef00\nn\n\n\n\n8300\nw\ny\n" | gdisk /dev/$DISKNAME

# Now create the file systems

# Create the filesystem for EFI partition
mkfs.fat -F 32 -n BOOT /dev/$DISKNAME'p1'
mkfs.ext4 -L ROOT /dev/$DISKNAME'p2'

# Possibly also create swap but we usually don't need it
# Note that this would require creating a swap partition above
# mkswap -L SWAP /dev/SWAP_PARTITION

# Mount the partitions
mount -L ROOT /mnt

mkdir /mnt/boot
mount -L BOOT /mnt/boot

# Now install some basic packages
yes | pacstrap /mnt base base-devel linux linux-firmware dhcpcd nano vim

# --> Change this if you have an amd cpu <-- !!
yes | pacman --root /mnt -S intel-ucode
# yes | pacman --root /mnt -S amd-ucode

yes | pacman --root /mnt -S iwd

# Generate file system table (fstab)
genfstab -U /mnt > /mnt/etc/fstab

# Chroot into root file system
arch-chroot /mnt

echo $USERNAME > /etc/hostname

# Create locales
echo LANG=en_US.UTF-8 > /etc/locale.conf





