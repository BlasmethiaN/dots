local wibox = require('wibox')
local awful = require('awful')

local layout = require('util.layout')

return function(colors, fonts, spacing)
  colors.battery_empty = colors.battery_empty or colors.primary

  local battery_icon = wibox.widget.textbox('')

  local create_battery_icon = function(icon, color)
    return
        layout.create_span({color = color, font = fonts.icon, content = icon})
  end

  local battery_percentage = awful.widget.watch('acpi -b', 60,
                                                function(widget, stdout)
    local charge = tonumber(string.match(stdout, '(%d?%d?%d)%%'))

    local icon
    local color = colors.primary

    if (charge < 20) then
      icon = ''
      color = colors.battery_empty
    elseif (charge < 40) then
      icon = ''
    elseif (charge < 60) then
      icon = ''
    elseif (charge < 80) then
      icon = ''
    else
      icon = ''
    end

    battery_icon:set_markup(create_battery_icon(icon, color))

    widget:set_markup(layout.create_span({
      color = color,
      font = fonts.widget,
      content = charge .. '%'
    }))
  end)

  local battery_widget = {
    battery_icon, layout.horizontal_spacer(spacing), battery_percentage
  }

  return {widget = battery_widget}
end
