#!/usr/bin/python3

from datetime import datetime

# This script gets and formats system uptime
# The formatted uptime is displayed in the status bar via i3status
with open("/proc/uptime", "r") as f:
    utime = f.read()

idx = utime.find(" ")
utime = utime[:idx]

utime = float(utime) - 3600
tm = datetime.fromtimestamp(utime)
formatted = tm.strftime("%H:%M:%S")

with open("/tmp/uptime", "w") as f:
    f.write(formatted)
