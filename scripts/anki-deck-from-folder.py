#!/usr/bin/python3
# Optional shebang interpreter line (if script shall be executable)


"""
This script can create an anki deck from some raw pictures or in my special
case the folder containing images and a csv file specifying how the entries
(the actual anki cards) are structured.
"""

import argparse
import logging
from os import system, linesep
from os.path import normpath
from datetime import datetime
from pathlib import Path
from pprint import pformat
from collections import namedtuple

date_fmt = datetime.now().strftime("%Y-%m-%d--%H:%M:%S.%f")[:-3]

decks_directory = Path.home() / "anki_decks"
decks_directory.mkdir(exist_ok=True)

Entry = namedtuple("Entry", "files description")


def create_dirs(deck_name: str):
    deck_dir = decks_directory / deck_name
    deck_dir.mkdir(exist_ok=False)

    return deck_dir


def read_and_parse_entry_file(path_to_entry_file, dir_path):
    assert path_to_entry_file.exists() and not path_to_entry_file.is_dir()

    entries = []

    with path_to_entry_file.open("r") as f:
        # Skip the first line
        for line in f.readlines()[1:]:
            items = line[:-1].split(",")

            *files, description = items

            print(files)

            # files = list(map(lambda f: str(dir_path / f), files))
            description = str(description)

            entries.append(Entry(files=files, description=description))

    return entries


def parse_path(path):

    path = Path(path)

    if path.is_dir():
        logging.info("Directory given: '{}'".format(path))

        entry_file = path / "entries.csv"

        # Now read and parse the entry file
        parsed_entries = read_and_parse_entry_file(entry_file, path)

        logging.info(
            "Parsed {} entries from folder".format(len(parsed_entries))
        )

        logging.debug("Entries read: {}".format(pformat(parsed_entries)))

        return parsed_entries


def format_image(image_path):

    return '<img src="{}" /><br>'.format(image_path)


def format_entry(entry):

    if entry.description != '""':
        front = entry.description
        back = [format_image(f) for f in entry.files]

    else:
        front = format_image(entry.files[0])
        back = [format_image(f) for f in entry.files[1:]]

    back = "".join(back)

    e = "{} ,{}".format(front, back) + linesep

    return e


def create_deck(entries, target_csv_file):

    with target_csv_file.open("w") as f:
        for entry in entries:

            # Write entry to file
            f.write(format_entry(entry))

    with target_csv_file.open("r") as f:
        logging.debug((f.read()))

    logging.info("Written deck to '{}'".format(target_csv_file))


def main(args):
    logging.info("Args given: {}".format(pformat(args)))

    entries = parse_path(args.path)
    deck_dir = create_dirs(args.name)

    logging.info("Deck will be written to '{}'".format(deck_dir))

    # Copy the source files to be able to recreate the deck later on

    target_dir = deck_dir / "screenshots_source"
    target_dir.mkdir()

    assert (
        system("cp -Rf {} {}".format(str(args.path) + "/*", str(target_dir)))
        == 0
    )

    logging.info("Copied source files into '{}'".format(target_dir))

    create_deck(entries, deck_dir / "deck.tsv")

    # Copy the source files into the anki collections directory
    anki_collections = Path.home() / normpath(
        ".local/share/Anki2/User\ 1/collection.media"
    )

    copy_command = "sudo cp {} {}".format(
        str(args.path) + "/*.png", anki_collections
    )

    assert system(copy_command) == 0

    print(copy_command)


def setup_logging(args):

    FORMAT = "%(asctime)s %(levelname)s: %(message)s"

    if args.verbose:
        level = logging.DEBUG
    else:
        level = logging.INFO

    if args.logfile is not None:

        # Log to file
        logging.basicConfig(filename=args.logfile, level=level, format=FORMAT)

    else:

        logging.basicConfig(level=level, format=FORMAT)


def parse_args():

    parser = argparse.ArgumentParser(description=__doc__)

    ## Notice:
    # Optional arguments start with a '-', positionals do not

    # Verbose logging
    parser.add_argument(
        "-v",
        "--verbose",
        dest="verbose",
        action="store_true",
        help="Lowest loglevel",
        default=False,
    )

    # Logfile argument
    parser.add_argument(
        "--logfile",
        type=str,
        dest="logfile",
        default=None,
        metavar="<filepath>",
        help="Write log output to a file",
    )

    parser.add_argument(
        "--path",
        default=str(Path.home() / "screenshots"),
        type=str,
        help=(
            "Files or folder to process. If a folder is given, the programm"
            " will process all files found inside the folder."
        ),
    )

    parser.add_argument(
        "--name",
        metavar="<deck name>",
        type=str,
        help="Name of the anki deck",
        default="deck_{}".format(date_fmt),
    )

    return parser.parse_args()


if __name__ == "__main__":
    args = parse_args()
    setup_logging(args)
    main(args)
