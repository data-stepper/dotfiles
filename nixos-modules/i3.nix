{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ xbacklight ];

  services.xserver.windowManager.i3 = {
    enable = true;
    config = builtins.readFile ./i3-config;
  };

}
