
![Dark demo](/screenshots/demo_nvim_dark.png?raw=true "My neovim config in action")

# My dotfiles repository

Welcome to my dotfiles repo, feel free to contribute if you like. My dotfiles are at the heart of the work I do, so I am planning to expand its usability, functionality and bare speed.

I use arch linux with the i3 window manager and vscode / pycharm as my primary IDEs.
To be clear, my goals within my arch linux system is mostly bare speed
and functionality.

## Installation

On a fresh install of arch linux, install curl and run the following command:

```bash
pacman -S curl # Install curl

 curl -sSL https://raw.githubusercontent.com/data-stepper/dotfiles/installation_scripts/arch_bootstrap.bash | bash
```

After doing that reboot your system and run

```bash
 sudo bash ~/git/dotfiles/installation_scripts/post_install.sh
```

This will install all the necessary packages I use and will also take
quite some time to finish.

Then everything should be install properly. Basics after that:

```
 Mod + Enter: Open terminal (alacrity in this case)
 Mod + Shift + Enter: Open browser (brave)
```

Note that the `Mod` key is usually the Windows key (aka the Super key).

Note that most of the stuff is still WIP, so some things might break. Feel free to open an issue and contribute.

## What I use - in detail

### LF File Manager

LF is in my opinion the best terminal file manager out there. It is fast and distributed as a single binary.
Because I like it to open for example pdf files with zathura (my pdf viewer), my dotfiles ship with a config
file for lr called .lfrc.

Unfortunately, it is not yet available as an ubuntu package and thus needs to be installed manually by downloading from the following link.

```
 https://github.com/gokcehan/lf/releases/download/r24/lf-linux-amd64.tar.gz
```

After this you will need to unpack the binary and then move it with the following command:

```
 sudo mv Downloads/lf /bin
```

### Zathura PDF viewer

As I also work with latex, I use zathura as my primary PDF viewer. It is available as an ubuntu package and thus installed easily by the installation script.

### Compton Composition Manager

Compton is a tool I use to make my windows transparent, it is installed by the installation script as an ubuntu package.

(NOTE) How I like to crop pdf files:

```bash
 pdfcrop --margins 5 --clip <infile>.pdf <outfile>.pdf
```

# TODO List

- [x] Installation script installs lf file manager
- [x] Installation script installs vim-plug
- [ ] Finish README.MD
