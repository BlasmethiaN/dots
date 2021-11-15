local awful = require('awful')
local wibox = require('wibox')

local layout = require('util.layout')

local create = function(colors, fonts, spacing)
  local keyboard_icon =
    wibox.widget.textbox(layout.create_span({color = colors.primary, font = fonts.icon, content = ''}))
  local layout_code = wibox.widget.textbox('')

  local update = function()
    awful.spawn.easy_async_with_shell(
      'xkblayout-state print "%s"',
      function(code)
        layout_code:set_markup(layout.create_span({color = colors.primary, font = fonts.widget, content = code}))
      end
    )
  end

  update()

  awesome.connect_signal('xkb::map_changed', update)
  awesome.connect_signal('xkb::group_changed', update)

  local keyboard_layout_widget = {
    keyboard_icon,
    layout.horizontal_spacer(spacing),
    layout_code
  }

  return {widget = keyboard_layout_widget}
end

return create
