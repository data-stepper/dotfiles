from os import popen, system
from os.path import normpath
from pathlib import Path
from datetime import datetime

screenshot_dir = Path.home() / "screenshots"
screenshot_dir.mkdir(exist_ok=True)

csv_file_path = screenshot_dir / "screenshots_data.csv"

if not csv_file_path.exists():
    # Create the csv file
    with csv_file_path.open("w") as f:

        # Write the column names
        f.write("image_path,description\n")

# Now the csv file definitely exists

clipboard = popen("xclip -o").read()

description = '"' + clipboard.replace('"', '\\"') + '"'

image_name = datetime.now().strftime("%Y-%m-%d---%H-%M-%S") + ".png"

# Take the screenshot and afterwards write the entry to the csv file
screenshot_command = "scrot -s $HOME/screenshots/{}".format(image_name)

rval = system(screenshot_command)

assert (
    rval == 0
), "Error occurred taking screenshot, not saving description to csv file"

# Otherwise save description to csv file

with csv_file_path.open("a") as f:
    f.write("{},{}\n".format(image_name, description))

print(description)
print(screenshot_command)
print("Successfully written everything to files")
