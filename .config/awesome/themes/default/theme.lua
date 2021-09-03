-- Standard awesome library
local gears = require('gears')
local awful = require('awful')
local wibox = require('wibox')

local theme_assets = require('beautiful.theme_assets')
local xresources = require('beautiful.xresources')
local rnotification = require('ruled.notification')
local dpi = xresources.apply_dpi

local gfs = require('gears.filesystem')
local themes_path = gfs.get_themes_dir()

local layout = require('util.layout')

-- Widget imports
local create_volume_widget = require('widgets.volume')

local theme = {}

theme.color = {
  polar_night = {
    '#2e3440',
    '#3b4252',
    '#434c5e',
    '#4c566a'
  },
  snow_storm = {
    '#d8dee9',
    '#e5e9f0',
    '#eceff4'
  },
  frost = {
    '#8fbcbb',
    '#88c0d0',
    '#81a1c1',
    '#5e81ac'
  },
  aurora = {
    red = '#bf616a',
    orange = '#d08770',
    yellow = '#ebcb8b',
    green = '#a3be8c',
    purple = '#b48ead'
  },
  one_dark = {
    dark = '#282C34',
    orange = '#e5c07b',
    red = '#e06c75',
    purple = '#c678dd',
    blue = '#61afef',
    green = '#98c379'
  },
  femboy = {
    '#f7c0e5',
    '#edaaf3',
    '#d4a1f3',
    '#be9cec',
    '#b798ec'
  }
}

theme.font = 'monospace 10.5'

theme.fonts = {
  icon = 'monospace 15',
  widget = theme.font
}

theme.bg_normal = theme.color.one_dark.dark
theme.bg_focus = theme.color.frost[4]
theme.bg_urgent = theme.color.one_dark.red
theme.bg_minimize = theme.color.polar_night[2]
theme.bg_systray = theme.bg_normal

theme.fg_normal = theme.color.snow_storm[3]
theme.fg_focus = theme.color.snow_storm[1]
theme.fg_urgent = theme.color.one_dark.orange
theme.fg_minimize = theme.color.snow_storm[1]

theme.taglist_bg_urgent = theme.color.one_dark.orange
theme.taglist_bg_focus = theme.color.femboy[1]
theme.taglist_fg_occupied = theme.color.femboy[1]
theme.taglist_fg_urgent = theme.color.one_dark.dark
theme.taglist_fg_empty = theme.color.polar_night[3]
theme.taglist_fg_focus = theme.color.one_dark.dark

theme.useless_gap = dpi(7)
theme.border_width = dpi(1.3)
theme.border_color_normal = theme.color.one_dark.blue
theme.border_color_active = theme.color.femboy[1]
theme.border_color_marked = '#91231c'

local taglist_square_size = dpi(2)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(taglist_square_size, theme.fg_normal)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(taglist_square_size, theme.fg_normal)

theme.menu_submenu_icon = themes_path .. 'default/submenu.png'
theme.menu_height = dpi(15)
theme.menu_width = dpi(100)

theme.layout_fairh = themes_path .. 'default/layouts/fairhw.png'
theme.layout_fairv = themes_path .. 'default/layouts/fairvw.png'
theme.layout_floating = themes_path .. 'default/layouts/floatingw.png'
theme.layout_magnifier = themes_path .. 'default/layouts/magnifierw.png'
theme.layout_max = themes_path .. 'default/layouts/maxw.png'
theme.layout_fullscreen = themes_path .. 'default/layouts/fullscreenw.png'
theme.layout_tilebottom = themes_path .. 'default/layouts/tilebottomw.png'
theme.layout_tileleft = themes_path .. 'default/layouts/tileleftw.png'
theme.layout_tile = themes_path .. 'default/layouts/tilew.png'
theme.layout_tiletop = themes_path .. 'default/layouts/tiletopw.png'
theme.layout_spiral = themes_path .. 'default/layouts/spiralw.png'
theme.layout_dwindle = themes_path .. 'default/layouts/dwindlew.png'
theme.layout_cornernw = themes_path .. 'default/layouts/cornernww.png'
theme.layout_cornerne = themes_path .. 'default/layouts/cornernew.png'
theme.layout_cornersw = themes_path .. 'default/layouts/cornersww.png'
theme.layout_cornerse = themes_path .. 'default/layouts/cornersew.png'

