local moves_counter = 0

local awful = require("awful")

awful.spawn.with_shell('setxkbmap -layout "us,ru"')
awful.spawn.with_shell("keymapper -u")

-- https://askubuntu.com/questions/403113/how-do-you-enable-tap-to-click-via-command-line
awful.spawn.with_shell([[xinput set-prop "ELAN2310:00 04F3:3238 Touchpad" "libinput Tapping Enabled" 1]])
awful.spawn.with_shell([[xinput set-prop "ELAN2310:00 04F3:3238 Touchpad" "libinput Natural Scrolling Enabled" 1]])

-- https://superuser.com/questions/1374096/how-do-i-start-an-application-from-awesomes-rc-lua-if-its-not-already-running
local function run_if_not_running(program)
  awful.spawn.easy_async(
    "pgrep -f " .. program,
    function(stdout, stderr, reason, exit_code)
      if stdout == "" then
        awful.spawn(program .. " ")
      end
    end)
end

client.connect_signal("manage", function(c)
  if moves_counter >= 3 then
    return
  end
  local tags = awful.tag.gettags(1)
  if c.class == "Google-chrome" then
    awful.client.movetotag(tags[3], c)
    moves_counter = moves_counter + 1
  elseif c.class == "org.wezfurlong.wezterm" then
    awful.client.movetotag(tags[2], c)
    moves_counter = moves_counter + 1
  elseif c.class == "Anki" then
    awful.client.movetotag(tags[4], c)
    moves_counter = moves_counter + 1
  end
end)

run_if_not_running("wezterm")
run_if_not_running("google-chrome")
run_if_not_running("anki")
