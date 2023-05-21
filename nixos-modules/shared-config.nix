{ config, pkgs, ... }:

{
  # Import the other config files in this folder
  imports = [ ./zsh.nix ./packages.nix ];

  environment.shellAliases = {
    r = "rm -Rf";
    ll = "ls -l";
    la = "ls -A";
    l = "ls -CF";
    sdn = "sudo shutdown now";
    py = "python3";
    update =
      "sudo nixos-rebuild switch --upgrade && cp -R ~/git/dotfiles/home_dir/. ~";
    sync-homedir = "cp -R ~/git/dotfiles/home_dir/. ~";
  };

  # Set sound and other stuff I will forget otherwise
  hardware.pulseaudio.enable = true;
  sound.enable = true;
  security.sudo.wheelNeedsPassword = false;

  # And enable gnome keyring
  services.gnome.gnome-keyring.enable = true;

  # And set up the xserver
  services.xserver = {
    enable = true;
    libinput = {
      enable = true;
      touchpad.tapping = true;
    };
    layout = "us";
    xkbVariant = "";

    desktopManager = { xterm.enable = false; };

    displayManager = { defaultSession = "none+i3"; };

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [ dmenu i3lock i3status ];
    };

    # Key repeat rate and delay
    autoRepeatDelay = 250;
    autoRepeatInterval = 50;
  };
}
