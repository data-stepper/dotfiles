{ config, pkgs, ... }:

{
	# Import the other config files in this folder
	imports = [
		# ... other imports ...
		./zsh.nix
	];

  # Shared packages
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    neovim
    git
    xclip
    wget
    emacs
    google-chrome
    brave
    opera
    firefox
    obsidian
    pciutils
    htop
    st
    alacritty
    lf
    vscode
    jetbrains.pycharm-professional
    fira-code
    ibm-plex
    python311
    python311Packages.pip
		google-fonts
		noto-fonts-emoji
  ];

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

  services.xserver = {
    enable = true;
    libinput = {
    	enable = true;
	touchpad.tapping = true;
};
    layout = "us";
    xkbVariant = "";

	desktopManager = {
		xterm.enable = false;
};

	displayManager = {
		defaultSession = "none+i3";
};

	windowManager.i3 = {
		enable = true;
		extraPackages = with pkgs; [
			dmenu
			i3lock
			i3status
];
};
  };
}
