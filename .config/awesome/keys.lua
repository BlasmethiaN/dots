-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")

-- Theme handling library
local beautiful = require("beautiful")

local volume = require("util.volume")

require("globals")

local keys = {global_keys = {}, client_keys = {}}

-- General Awesome keys
keys.global_keys = gears.table.join(keys.global_keys,
awful.key({MODKEY}, "s", hotkeys_popup.show_help, {
  description = "show help",
  group = "awesome"
}), awful.key({MODKEY, "Control"}, "r", awesome.restart, {
  description = "reload awesome",
  group = "awesome"
}), awful.key({MODKEY, "Shift"}, "q", awesome.quit, {
  description = "quit awesome",
  group = "awesome"
}), awful.key({MODKEY}, "Return", function()
  awful.spawn(TERMINAL)
end, {
  description = "open a terminal",
  group = "launcher"
}), awful.key({MODKEY}, "r", function()
  awful.util.spawn("rofi -show run")
end, {
  description = "rofi run prompt",
  group = "launcher"
}), awful.key({MODKEY}, "p", function()
  awful.util.spawn("rofi -show")
end, {
  description = "rofi window switch",
  group = "launcher"
}))

-- Tags related keybindings
keys.global_keys = gears.table.join(keys.global_keys, 
awful.key({MODKEY}, "Left", awful.tag.viewprev, {
  description = "view previous",
  group = "tag"
}), awful.key({MODKEY}, "Right", awful.tag.viewnext, {
  description = "view next",
  group = "tag"
}), awful.key({MODKEY}, "Escape", awful.tag.history.restore, {
  description = "go back",
  group = "tag"
}))

-- Focus related keybindings
keys.global_keys = gears.table.join(keys.global_keys, 
awful.key({MODKEY}, "j", function()
  awful.client.focus.byidx(1)
end, {
  description = "focus next by index",
  group = "client"
}), awful.key({MODKEY}, "k", function()
  awful.client.focus.byidx(-1)
end, {
  description = "focus previous by index",
  group = "client"
}), awful.key({MODKEY}, "Tab", function()
  awful.client.focus.history.previous()
  if client.focus then
      client.focus:raise()
  end
end, {
  description = "go back",
  group = "client"
}), awful.key({MODKEY, "Control"}, "j", function()
  awful.screen.focus_relative(1)
end, {
  description = "focus the next screen",
  group = "screen"
}), awful.key({MODKEY, "Control"}, "k", function()
  awful.screen.focus_relative(-1)
end, {
  description = "focus the previous screen",
  group = "screen"
}), awful.key({MODKEY, "Control"}, "n", function()
  local c = awful.client.restore()
  -- Focus restored client
  if c then
      c:activate{
          raise = true,
          context = "key.unminimize"
      }
  end
end, {
  description = "restore minimized",
  group = "client"
}))

-- Layout related keybindings
keys.global_keys = gears.table.join(keys.global_keys, 
awful.key({MODKEY, "Shift"}, "j", function()
  awful.client.swap.byidx(1)
end, {
  description = "swap with next client by index",
  group = "client"
}), awful.key({MODKEY, "Shift"}, "k", function()
  awful.client.swap.byidx(-1)
end, {
  description = "swap with previous client by index",
  group = "client"
}), awful.key({MODKEY}, "u", awful.client.urgent.jumpto, {
  description = "jump to urgent client",
  group = "client"
}), awful.key({MODKEY}, "l", function()
  awful.tag.incmwfact(0.05)
end, {
  description = "increase master width factor",
  group = "layout"
}), awful.key({MODKEY}, "h", function()
  awful.tag.incmwfact(-0.05)
end, {
  description = "decrease master width factor",
  group = "layout"
}), awful.key({MODKEY, "Shift"}, "h", function()
  awful.tag.incnmaster(1, nil, true)
end, {
  description = "increase the number of master clients",
  group = "layout"
}), awful.key({MODKEY, "Shift"}, "l", function()
  awful.tag.incnmaster(-1, nil, true)
end, {
  description = "decrease the number of master clients",
  group = "layout"
}), awful.key({MODKEY, "Control"}, "h", function()
  awful.tag.incncol(1, nil, true)
end, {
  description = "increase the number of columns",
  group = "layout"
}), awful.key({MODKEY, "Control"}, "s", function()
  awful.tag.incncol(-1, nil, true)
end, {
  description = "decrease the number of columns",
  group = "layout"
}), awful.key({MODKEY}, "space", function()
  awful.layout.inc(1)
end, {
  description = "select next",
  group = "layout"
}), awful.key({MODKEY, "Shift"}, "space", function()
  awful.layout.inc(-1)
end, {
  description = "select previous",
  group = "layout"
}))

