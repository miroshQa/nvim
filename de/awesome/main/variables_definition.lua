local gears = require("gears") local awful = require("awful") local beautiful = require("beautiful")
beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")

beautiful.wallpaper = "/home/miron/.config/wallpapers/spaceman.jpg"


browser = "google-chrome"
terminal = "wezterm"
editor = "nvim"
editor_cmd = terminal .. " -e " .. editor

modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
  awful.layout.suit.tile,
  awful.layout.suit.floating,
  -- awful.layout.suit.corner.nw,
  -- awful.layout.suit.tile.bottom,
  -- awful.layout.suit.tile.top,
  -- awful.layout.suit.fair,
  -- awful.layout.suit.fair.horizontal,
  -- awful.layout.suit.spiral,
  -- awful.layout.suit.spiral.dwindle,
  -- awful.layout.suit.max,
  -- awful.layout.suit.max.fullscreen,
  -- awful.layout.suit.magnifier,
  -- awful.layout.suit.corner.nw,
  -- awful.layout.suit.corner.ne,
  -- awful.layout.suit.corner.sw,
  -- awful.layout.suit.corner.se,
}
