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

# Chroot into root file system
arch-chroot /mnt

echo $USERNAME's-linux-box' > /etc/hostname

# Create locales
echo LANG=en_US.UTF-8 > /etc/locale.conf
echo en_US.UTF-8 UTF-8 > /etc/locale.gen

locale-gen

# Set the local time to Berlin and sync the hw clock and sync the hw clock
ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime
hwclock --systohc

# Create initramfs
mkinitcpio -p linux

# Change the root password
echo $ROOT_PASSWORD'\n'$ROOT_PASSWORD'\n' | passwd

# Now configure the bootloader
bootctl install

# Create the default boot loader config file
echo "" > /boot/loader/entries/arch-uefi.conf
echo "title\tArch Linux" >> /boot/loader/entries/arch-uefi.conf
echo "linux\t/vmlinuz-linux" >> /boot/loader/entries/arch-uefi.conf
echo "initrd\t/initramfs-linux.img" >> /boot/loader/entries/arch-uefi.conf
echo "options\troot=LABEL=ROOT rw lang=de init=/usr/lib/systemd/systemd locale=en_US.UTF-8" >> /boot/loader/entries/arch-uefi.conf

# And create the fallback config file
echo "" > /boot/loader/entries/arch-uefi-fallback.conf
echo "title\tArch Linux Fallback" >> /boot/loader/entries/arch-uefi-fallback.conf
echo "linux\t/vmlinuz-linux" >> /boot/loader/entries/arch-uefi-fallback.conf
echo "initrd\t/initramfs-linux-fallback.img" >> /boot/loader/entries/arch-uefi-fallback.conf
echo "options\troot=LABEL=ROOT rw lang=de init=/usr/lib/systemd/systemd locale=en_US.UTF-8" >> /boot/loader/entries/arch-uefi-fallback.conf

# Now create the real boot loader config file
echo "" > /boot/loader/loader.conf
echo "default\tarch-uefi.conf" >> /boot/loader/loader.conf
echo "timeout\t2" >> /boot/loader/loader.conf

# Now update the boot loader
bootctl update

# Now reboot the system and the post-install script shall be run
umount /mnt/boot
umount /mnt

reboot


