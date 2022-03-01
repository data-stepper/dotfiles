# Set up the prompt

# Download Znap, if it's not there yet.
[[ -f ~/.zplugins/zsh-snap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git ~/.zplugins/zsh-snap

source ~/.zplugins/zsh-snap/znap.zsh  # Start Znap

# `znap prompt` makes your prompt visible in just 15-40ms!
znap prompt sindresorhus/pure

# `znap source` automatically downloads and starts your plugins.
znap source marlonrichert/zsh-autocomplete
znap source zsh-users/zsh-autosuggestions
znap source zsh-users/zsh-syntax-highlighting

setopt histignorealldups sharehistory

# Also accept completion with Ctrl-Y
bindkey '^y' forward-word
bindkey '^e' end-of-line

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Source aliasrc file
source ~/.aliasrc

# lfcd command
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

# Added by Miniconda installer
# export PATH="/home/bent/miniconda3/bin:$PATH"  # commented out by conda initialize


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/bent/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/bent/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/bent/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/bent/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Don't use my PS1 anymore since pure's is better
# export PS1="%F{magenta} $CONDA_PROMPT_MODIFIER%F{blue}%~ %F{green}↳%F{default}"


