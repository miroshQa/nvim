local awful = require("awful")
local gears = require("gears")
local hotkeys_popup = require("awful.hotkeys_popup")
local menubar = require("menubar")

globalkeys = gears.table.join(
  awful.key({ modkey }, "s", hotkeys_popup.show_help),
  awful.key({ modkey }, "[", awful.tag.viewprev),
  awful.key({ modkey }, "]", awful.tag.viewnext),
  awful.key({ modkey }, "space", function() mykeyboardlayout.next_layout() end),
  awful.key({ modkey }, "j", function() awful.client.focus.byidx(1) end),
  awful.key({ modkey }, "k", function() awful.client.focus.byidx(-1) end),

  -- Layout manipulation
  awful.key({ modkey, "Shift" }, "j", function() awful.client.swap.byidx(1) end),
  awful.key({ modkey, "Shift" }, "k", function() awful.client.swap.byidx(-1) end),
  awful.key({ modkey }, "u", awful.client.urgent.jumpto),
  awful.key({ modkey }, "Tab",
    function()
      awful.client.focus.history.previous()
      if client.focus then client.focus:raise() end
    end),

  -- Standard program
  awful.key({ modkey }, "Return", function() awful.spawn(terminal) end),
  awful.key({ modkey, "Shift" }, "r", awesome.restart),
  awful.key({ modkey, "Shift" }, "q", awesome.quit),
  awful.key({ modkey }, "l", function() awful.tag.incmwfact(0.05) end),
  awful.key({ modkey }, "h", function() awful.tag.incmwfact(-0.05) end),
  awful.key({ modkey, "Shift" }, "h", function() awful.tag.incnmaster(1, nil, true) end),
  awful.key(
    { modkey, "Shift" },
    "l",
    function() awful.tag.incnmaster(-1, nil, true) end,
    { description = "decrease the number of master clients", group = "layout" }),
  awful.key(
    { modkey, "Control" },
    "h",
    function() awful.tag.incncol(1, nil, true) end,
    { description = "increase the number of columns", group = "layout" }
  ),
  awful.key(
    { modkey, "Control" },
    "l",
    function() awful.tag.incncol(-1, nil, true) end,
    { description = "decrease the number of columns", group = "layout" }
  ),
  awful.key(
    { modkey, "Shift" },
    "space",
    function() awful.layout.inc(-1) end,
    { description = "select previous", group = "layout" }
  ),

  awful.key({ modkey, "Control" }, "n", function()
    local c = awful.client.restore()
    -- Focus restored client
    if c then
      c:emit_signal("request::activate", "key.unminimize", { raise = true })
    end
  end, { description = "restore minimized", group = "client" }),

  -- Prompt
  awful.key(
    { modkey },
    "r",
    function() awful.spawn.with_shell("rofi -show run") end,
    { description = "run prompt", group = "launcher" }
  )
)

clientkeys = gears.table.join(
  awful.key({ modkey }, "f", function(c)
    c.fullscreen = not c.fullscreen
    c:raise()
  end, { description = "toggle fullscreen", group = "client" }),
  awful.key({ modkey }, "q", function(c) c:kill() end, { description = "close", group = "client" }),
  awful.key(
    { modkey, "Control" },
    "space",
    awful.client.floating.toggle,
    { description = "toggle floating", group = "client" }
  ),
  awful.key(
    { modkey, "Control" },
    "Return",
    function(c) c:swap(awful.client.getmaster()) end,
    { description = "move to master", group = "client" }
  ),
  awful.key({ modkey }, "o", function(c) c:move_to_screen() end, { description = "move to screen", group = "client" }),
  awful.key(
    { modkey },
    "t",
    function(c) c.ontop = not c.ontop end,
    { description = "toggle keep on top", group = "client" }
  ),
  awful.key({ modkey }, "n", function(c)
    -- The client currently has the input focus, so it cannot be
    -- minimized, since minimized clients can't have the focus.
    c.minimized = true
  end, { description = "minimize", group = "client" }),

  awful.key({ modkey }, "m", function(c)
    c.maximized = not c.maximized
    c:raise()
  end),

  awful.key({ modkey, "Control" }, "m", function(c)
    c.maximized_vertical = not c.maximized_vertical
    c:raise()
  end),

  awful.key({ modkey, "Shift" }, "m", function(c)
    c.maximized_horizontal = not c.maximized_horizontal
    c:raise()
  end)
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
  globalkeys = gears.table.join(
    globalkeys,
    -- View tag only.
    awful.key({ modkey }, "#" .. i + 9, function()
      local screen = awful.screen.focused()
      local tag = screen.tags[i]
      if tag then
        tag:view_only()
      end
    end, { description = "view tag #" .. i, group = "tag" }),
    -- Toggle tag display.
    awful.key({ modkey, "Control" }, "#" .. i + 9, function()
      local screen = awful.screen.focused()
      local tag = screen.tags[i]
      if tag then
        awful.tag.viewtoggle(tag)
      end
    end, { description = "toggle tag #" .. i, group = "tag" }),
    -- Move client to tag.
    awful.key({ modkey, "Shift" }, "#" .. i + 9, function()
      if client.focus then
        local tag = client.focus.screen.tags[i]
        if tag then
          client.focus:move_to_tag(tag)
          -- https://stackoverflow.com/questions/71083570/how-to-keep-focusing-on-the-client-after-its-moved-to-a-new-tag-in-awesome-wm
          local screen = awful.screen.focused()
          local tag2 = screen.tags[i]
          tag2:view_only()
        end
      end
    end, { description = "move focused client to tag #" .. i, group = "tag" }),
    -- Toggle tag on focused client.
    awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9, function()
      if client.focus then
        local tag = client.focus.screen.tags[i]
        if tag then
          client.focus:toggle_tag(tag)
        end
      end
    end, { description = "toggle focused client on tag #" .. i, group = "tag" })
  )
end

clientbuttons = gears.table.join(
  awful.button({}, 1, function(c) c:emit_signal("request::activate", "mouse_click", { raise = true }) end),
  awful.button({ modkey }, 1, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
    awful.mouse.client.move(c)
  end),
  awful.button({ modkey }, 3, function(c)
    c:emit_signal("request::activate", "mouse_click", { raise = true })
    awful.mouse.client.resize(c)
  end)
)

-- Set keys
root.keys(globalkeys)
