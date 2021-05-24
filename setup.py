import argparse
from os import system
import os
import sys
import getpass

USERNAME = getpass.getuser()
CWD = os.getcwd()

# bindings specifies all files that need copying
# each item is a tuple ("dotfile_name", "path_to_copy")
# Keep in mind that both can also be directories
bindings = [
    (".vimrc", f"/home/{USERNAME}/.vimrc"),  # Vim config file
    ("snippets/", f"/home/{USERNAME}/.vim/UltiSnips/"),  # Vim snippets directory
    ("./coc-settings.json", f"/home/{USERNAME}/.vim/coc-settings.json"),
    ("./.zshrc", f"/home/{USERNAME}/.zshrc"),  # zsh config file
    ("./compton.conf", f"/home/{USERNAME}/.config/compton.conf"),  # comp manager config
    ("./i3-config", f"/home/{USERNAME}/.config/i3/config"),  # window manager config
]

# System interaction functionality


def safe_mkdir(path_to_directory: str):

    rval = system(f"mkdir {path_to_directory}")

    if rval != 0:
        raise IOError(
            f"Failed to create directory at {path_to_directory} (ERROR: {rval})"
        )


def safe_copy(from_path: str, to_path: str):

    rval = system(f"cp -R {from_path} {to_path}")

    if rval != 0:
        raise IOError(f"Failed to copy from {from_path} to {to_path} (ERROR: {rval})")


# Vim setup / dotfiles sync


def recursive_directory_check(path: str):
    """Check whether all paths prepended to the path exist."""

    if path is None or path in ("/", ""):
        return True

    head, tail = os.path.split(path)

    if os.path.exists(path):
        return recursive_directory_check(head)
    else:
        return False


def file_exists_check(path: str):
    """Check whether a file exists either locally or in absolute path."""

    local_path = os.path.join(CWD, path)
    return recursive_directory_check(path) or recursive_directory_check(local_path)


def parse_path(path: str, target: bool = False):
    """Parses a path so the copy commands work correctly."""

    abs_path = os.path.abspath(path)

    assert os.path.exists(abs_path), f"Failed to convert {path} to absolute path."

    if os.path.isdir(abs_path) and not target:
        abs_path = os.path.join(abs_path, "*")

    return abs_path


def copy_bindings(repo_path: str, target_path: str):
    """Given the two paths find actions to take."""

    # First check if all prepended directories exist

    assert file_exists_check(repo_path), f"Couldn't find file at: '{repo_path}'"
    assert file_exists_check(target_path), f"Couldn't find file at: '{target_path}'"

    for source, target in bindings:

        abs_source, abs_target = parse_path(source), parse_path(target, target=True)

        cmd = "cp -R {} {}".format(abs_source, abs_target)

        rval = system(cmd)

        assert rval == 0, f"Copy command failed: '{cmd}'"


def copy_dependencies(install: bool):
    """Copy all dependency files (config-files) to their locations."""

    # repo path is the local filename / directory name
    # target_path is the path where to copy the files
    for repo_path, target_path in bindings:

        # If script should sync, then just swap the paths

        if install:
            copy_bindings(repo_path, target_path)

        else:
            copy_bindings(target_path, repo_path)


def main(install: bool = True):
    copy_dependencies(install=install)


def parse_args():

    # Default kwargs
    kwargs = {"install": True}

    if len(sys.argv) > 1:
        if sys.argv[1] == "install":
            kwargs["install"] = True
        elif sys.argv[1] == "sync":
            kwargs["install"] = False

    else:

        print(
            "ERROR: script must be called either with 'install' or 'sync' as first argument"
        )
        exit(1)

    return kwargs


if __name__ == "__main__":
    kwargs = parse_args()
    main(**kwargs)
