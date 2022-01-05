#!/bin/python3
# Shebang line so the script becomes executable

"""
Simple script that takes one or multiple screenshots, writes them and the 
captured clipboard to a csv file so they can later be converted to anki cards.
"""


from datetime import datetime
from os import popen, system
from os.path import normpath
from pathlib import Path
import sys
import logging
import subprocess

logging.basicConfig(
    filename=Path.home() / "screenshot_trigger.log", level=logging.DEBUG
)

logging.debug("argv: {}".format(sys.argv))

# logging.basicConfig()

if len(sys.argv) == 1:
    MODE = "C"
else:
    MODE = sys.argv[1]

assert MODE in ("D", "C", "I")

logging.debug("mode: {}".format(MODE))

screenshot_dir = Path.home() / "screenshots"
screenshot_dir.mkdir(exist_ok=True)

csv_file = screenshot_dir / "entries.csv"

logging.debug("Directory: {}".format(screenshot_dir))
logging.debug("csv file path: {}".format(csv_file))

if not csv_file.exists():
    # Create the csv file

    with csv_file.open("w") as f:

        # Write the column names
        f.write("image_paths(multiple),description\n")

if MODE == "D":

    # Delete last entry mode
    with csv_file.open("r+") as f:
        lines_written_before = f.readlines()
        f.seek(0)

        if len(lines_written_before) > 1:

            # Also delete the images capture in that last entry
            last_line = lines_written_before[-1]
            filenames = last_line.split(",")[:-1]

            for file_name in filenames:
                (screenshot_dir / file_name).unlink(missing_ok=True)

            for i in lines_written_before[:-1]:
                f.write(i)

            f.truncate()

    sys.exit(0)

# Now the csv file definitely exists

if MODE == "C":
    clipboard = popen("xclip -o").read()

    description = (
        '"'
        + clipboard.replace('"', '\\"')
        .replace("\n", "<br>")  # Escape returns for anki's html syntax
        .replace("\r", "<br>")
        + '"'
    )

    logging.debug("Captured clipboard: {}".format(description))
else:
    description = '""'

image_names = []

while True:
    # Also capture milliseconds
    image_name = (
        datetime.now().strftime("%Y-%m-%d---%H-%M-%S.%f")[:-3] + ".png"
    )

    # Take the screenshot and afterwards write the entry to the csv file
    screenshot_command = "sleep 0.1; scrot -s '{}'".format(
        screenshot_dir / image_name
    )
    logging.debug(
        "Executing screenshot command: '{}'".format(screenshot_command)
    )

    # rval = system(screenshot_command)

    completed_process = subprocess.run(
        screenshot_command, shell=True, capture_output=True
    )

    logging.debug("Return value: {}".format(completed_process))

    # Otherwise save description to csv file

    if completed_process.returncode != 0:
        break

    else:
        # It captured an image
        image_names.append(image_name)
        logging.debug("Captured image: {}".format(image_name))

# Now write the actual csv entry

if len(image_names) > 0:
    # Only write when any images have been captured

    entry_string = ""

    for img_name in image_names:
        entry_string += "{},".format(image_name)

    entry_string += description + "\n"

    with csv_file.open("a") as f:
        f.write(entry_string)

    logging.debug(
        "Captured {} images and wrote '''\n{}\n''' as entry".format(
            len(image_names), entry_string
        )
    )

else:
    logging.debug("No images captured, nothing to write down")
