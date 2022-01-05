#!/usr/bin/env python3
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

MODE = sys.argv[1]

assert MODE in ("D", "C", "I")

screenshot_dir = Path.home() / "screenshots"
screenshot_dir.mkdir(exist_ok=True)

csv_file = screenshot_dir / "entries.csv"

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
else:
    description = '""'

image_names = []

while True:
    # Also capture milliseconds
    image_name = (
        datetime.now().strftime("%Y-%m-%d---%H-%M-%S.%f")[:-3] + ".png"
    )

    # Take the screenshot and afterwards write the entry to the csv file
    screenshot_command = "scrot -s $HOME/screenshots/{}".format(image_name)

    rval = system(screenshot_command)

    # assert (
    #     rval == 0
    # ), "Error occurred taking screenshot, not saving description to csv file"

    # Otherwise save description to csv file

    if rval != 0:
        break
    else:
        # It captured an image
        image_names.append(image_name)

# Now write the actual csv entry

if len(image_names) > 0:
    # Only write when any images have been captured

    entry_string = ""

    for img_name in image_names:
        entry_string += "{},".format(image_name)

    entry_string += description + "\n"

    with csv_file.open("a") as f:
        f.write(entry_string)

    print(
        "Captured {} images and written '{}' as entry".format(
            len(image_names), entry_string
        )
    )

else:
    print("No images captured, nothing to write down")
