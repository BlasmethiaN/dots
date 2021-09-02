-- Standard awesome library
local gears = require("gears")
local wibox = require("wibox")

local layout = {}

layout.padding = wibox.widget.textbox("    ")

local padding = {layout.padding}

layout.pad = function(widgets)
  return gears.table.join(padding, widgets, padding)
end

layout.fixed_horizontal = function(widgets)
  return gears.table.join({layout = wibox.layout.fixed.horizontal}, widgets)
end

layout.create_span = function(params)
  return '<span color="'..params.color..'" font="'..params.font..'">'..params.content..'</span>'
end

return layout