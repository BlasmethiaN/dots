-- awesome_mode: api-level=4:screen=on
-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
-- Declarative object management
local ruled = require("ruled")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- Custom widgets
local battery_widget = require("widgets.battery")

-- Global variables
require("globals")

-- Keybindings
local keys = require("keys")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
naughty.connect_signal("request::display_error", function(message, startup)
    naughty.notification {
        urgency = "critical",
        title = "Oops, an error happened" .. (startup and " during startup!" or "!"),
        message = message
    }
end)
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
local theme_path = string.format('%s/.config/awesome/themes/%s/theme.lua', os.getenv('HOME'), 'default')
beautiful.init(theme_path)

-- {{{ Tag
-- Table of layouts to cover with awful.layout.inc, order matters.
tag.connect_signal("request::default_layouts", function()
    awful.layout.append_default_layouts({
      awful.layout.suit.tile,
      awful.layout.suit.tile.bottom,
      -- awful.layout.suit.tile.left,
      -- awful.layout.suit.tile.top,
      -- awful.layout.suit.fair,
      -- awful.layout.suit.fair.horizontal,
      -- awful.layout.suit.spiral,
      -- awful.layout.suit.spiral.dwindle,
      -- awful.layout.suit.max,
      -- awful.layout.suit.max.fullscreen,
      -- awful.layout.suit.magnifier,
      -- awful.layout.suit.corner.nw,
      -- awful.layout.suit.floating,
  })
end)
-- }}}

awful.screen.connect_for_each_screen(function(s)
	beautiful.on_screen_connect(s)
end)

client.connect_signal("request::default_mousebindings", function()
    awful.mouse.append_client_mousebindings({awful.button({}, 1, function(c)
        c:activate{
            context = "mouse_click"
        }
    end), awful.button({MODKEY}, 1, function(c)
        c:activate{
            context = "mouse_click",
            action = "mouse_move"
        }
    end), awful.button({MODKEY}, 3, function(c)
        c:activate{
            context = "mouse_click",
            action = "mouse_resize"
        }
    end)})
end)

-- }}}

-- {{{ Rules
-- Rules to apply to new clients.
ruled.client.connect_signal("request::rules", function()
    -- All clients will match this rule.
    ruled.client.append_rule {
        id = "global",
        rule = {},
        properties = {
            focus = awful.client.focus.filter,
            raise = true,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap + awful.placement.no_offscreen,
            keys = keys.client_keys,
        }
    }

    -- Floating clients.
    ruled.client.append_rule {
        id = "floating",
        rule_any = {
            instance = {"copyq", "pinentry"},
            class = {"Arandr", "Blueman-manager", "Gpick", "Kruler", "Sxiv", "Tor Browser", "Wpa_gui", "veromix",
                     "xtightvncviewer"},
            -- Note that the name property shown in xprop might be set slightly after creation of the client
            -- and the name shown there might not match defined rules here.
            name = {"Event Tester" -- xev.
            },
            role = {"AlarmWindow", -- Thunderbird's calendar.
            "ConfigManager", -- Thunderbird's about:config.
            "pop-up" -- e.g. Google Chrome's (detached) Developer Tools.
            }
        },
        properties = {
            floating = true
        }
    }

  ruled.client.append_rule {
        rule_any = {class = {'Brave-browser'}},
        properties = {tag = ''}
  }

  ruled.client.append_rule {
        rule_any = {class = {'discord'}},
        properties = {tag = ''}
  }

end)

-- }}

-- {{{ Notifications

ruled.notification.connect_signal('request::rules', function()
    -- All notifications will match this rule.
    ruled.notification.append_rule {
        rule = {},
        properties = {
            screen = awful.screen.preferred,
            implicit_timeout = 5
        }
    }
end)

naughty.connect_signal("request::display", function(n)
    naughty.layout.box {
        notification = n
    }
end)

-- }}}



-- Autostart applications
awful.spawn.with_shell("wallpaper")
awful.spawn.with_shell("remaps")
awful.spawn.with_shell("picom --experimental-backends")
awful.spawn.with_shell('killall udiskie ; udiskie')
