# My dotfiles repository

Welcome to my dotfiles repo, feel free to contribute if you like. My dotfiles are at the heart of the work I do, so I am planning to expand its usability, functionality and bare speed.

I use Kubuntu 20.04, neovim through nvim-qt ( as I prefer a graphical interface ) together with i3 window manager, nitrogen for wallpaper support and compton for window transparency.

Disclaimer: In this state my dotfiles are still not matured and I would like to change that. Certain updates affect their functionality.
For this reason I am planning to switch to arch linux in the future. My only concern is that I did not yet find a way to implement
consistent and easy-to-use as well as easy to install Full Disk Encryption (FDE) which I enjoy on Kubuntu.

## Installation

Follow the below described installation process to fully ulitize my dotfiles.

Download and install Kubuntu 20.04:

```
https://cdimage.ubuntu.com/kubuntu/releases/20.04.3/release/kubuntu-20.04.3-desktop-amd64.iso
```

After this, run the following commands in konsole to install my dotfiles:

```
sudo apt install git
mkdir git
cd git
git clone https://github.com/data-stepper/dotfiles
cd dotfiles
./install.sh
```

After this you will need to restart your PC, let i3 generate the default config file and zsh also generate a default .zshrc and then
run the install script again to override the configuration files.

Unfortunately not the entire installation process is automated yet, so after this you will still need to
install vim-plug (from https://github.com/junegunn/vim-plug ). But I copied here the exact shell command
you need to copy in order to install vim-plug for neovim.

```
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

After you have installed vim-plug, start a new nvim instance (alias v in shell) and run

```
:PlugInstall
```

which will install all vim plugins I use. Restart the vim instance and install the following CoC extensions:

```
:CocInstall coc-python coc-json coc-tabnine coc-snippets
```

After this you should be ready to go and start using my dotfiles.

## What I use - in detail

I started using vim8 some time ago and started building my own .vimrc which was at the time far from optimized and efficient.
Shortly after, I decided to comment my .vimrc and also switch to neovim as it provides more functionality in the future.

In the following I explain in detail which programs I use, what they do and how you can use them best.

### LF File Manager

LF is in my opinion the best terminal file manager out there. It is fast and distributed as a single binary.
Because I like it to open for example pdf files with zathura (my pdf viewer), my dotfiles ship with a config
file for lr called .lfrc.

```
https://github.com/gokcehan/lf/releases/download/r24/lf-linux-amd64.tar.gz
```
