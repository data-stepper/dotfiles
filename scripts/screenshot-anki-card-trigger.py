from os import popen
from os.path import normpath
from pathlib import Path

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

path = Path(clipboard)
path = Path.home() / (str(path) + "_scrot.png")
path = normpath(path)

# This is actually a valid path now


print(path)
