local vim = vim

local fns = {}

local run_command = function(cmd, str)
  vim.cmd(cmd .. ' ' .. str)
end

fns.echo = function(str)
  run_command('echo', '"' .. str .. '"')
end

fns.silent = function(str)
  run_command('silent', str)
end

local meta = {
  __call = function(_, ...)
    vim.cmd(...)
  end
}

return setmetatable(fns, meta)
