#!/bin/bash

# This install script is based on the following arch wiki article:
# https://wiki.archlinux.de/title/Anleitung_f%C3%BCr_Einsteiger

echo "Welcome to Bent's arch bootstrap script\n"

read -r -p "Please enter your username: " -a arr
export HOSTNAME=${arr[0]}

read -r -p "Please enter the password you want to use: " -a arr
export USERPASSWORD=${arr[0]}

read -r -p "Please enter the diskname you want to install arch linux on: " -a arr
export DISKNAME=${arr[0]}

# Use openssl as it is installed by default
# generate a safe password
export ROOT_PASSWORD=$(openssl rand -base64 24)

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
yes | pacstrap /mnt base base-devel linux linux-firmware dhcpcd nano vim iwd vi git

# --> Change this if you have an AMD cpu <-- !!
yes | pacman --root /mnt -S intel-ucode
# yes | pacman --root /mnt -S amd-ucode

echo $HOSTNAME's-linux-box' >/mnt/etc/hostname

cat <<EOF >/mnt/inside_chroot.sh
# This is the part of the install script that needs to be run inside
# the arch-chroot

# Create locales
echo LANG=en_US.UTF-8 > /etc/locale.conf
echo en_US.UTF-8 UTF-8 > /etc/locale.gen

locale-gen

# Set the local time to Berlin and sync the hw clock and sync the hw clock
ln -sf /usr/share/zoneinfo/Europe/Berlin /etc/localtime
hwclock --systohc

# TODO: Add usb and usbinput to the HOOKS at /etc/mkinitcpio.conf
# Create initramfs
mkinitcpio -p linux

# Change the root password
printf $ROOT_PASSWORD'\n'$ROOT_PASSWORD'\n' | passwd

# Create the main system's user so root will not be used
mkdir /home/$HOSTNAME
useradd --groups wheel --home-dir /home/$HOSTNAME $HOSTNAME
printf $USERPASSWORD'\n'$USERPASSWORD'\n' | passwd $HOSTNAME

# The user also needs to own his/her home directory
chown $HOSTNAME:wheel /home/$HOSTNAME

# This script uses systemd-boot as bootloader because it is already
# installed and thus more easy to set up now

# Now configure the bootloader
bootctl install

# Create the default boot loader config file
printf "" > /boot/loader/entries/arch-uefi.conf
printf "title\tArch Linux\n" >> /boot/loader/entries/arch-uefi.conf
printf "linux\t/vmlinuz-linux\n" >> /boot/loader/entries/arch-uefi.conf
printf "initrd\t/initramfs-linux.img\n" >> /boot/loader/entries/arch-uefi.conf
printf "options\troot=LABEL=ROOT rw lang=de init=/usr/lib/systemd/systemd locale=en_US.UTF-8\n" >> /boot/loader/entries/arch-uefi.conf

# And create the fallback config file
printf "" > /boot/loader/entries/arch-uefi-fallback.conf
printf "title\tArch Linux Fallback\n" >> /boot/loader/entries/arch-uefi-fallback.conf
printf "linux\t/vmlinuz-linux\n" >> /boot/loader/entries/arch-uefi-fallback.conf
printf "initrd\t/initramfs-linux-fallback.img\n" >> /boot/loader/entries/arch-uefi-fallback.conf
printf "options\troot=LABEL=ROOT rw lang=de init=/usr/lib/systemd/systemd locale=en_US.UTF-8\n" >> /boot/loader/entries/arch-uefi-fallback.conf

# Now create the real boot loader config file
printf "\n" > /boot/loader/loader.conf
printf "default\tarch-uefi.conf\n" >> /boot/loader/loader.conf
printf "timeout\t2\n" >> /boot/loader/loader.conf

# Now update the boot loader
bootctl update

# Create a git directory and clone the dotfiles into it
# This way installation can be proceeded with faster
mkdir /home/$HOSTNAME/git
cd /home/$HOSTNAME/git
git clone https://github.com/data-stepper/dotfiles

# IMPORTANT: Change the home directory ownership to the user recursively.
chown -R $HOSTNAME:wheel /home/$HOSTNAME

# Exit from the arch-chroot so the other script can continue running
exit
EOF

# Turns out that the environment variables are passed to arch-chroot
# But set them explicitly here to remember
export ROOT_PASSWORD=$ROOT_PASSWORD
export HOSTNAME=$HOSTNAME
export USERPASSWORD=$USERPASSWORD

# Chroot into root file system and run the script
arch-chroot /mnt sh ./inside_chroot.sh

# Generate file system table (fstab)
# Do it after the stuff inside chroot is done
# For some reason it doesn't work when it is done before

# TODO: UUID changes after install
# Then when trying to boot the system waits to load the drive

# This is why we are now using the fstab with drive labels and not UUIDs
genfstab -L /mnt >/mnt/etc/fstab

# Allow wheel users to use sudo without command
echo "%wheel ALL=(ALL:ALL) NOPASSWD: ALL" >>/mnt/etc/sudoers

# And remove the script after installation
rm /mnt/inside_chroot.sh

# Now reboot the system and the post-install script shall be run
umount /mnt/boot
umount /mnt

reboot
