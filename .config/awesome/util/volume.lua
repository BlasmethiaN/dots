local awful = require("awful")

local controls = {}

local set = function(value)
  awful.spawn("amixer set Master " .. value)
end

controls.up = function()
  set("5%+")
end

controls.down = function()
  set("5%-")
end

controls.toggle = function()
  set("toggle")
end

return controls