keys.global_keys = gears.table.join(keys.global_keys,
awful.key {
  modifiers = {MODKEY},
  keygroup = "numrow",
  description = "only view tag",
  group = "tag",
  on_press = function(index)
      local screen = awful.screen.focused()
      local tag = screen.tags[index]
      if tag then
          tag:view_only()
      end
  end
}, awful.key {
  modifiers = {MODKEY, "Control"},
  keygroup = "numrow",
  description = "toggle tag",
  group = "tag",
  on_press = function(index)
      local screen = awful.screen.focused()
      local tag = screen.tags[index]
      if tag then
          awful.tag.viewtoggle(tag)
      end
  end
}, awful.key {
  modifiers = {MODKEY, "Shift"},
  keygroup = "numrow",
  description = "move focused client to tag",
  group = "tag",
  on_press = function(index)
      if client.focus then
          local tag = client.focus.screen.tags[index]
          if tag then
              client.focus:move_to_tag(tag)
          end
      end
  end
}, awful.key {
  modifiers = {MODKEY, "Control", "Shift"},
  keygroup = "numrow",
  description = "toggle focused client on tag",
  group = "tag",
  on_press = function(index)
      if client.focus then
          local tag = client.focus.screen.tags[index]
          if tag then
              client.focus:toggle_tag(tag)
          end
      end
  end
}, awful.key {
  modifiers = {MODKEY},
  keygroup = "numpad",
  description = "select layout directly",
  group = "layout",
  on_press = function(index)
      local t = awful.screen.focused().selected_tag
      if t then
          t.layout = t.layouts[index] or t.layout
      end
  end
})

-- Custom keybindings
keys.global_keys = gears.table.join(keys.global_keys, 
  awful.key({MODKEY, "Control"}, "l", function()
  awful.spawn("betterlockscreen -l --off 2")
end, {
  description = "lock the screen",
  group = "custom"
}), awful.key({"Shift"}, "Print", function()
  awful.spawn("selection_screenshot")
end, {
  description = "select area and copy screenshot",
  group = "custom"
}), awful.key({}, "XF86AudioRaiseVolume", function()
  volume.up()
  beautiful.update_volume()
end, {
  description = "raise volume",
  group = "audio"
}), awful.key({}, "XF86AudioLowerVolume", function()
  volume.down()
  beautiful.update_volume()
end, {
  description = "lower volume",
  group = "audio"
}), awful.key({}, "XF86AudioMute", function()
  volume.toggle()
  beautiful.update_volume()
end, {
  description = "mute output",
  group = "audio"
}), awful.key({MODKEY}, ".", function()
  awful.spawn("emoji")
end, {
  description = "gitmoji picker",
  group = "custom"
}), awful.key({MODKEY, "Shift"}, ".", function()
  awful.spawn("rofi-gitmoji")
end, {
  description = "gitmoji picker",
  group = "custom"
}),

awful.key({}, "XF86MonBrightnessUp", function()
  awful.spawn("xbacklight -inc 20") 
end, {
  description = "brightness up",
  group = "video"
}),
  awful.key({}, "XF86MonBrightnessDown", function()
    awful.spawn("xbacklight -dec 20")
end, {
  description = "brightness down",
  group = "video"
})
)

keys.client_keys = gears.table.join(keys.client_keys, awful.key({MODKEY}, "f", function(c)
  c.fullscreen = not c.fullscreen
  c:raise()
end, {
  description = "toggle fullscreen",
  group = "client"
}), awful.key({MODKEY}, "q", function(c)
  c:kill()
end, {
  description = "close",
  group = "client"
}), awful.key({MODKEY, "Control"}, "space", awful.client.floating.toggle, {
  description = "toggle floating",
  group = "client"
}), awful.key({MODKEY, "Control"}, "Return", function(c)
  c:swap(awful.client.getmaster())
end, {
  description = "move to master",
  group = "client"
}), awful.key({MODKEY}, "o", function(c)
  c:move_to_screen()
end, {
  description = "move to screen",
  group = "client"
}), awful.key({MODKEY}, "t", function(c)
  c.ontop = not c.ontop
end, {
  description = "toggle keep on top",
  group = "client"
}), awful.key({MODKEY}, "n", function(c)
  -- The client currently has the input focus, so it cannot be
  -- minimized, since minimized clients can't have the focus.
  c.minimized = true
end, {
  description = "minimize",
  group = "client"
}), awful.key({MODKEY}, "m", function(c)
  c.maximized = not c.maximized
  c:raise()
end, {
  description = "(un)maximize",
  group = "client"
}), awful.key({MODKEY, "Control"}, "m", function(c)
  c.maximized_vertical = not c.maximized_vertical
  c:raise()
end, {
  description = "(un)maximize vertically",
  group = "client"
}), awful.key({MODKEY, "Shift"}, "m", function(c)
  c.maximized_horizontal = not c.maximized_horizontal
  c:raise()
end, {
  description = "(un)maximize horizontally",
  group = "client"
}))

root.keys(keys.global_keys)

return keys
