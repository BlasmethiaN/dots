require('globals')

local cmd = require('util.cmd')
local fs = require('util.fs')

local vim = vim
local f = vim.fn
local g = vim.g

-- Remove extra plugins
local extra_plugins = f.filter(fs.ls(PLUG_DIR), function(_, name)
  return g.plugs[name] == nil
end)

if (f.len(extra_plugins) > 0) then
  cmd.echo('Removing ' .. f.len(extra_plugins) .. ' extra plugins')
  cmd('PlugClean! | q')
end

-- Install missing plugins
local missing_plugins = f.filter(g.plugs, function(_, v)
  return f.isdirectory(v.dir) == 0
end)

if (f.len(missing_plugins) > 0) then
  cmd.echo('Installing ' .. f.len(missing_plugins) .. ' missing plugins')
  cmd('PlugInstall --sync | q')
end
