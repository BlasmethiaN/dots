MODKEY = "Mod4"
TERMINAL = "alacritty"
EDITOR = os.getenv("EDITOR") or "nano"
EDITOR_CMD = TERMINAL .. " -e " .. EDITOR

-- Volume control
local volume_control = require("util.volume-control")
VOLUME_CFG = volume_control({})