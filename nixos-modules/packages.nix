{ config, pkgs, ... }:

{
  # Shared packages
  environment.systemPackages = with pkgs; [
    # ##### EDITORS #####
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    neovim
    git
    xclip
    wget
    emacs
    vscode
    jetbrains.pycharm-professional
    # ##### BROWSERS AND OTHER PROGRAMS #####
    google-chrome
    brave
    opera
    firefox
    obsidian
    anki-bin
    thunderbird
    ungoogled-chromium
    # ##### UTILITIES #####
    pciutils
    htop
    st
    alacritty
    python311
    python311Packages.pip
    lf
    zsh
    ripgrep
    coreutils
    # ##### FONTS #####
    fira-code
    ibm-plex
    google-fonts
    noto-fonts-emoji
  ];
}
