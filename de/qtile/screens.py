from libqtile import hook
from libqtile import bar, layout, qtile, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from qtile_extras.widget.decorations import RectDecoration
from colors import colors
from utils import *


widget_radius = 18
font_size = 48
wallpaper = "~/.config/wallpapers/ancientcastle.jpg"

sep_config = {
        "size_percent": 0,
        "padding": 8,
}

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(
                    borderwidth=0,
                    block_highlight_text_color=colors["color3"],
                    active=colors["foreground"],
                    inactive=colors["color8"],
                    disable_drag=True,
                    radius=True,
                    padding_x=0,
                    margin_x=28,
                ),
                widget.Spacer(),
                widget.Clock(
                    format="󰥔 %I:%M",
                    foreground=colors["color4"],
                ),
                widget.Memory(
                    format="󰍛 {MemUsed:.0f}{mm}",
                    foreground=colors["color5"],
                ),
                widget.Sep(**sep_config),
                widget.CPU(
                    format="󰘚 {load_percent}%",
                    foreground=colors["color6"],
                ),
                widget.Volume(
                    mute_format='', 
                    unmute_format='  {volume}%', 
                    step=5,
                    foreground=colors["color6"],
                ),
                widget.Battery(
                    format="{char} {percent:2.0%}",
                    charge_char="󰂄",
                    discharge_char="󰁹",
                    empty_char="󰂃",
                    full_char="󰁹",
                    show_short_text=False,
                    not_charging_char="󰁹",
                    foreground=colors["color2"],
                ),
                widget.Backlight(
                    fmt="󰃚 {}",
                    backlight_name=get_backlight_device(),
                    foreground=colors["color3"],
                ),
                widget.KeyboardLayout(configured_keyboards=['us','ru']),
            ],
            font_size,
            opacity = 0.9,
        ),
        x11_drag_polling_rate = 120,
        wallpaper = wallpaper,
        wallpaper_mode = "fill",
    ),
]
