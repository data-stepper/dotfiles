{ config, pkgs, ... }:

{
  # Import the other config files in this folder
  imports = [ ./zsh.nix ./st.nix ./packages.nix ];

  environment.shellAliases = {
    r = "rm -Rf";
    ll = "ls -l";
    la = "ls -A";
    l = "ls -CF";
  };

  # Shared settings, e.g., for shell
  programs.bash.promptInit = ''
    PS1="[\u@\h \W]\$ "
  '';

  # Set sound and other stuff I will forget otherwise
  hardware.pulseaudio.enable = true;
  sound.enable = true;
  security.sudo.wheelNeedsPassword = false;

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
  };
}
