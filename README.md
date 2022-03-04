# My dotfiles repository

Welcome to my dotfiles repo, feel free to contribute if you like. My dotfiles are at the heart of the work I do, so I am planning to expand its usability, functionality and bare speed.

I use arch linux.

Disclaimer: In this state my dotfiles are still not matured and I would like to change that. Certain updates affect their functionality.
For this reason I am planning to switch to arch linux in the future. My only concern is that I did not yet find a way to implement
consistent and easy-to-use as well as easy to install Full Disk Encryption (FDE) which I enjoy on Kubuntu.

## Installation

UPDATE: Using arch linux from now on, rewrite this part as it needs to be updated.

## What I use - in detail

I started using vim8 some time ago and started building my own .vimrc which was at the time far from optimized and efficient.
Shortly after, I decided to comment my .vimrc and also switch to neovim as it provides more functionality in the future.

In the following I explain in detail which programs I use, what they do and how you can use them best.

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

### Neovim - the editor of choice

I use neovim, also installed as an ubuntu package. With neovim I use mainly the following plugins to assist coding or writing latex documents:

# TODO List

- [x] Installation script installs lf file manager
- [x] Installation script installs vim-plug
- [ ] Finish README.MD
- [ ] Find a way to do full disk encryption on arch linux

