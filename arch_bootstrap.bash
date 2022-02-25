#!/bin/bash

# This install script is based on the following arch wiki article:
# https://wiki.archlinux.de/title/Anleitung_f%C3%BCr_Einsteiger

echo "Welcome to Bent's arch bootstrap script\n"

# Check here if base58 is really always installed
ROOT_PASSWORD=$(dd status=none bs=18 count=1 if=/dev/urandom | base58)

read -r -p "Your root password is '$ROOT_PASSWORD', please write it down" -a arr

read -r -p "Please enter your username: " -a arr
HOSTNAME=${arr[0]}

read -r -p "Please enter the password you want to use: " -a arr
USERPASSWORD=${arr[0]}

read -r -p "Please enter the diskname you want to install arch linux on: " -a arr
DISKNAME=${arr[0]}

# TODO: Here pipe in the commands to partition the disks with gdisk
# Commands taken from here: https://wiki.archlinux.de/title/Gdisk
printf "" | gdisk /dev/$DISKNAME



