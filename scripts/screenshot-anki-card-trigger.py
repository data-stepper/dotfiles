from os import popen
from os.path import normpath
from pathlib import Path

clipboard = popen("xclip -o").read()

path = Path(clipboard)
path = Path.home() / (str(path) + "_scrot.png")
path = normpath(path)

# This is actually a valid path now


print(path)
