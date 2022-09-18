import datetime
import subprocess
from collections import defaultdict

from kitty.boss import get_boss
from kitty.fast_data_types import Screen, add_timer
from kitty.tab_bar import (
    DrawData,
    ExtraData,
    Formatter,
    TabBarData,
    as_rgb,
    draw_attributed_string,
    draw_tab_with_powerline,
)


timer_id = None


def draw_tab(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    before: int,
    max_title_length: int,
    index: int,
    is_last: bool,
    extra_data: ExtraData,
) -> int:
    global timer_id

    # if timer_id is None:
    #     timer_id = add_timer(_redraw_tab_bar, 2.0, True)
    # draw_logo(draw_data, screen)
    draw_tab_with_powerline(
        draw_data, screen, tab, before, max_title_length, index, is_last, extra_data
    )
    if is_last:
        draw_right_status(draw_data, screen)
    return screen.cursor.x

def draw_logo(draw_data: DrawData, screen: Screen):
    tab_bg = as_rgb(int(draw_data.inactive_bg))
    tab_fg = as_rgb(int(draw_data.active_fg))
    logo_bg = as_rgb(0xfb4934)
    user_bg = as_rgb(0xd65c0e)
    player_bg = as_rgb(0x3c3836)
    battery_bg = as_rgb(0x504945)
    next_bg = as_rgb(0x665c54)
    time_bg = as_rgb(0x7c6f64)
    default_bg = as_rgb(int(draw_data.default_bg))

    # The tabs may have left some formats enabled. Disable them now.
    draw_attributed_string(Formatter.reset, screen)
    cells = [" ", "  "]

    for cell in cells:
        if cell == cells[0]:
            screen.cursor.fg = logo_bg
            screen.cursor.bg = default_bg
            screen.draw("")
            screen.cursor.bg = logo_bg
            screen.cursor.fg = tab_bg
        elif cell == cells[1]:
            screen.cursor.fg = logo_bg
            screen.cursor.bg = default_bg
            screen.draw("")
            screen.cursor.bg = default_bg
            screen.cursor.fg = tab_fg
        screen.draw(f"{cell}")
    draw_attributed_string(Formatter.reset, screen)


def draw_right_status(draw_data: DrawData, screen: Screen) -> None:
    # The tabs may have left some formats enabled. Disable them now.
    draw_attributed_string(Formatter.reset, screen)
    cells = create_cells()
    # Drop cells that wont fit
    while True:
        if not cells:
            return
        padding = screen.columns - screen.cursor.x - sum(len(c) for c in cells) - len(cells) + 1
        if padding >= 0:
            break
        cells = cells[1:]

    if padding:
        screen.draw(" " * padding)

    tab_bg = as_rgb(int(draw_data.inactive_bg))
    tab_fg = as_rgb(int(draw_data.active_fg))
    logo_bg = as_rgb(0xfb4934)
    user_bg = as_rgb(0xd65c0e)
    player_bg = as_rgb(0x3c3836)
    battery_bg = as_rgb(0x504945)
    next_bg = as_rgb(0x665c54)
    time_bg = as_rgb(0x7c6f64)
    default_bg = as_rgb(int(draw_data.default_bg))

    for cell in cells:
        # Draw the separator
        if cell == cells[0]:
            screen.cursor.fg = user_bg
            screen.draw("")
            screen.cursor.bg = user_bg
            screen.cursor.fg = tab_fg
        elif cell == cells[1]:
            screen.cursor.fg = player_bg
            screen.cursor.bg = user_bg
            screen.draw("")
            screen.cursor.fg = tab_fg
            screen.cursor.bg = player_bg
        elif cell == cells[2]:
            screen.cursor.fg = battery_bg
            screen.cursor.bg = player_bg
            screen.draw("")
            screen.cursor.fg = tab_fg
            screen.cursor.bg = battery_bg
        elif cell == cells[3]:
            screen.cursor.fg = next_bg
            screen.cursor.bg = battery_bg
            screen.draw("")
            screen.cursor.fg = tab_fg
            screen.cursor.bg = next_bg
        elif cell == cells[4]:
            screen.cursor.fg = time_bg
            screen.cursor.bg = next_bg
            screen.draw("")
            screen.cursor.fg = tab_fg
            screen.cursor.bg = time_bg
        elif cell == cells[5]:
            screen.cursor.fg = tab_fg
            screen.cursor.bg = time_bg
        elif cell == cells[6]:
            screen.cursor.fg = logo_bg
            screen.cursor.bg = time_bg
            screen.draw("")
            screen.cursor.bg = logo_bg
            screen.cursor.fg = tab_bg
        elif cell == cells[7]:
            screen.cursor.fg = logo_bg
            screen.cursor.bg = default_bg
            screen.draw("")
            screen.cursor.bg = default_bg
            screen.cursor.fg = tab_fg
        screen.draw(f"{cell}")


def create_cells() -> list[str]:
    now = datetime.datetime.now()
    return [
        get_username(),
        currently_playing(),
        get_battery_status(),
        get_next_cell(),
        now.strftime("  %a %d.%m. "),
        now.strftime(" %H:%M "),
        get_logo(),
        get_empty_cell()
    ]

def get_logo():
    logo = " "
    return f"{logo}"

def get_username():
    username = subprocess.getoutput("echo $USER")
    return f"{username} "

def get_battery_status():
    try:
        battery_pct = int(subprocess.getoutput("upower -i /org/freedesktop/UPower/devices/battery_BAT1 | rg percentage | cut -d ':' -f 2 | tr -d ' ' | cut -d '%' -f 1"))
    except Exception:
        status = "  "
    else:
        if battery_pct == 0:
            status = "  "
        else:
            status = f" {battery_pct}% {''[battery_pct // 10]} "
    return f"{status}"

def get_next_cell():
    content = ""
    return f"{content}"

def get_empty_cell():
    empty = " "
    return f"{empty}"

STATE = defaultdict(lambda: "", {"Paused": "", "Playing": ""})


def currently_playing():
    # TODO: Work out how to add python libraries so that I can query dbus directly
    # For now, implemented in a separate python project: dbus-player-status
    status = "  "
    data = {"title": "", "artist": "", "state": ""}
    try:
        data["title"] = subprocess.getoutput("playerctl metadata title")[0:10]
        data["artist"] = subprocess.getoutput("playerctl metadata artist")[0:10]
        data["state"] = subprocess.getoutput("playerctl status")
    except ValueError:
        pass
    if data["state"] == "No players found":
        status = " "
    elif data:
        if data["state"]:
            status = f"{status} {STATE[data['state']]}"
        if data["title"]:
            status = f"{status} {data['title']}"
        if data["artist"]:
            status = f"{status} - {data['artist']}"
    else:
        status = " "
    return f"{status} "


def _redraw_tab_bar(timer_id):
    for tm in get_boss().all_tab_managers:
        tm.mark_tab_bar_dirty()
