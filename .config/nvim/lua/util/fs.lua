local fs = {}

fs.ls = function(dir)
  local handle = io.popen('ls "' .. dir .. '"')

  local t = {}

  for filename in handle:lines() do
    table.insert(t, filename)
  end

  handle:close()

  return t
end

return fs
