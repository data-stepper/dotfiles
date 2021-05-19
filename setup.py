import argparse
from os import system
import os
import sys
import getpass

USERNAME = getpass.getuser()

# System interaction functionality

def safe_mkdir(path_to_directory: str):

    rval = system(f"mkdir {path_to_directory}")

    if rval != 0:
        raise IOError(f"Failed to create directory at {path_to_directory} (ERROR: {rval})")


def safe_copy(from_path: str, to_path: str):

    rval = system(f"cp -R {from_path} {to_path}")

    if rval != 0:
        raise IOError(f"Failed to copy from {from_path} to {to_path} (ERROR: {rval})")

# Vim setup / dotfiles sync

def setup_vim(install: bool):
    # This function handles everything with vim

    if install:

        # Copy vimrc
        safe_copy(".vimrc", "~/.vimrc")

        # If snippet directory doesn't exist, create it
        if not os.path.exists(f"/home/{USERNAME}/.vim/UltiSnips/"):
            print(f"Creating directory: '/home/{USERNAME}/.vim'")
            safe_mkdir(f"/home/{USERNAME}/.vim")

            print(f"Creating directory: '/home/{USERNAME}/.vim/UltiSnips'")
            safe_mkdir(f"/home/{USERNAME}/.vim/UltiSnips")


        # Copy snippet files
        safe_copy("snippets/*", f"/home/{USERNAME}/.vim/UltiSnips/")

        safe_copy("./coc-settings.json", f"/home/{USERNAME}/.vim/coc-settings.json")

    else:
        # install = False means sync the dotfiles to the repo

        # Copy vimrc
        safe_copy("~/.vimrc", ".vimrc")

        safe_copy(f"/home/{USERNAME}/.vim/UltiSnips/*", "snippets/")

        safe_copy(f"/home/{USERNAME}/.vim/coc-settings.json", "./coc-settings.json")


def setup_shell(install: bool):
    
    if install:

        safe_copy(".zshrc", "~/.zshrc")

    else:

        safe_copy("~/.zshrc", ".zshrc")


def main(install: bool = True):
    setup_vim(install=install)
    setup_shell(install=install)


def parse_args():
    
    # Default kwargs
    kwargs = {"install": True}

    if len(sys.argv) > 1:
        if sys.argv[1] == "install":
            kwargs["install"] = True
        elif sys.argv[1] == "sync":
            kwargs["install"] = False

    else:

        print("ERROR: script must be called either with 'install' or 'sync' as first argument")
        exit(1)


    return kwargs

if __name__ == "__main__":
    kwargs = parse_args()
    main(**kwargs)

