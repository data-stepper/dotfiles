# This is the part of the install script that needs to be run inside
# the arch-chroot

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

# Exit from the arch-chroot so the other script can continue running
exit