theme.icon_theme = nil

rnotification.connect_signal(
  'request::rules',
  function()
    rnotification.append_rule {
      rule = {urgency = 'critical'},
      properties = {bg = '#ff0000', fg = '#ffffff'}
    }
  end
)

-- Separators
local spr = wibox.widget.textbox('     ')
local half_spr = wibox.widget.textbox('  ')
local split_spr = wibox.widget.textbox(' ')

-- Widgets {{{

-- Volume widget
local volume = create_volume_widget(theme.color.femboy[5], theme.color.polar_night[2], theme.fonts.icon)
local volume_widget = layout.fixed_horizontal(layout.pad(volume.widget))
theme.update_volume = volume.update_volume

-- Keyboard map indicator and switcher
local mykeyboardlayout = awful.widget.keyboardlayout()

-- Battery
local baticon =
  wibox.widget.textbox(
  string.format('<span color="%s" font="' .. theme.fonts.icon .. '"></span>', theme.color.one_dark.blue)
)
local bat =
  awful.widget.watch(
  [[bash -c "echo $(cat /sys/class/power_supply/BAT1/capacity)%"]],
  60,
  function(widget, stdout)
    widget:set_markup(
      '<span color="' .. theme.color.one_dark.blue .. '" font="' .. theme.fonts.widget .. '"> ' .. stdout .. '%</span> '
    )
  end
)

-- Clock
local clockicon =
  wibox.widget.textbox(
  string.format('<span color="%s" font="' .. theme.fonts.icon .. '"> </span>', theme.color.one_dark.red)
)
local clock =
  wibox.widget.textclock(
  '<span font="' .. theme.fonts.widget .. '" color="' .. theme.color.one_dark.red .. '">%R</span>'
)

theme.on_screen_connect = function(s)
  -- Tags
  awful.tag({'1', '2', '3', '4', '5', '6', '7', '8', '9'}, s, awful.layout.layouts[1])

  -- Create a taglist widget
  s.mytaglist =
    awful.widget.taglist {
    screen = s,
    filter = awful.widget.taglist.filter.all,
    style = {
      shape = gears.shape.circle
    },
    widget_template = {
      {
        {
          {
            id = 'text_role',
            widget = wibox.widget.textbox
          },
          layout = wibox.layout.align.horizontal
        },
        left = 10,
        right = 10,
        widget = wibox.container.margin
      },
      id = 'background_role',
      widget = wibox.container.background
    },
    buttons = {
      awful.button(
        {},
        1,
        function(t)
          t:view_only()
        end
      ),
      awful.button(
        {MODKEY},
        1,
        function(t)
          if client.focus then
            client.focus:move_to_tag(t)
          end
        end
      ),
      awful.button({}, 3, awful.tag.viewtoggle),
      awful.button(
        {MODKEY},
        3,
        function(t)
          if client.focus then
            client.focus:toggle_tag(t)
          end
        end
      ),
      awful.button(
        {},
        4,
        function(t)
          awful.tag.viewprev(t.screen)
        end
      ),
      awful.button(
        {},
        5,
        function(t)
          awful.tag.viewnext(t.screen)
        end
      )
    }
  }

  -- }}}

  -- Create the wibox
  s.mywibox =
    awful.wibar(
    {
      position = 'top',
      screen = s
    }
  )

  -- Add widgets to the wibox
  s.mywibox.widget = {
    layout = wibox.layout.align.horizontal,
    {
      -- Left widgets
      layout = wibox.layout.fixed.horizontal,
      s.mytaglist
    },
    {
      -- Center widget
      layout = wibox.layout.align.horizontal
    },
    {
      -- Right widgets
      layout = wibox.layout.fixed.horizontal,
      mykeyboardlayout,
      half_spr,
      {
        {
          layout = wibox.layout.fixed.horizontal,
          half_spr,
          baticon,
          bat,
          half_spr
        },
        widget = wibox.container.background
      },
      half_spr,
      {
        {
          layout = wibox.layout.fixed.horizontal,
          half_spr,
          clockicon,
          clock,
          half_spr
        },
        widget = wibox.container.background
      },
      volume_widget,
      wibox.widget.systray(),
      half_spr
    }
  }
end

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
