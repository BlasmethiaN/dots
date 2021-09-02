local gears = require("gears")
local wibox = require("wibox")
local awful = require("awful")

local layout = require("util.layout")

local create = function(color, background_color, icon_font)
  local volume_bar = wibox.widget {
    max_value     = 100,
    value         = 0,
    forced_width  = 100,
    forced_height = 2,
    border_width  = 2,
    color         = color,
    background_color = background_color,
    shape     = gears.shape.rounded_bar,
    margins       = {
        top    = 8,
        bottom = 8,
    },
    widget        = wibox.widget.progressbar,
  }

  local volume_icon = wibox.widget.textbox('')

  local create_volume_icon = function(icon)
    return layout.create_span({color = color, font = icon_font, content = icon})
  end

  local muted_icon = create_volume_icon("婢")
  local silent_icon = create_volume_icon("")
  local normal_icon = create_volume_icon("墳")

  local update_volume = function()
    awful.spawn.easy_async_with_shell("sleep .01 ; amixer get Master", function(status)
      local state  = status:match("%[(o[nf]*)%]")
      local volume = tonumber(status:match("(%d?%d?%d)%%"))

      if state == "off" then
        volume_icon:set_markup(muted_icon)
      elseif volume == 0 then
        volume_icon:set_markup(silent_icon)
      else
        volume_icon:set_markup(normal_icon)
      end

      volume_bar:set_value(volume)
    end)
  end

  local volume_widget = {
    volume_icon,
    layout.padding,
    volume_bar
  }

  update_volume()

  return {widget = volume_widget, update_volume = update_volume}
end

return create