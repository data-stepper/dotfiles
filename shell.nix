let
  pkgs = import <nixpkgs> {};
in
  pkgs.mkShell {
    name = "my-nix-environment";
    buildInputs = [
      pkgs.python311
      pkgs.curl # needed to download the get-pip.py script
    ];
    shellHook = ''
       # Run some shell commands after the shell is created
       python -m ensurepip --user
       python -m pip install --user --upgrade pip
    '';
  }
