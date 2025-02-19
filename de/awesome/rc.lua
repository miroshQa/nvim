-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local awful = require("awful")
require("awful.autofocus")
-- Theme handling library
local beautiful = require("beautiful")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
require("main.error_handling")
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
require("main.variables_definition")
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
require("main.menu")
-- }}}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar
-- Create a textclock widget
require("main.wibar")
-- }}}

-- {{{ Mouse bindings
require("main.mouse_bindings")
-- }}}

-- {{{ Key bindings
require("main.key_bindings")
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
require("main.rules")
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
require("main.signals")
-- }}}

-- GAPS
beautiful.useless_gap = 5

-- Startup shell commands
require("main.startup_cmd")
