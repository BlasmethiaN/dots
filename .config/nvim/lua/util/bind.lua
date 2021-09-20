local vim = vim
local a = vim.api
local f = vim.fn

return function(mode, lhs, rhs, ...)
  -- for every optional argument we make a field in the opts table
  -- the field will be set to true
  -- we do this because the neovim api wants {thing1: true, thing2: true, ...}
  local opt = {}
  local args = {}
  if f.len({...}) == 1 and type(({...})[1]) == 'table' then
    args = ({...})[1]
  else
    args = ({...})
  end

  for _, a in ipairs(args) do
    opt[a] = true
  end

  -- buffer local bindings
  if args['buf'] then
    return a.nvim_buf_set_keymap(({...})['buf'], mode, lhs, rhs, opt)
  else
    return a.nvim_set_keymap(mode, lhs, rhs, opt)
  end
end
