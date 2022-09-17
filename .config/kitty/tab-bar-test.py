import subprocess
from collections import defaultdict

STATE = defaultdict(lambda: "", {"Paused": "", "Playing": ""})

def currently_playing():
    # TODO: Work out how to add python libraries so that I can query dbus directly
    # For now, implemented in a separate python project: dbus-player-status
    status = " "
    data = {"title": "hello", "artist": "", "state": ""}
    try:
        data["title"] = subprocess.getoutput("playerctl metadata title")
        data["artist"] = subprocess.getoutput("playerctl metadata artist")
        data["state"] = subprocess.getoutput("playerctl status")
    except ValueError:
        pass
    if data:
        if data["state"]:
            status = f"{status} {STATE[data['state']]}"
        if data["title"]:
            status = f"{status} {data['title']}"
        if data["artist"]:
            status = f"{status} - {data['artist']}"
    else:
        status = ""
    return status


battery_pct = subprocess.getoutput("upower -i /org/freedesktop/UPower/devices/battery_BAT1 | rg percentage | cut -d ':' -f 2 | tr -d ' ' | cut -d '%' -f 1")
print(battery_pct)
print(currently_playing())
