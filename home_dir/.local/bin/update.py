#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
    bin.update
    ~~~~~~~~~~

    Simple script to update my arch linux system.

    :copyright: (c) 2022 by Bent Mueller.
    :license: MIT, see LICENSE for more details.
"""

import os
from os import system, chdir
from pathlib import Path


def run_command(command):
    """Runs a command and returns the output."""
    rv = system(command)

    if rv != 0:
        raise IOError("Error occurred while running command: {}, {}".format(command, rv))


def sync_repository_at_path(path):
    """Syncs the repository at the given path."""

    chdir(path)
    run_command("git pull")
    run_command("git add -A")
    run_command("git commit -m 'Auto-Sync commit'")
    run_command("git push")


# Update with pacman
run_command("sudo pacman --noconfirm -Syu")

# Update with yay
run_command("sudo yay -Syu")
# TODO: Make this script run without confirmation.

# Sync the git repositories
git_dir = Path.home() / "git"

# Sync the dotfiles repository
sync_repository_at_path(git_dir / "dotfiles")

# And the notes repository
sync_repository_at_path(git_dir / "notes")
