{ pkgs, ... }:

let
  zsh = pkgs.zsh;
  zshCompletion = pkgs.zsh-completions;
  zshSyntaxHighlighting = pkgs.zsh-syntax-highlighting;
  zshAutosuggestions = pkgs.zsh-autosuggestions;
  ohMyZsh = pkgs.oh-my-zsh;
  iwd = pkgs.iwd;
  pulseaudio = pkgs.pulseaudio;
in {
  environment.systemPackages = with pkgs; [
    zsh
    zshCompletion
    zshSyntaxHighlighting
    zshAutosuggestions
    ohMyZsh
    iwd
    pulseaudio
  ];

  programs.zsh.enable = true;
  users.defaultUserShell = zsh;

  environment.etc."zshrc".text = ''
    export ZSH=${ohMyZsh}/share/oh-my-zsh/

    ZSH_THEME="robbyrussell"

    plugins=(git pip)

    source $ZSH/oh-my-zsh.sh

    # Enable vi mode
    bindkey -v

    # Set up history
    HISTFILE=~/.zsh_history
    HISTSIZE=1000
    SAVEHIST=1000
    setopt INC_APPEND_HISTORY
    setopt SHARE_HISTORY
    setopt HIST_EXPIRE_DUPS_FIRST
    setopt HIST_IGNORE_DUPS

    # Load zsh completions
    fpath+=${zshCompletion}/share/zsh/site-functions
    fpath+=${zshCompletion}/share/zsh/site-functions
    fpath+=${pkgs.iwd}/share/zsh/vendor-completions
    fpath+=${pkgs.pulseaudio}/share/zsh/vendor-completions

    autoload -Uz compinit && compinit

    # Load zsh syntax highlighting
    source ${zshSyntaxHighlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

    # Load zsh autosuggestions
    source ${zshAutosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh

    # lfcd command and keybinding
    lfcd () {
            tmp="$(mktemp)"
            lf -last-dir-path="$tmp" "$@"
            if [ -f "$tmp" ]; then
                    dir="$(cat "$tmp")"
                    rm -f "$tmp"
                    [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
            fi
    }

    # Bind Ctrl-o to file manager
    bindkey -s '^o' 'lfcd\n'

    # And bind Ctrl-v to vim mode
    bindkey -s '^v' 'nvim .\n'
  '';
}
