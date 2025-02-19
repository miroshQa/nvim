import os
import subprocess
from libqtile import hook
from libqtile import bar, layout, qtile, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from qtile_extras.widget.decorations import RectDecoration
from colors import colors

mod = "mod4"
terminal = "wezterm"
font_size = 48
wallpaper = "~/.config/wallpapers/ancientcastle.jpg"
widget_radius = 18

keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),

    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),

    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "s", lazy.spawn("flameshot gui"), desc="Launch terminal"),
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    Key([mod], "f", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen on the focused window"),

    Key([mod], "t", lazy.window.toggle_floating(), desc="Toggle floating on the focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "r", lazy.spawn("rofi -show run"), desc="Spawn a command using a prompt widget"),

    Key([mod], "space",  lazy.widget["keyboardlayout"].next_keyboard()),
]


groups = [
    Group(
        i[0],
        label=i[1]
    )
    for i in [("1", "D"), ("2", ""), ("3", "󰈹"), ("4", "A"), ("5", "󰉋")]
]

for i in groups:
    keys.extend(
        [
            # mod + group number = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc=f"Switch to group {i.name}",
            ),
            # mod + shift + group number = switch to & move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc=f"Switch to & move focused window to group {i.name}",
            ),
        ]
    )

layouts = [
    layout.Columns(
        border_focus_stack=["#d75f5f", "#8f3d3d"],
        border_width=4,
        single_border_width=0,
        margin=8,
        border_focus=colors["color7"],
        border_normal=colors["color8"],
    ),
    layout.Max(margin=8),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    # layout.Matrix(),
    # layout.MonadTall(),
    # layout.MonadWide(),
    # layout.RatioTile(),
    # layout.Tile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]

widget_defaults = dict(
    font="Hack Nerd Font Mono",
    fontsize=30,
    padding=20,
)

extension_defaults = widget_defaults.copy()

sep_config = {
        "size_percent": 0,
        "padding": 8,
}

def get_backlight_device():
    """
    Detects and returns the first available backlight device.

    Returns:
        str: The name of the first available backlight device.
        None: If no backlight device is found.
    """
    backlight_dir = "/sys/class/backlight"
    if os.path.isdir(backlight_dir):
        devices = os.listdir(backlight_dir)
        if len(devices) > 0:
            return devices[0]
    return None

def get_wireless_interface():
    """
    Dynamically detect the wireless network interface.

    Returns:
        str: Name of the wireless network interface.
    """
    result = subprocess.run(["ip", "link"], capture_output=True, text=True, check=True)
    for line in result.stdout.split("\n"):
        if "wlan" in line or "wlp" in line:
            return line.split(":")[1].strip()
    return "wlan0"

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
                    decorations=[
                        RectDecoration(
                            colour=colors["background"],
                            radius=widget_radius,
                            filled=True,
                        )
                    ],
                ),
                widget.Spacer(),
                widget.Memory(
                    format="󰍛 {MemUsed:.0f}{mm}",
                    # decorations=[
                    #     RectDecoration(
                    #         colour=colors["background"],
                    #         radius=widget_radius,
                    #         filled=True,
                    #     )
                    # ],
                    foreground=colors["color5"],
                ),
                widget.Sep(**sep_config),
                widget.CPU(
                    format="󰘚 {load_percent}%",
                    # decorations=[
                    #     RectDecoration(
                    #         colour=colors["background"],
                    #         radius=widget_radius,
                    #         filled=True,
                    #     )
                    # ],
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
                    decorations=[
                        RectDecoration(
                            colour=colors["background"],
                            radius=widget_radius,
                            filled=True,
                        )
                    ],
                    foreground=colors["color3"],
                ),
                # widget.Wlan(
                #     fmt="  {}",
                #     format="{essid}",
                #     interface=get_wireless_interface(),
                #     foreground=colors["background"],
                # ),
                # widget.Systray(icon_size=font_size),
                widget.Clock(
                    format="󰥔 %I:%M",
                    decorations=[
                        RectDecoration(
                            colour=colors["background"],
                            radius=widget_radius,
                            filled=True,
                        )
                    ],
                    foreground=colors["color4"],
                ),
                widget.KeyboardLayout(configured_keyboards=['us','ru']),
            ],
            font_size,
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
        ),
        # You can uncomment this variable if you see that on X11 floating resize/moving is laggy
        # By default we handle these events delayed to already improve performance, however your system might still be struggling
        # This variable is set to None (no cap) by default, but you can set it to 60 to indicate that you limit it to 60 events per second
        background="#000000.3",
        x11_drag_polling_rate = 120,
        wallpaper = wallpaper,
        wallpaper_mode = "fill",
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []
follow_mouse_focus = True
bring_front_click = False
floats_kept_above = True
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"

@hook.subscribe.startup_once
def autostart():
    autostartup = [
        'setxkbmap -layout "us,ru"',
        'keymapper -u &',
        'dunst &',
        'xinput set-prop "ELAN2310:00 04F3:3238 Touchpad" "libinput Tapping Enabled" 1',
        'xinput set-prop "ELAN2310:00 04F3:3238 Touchpad" "libinput Natural Scrolling Enabled" 1',
    ]

    for cmd in autostartup:
        os.system(cmd)
