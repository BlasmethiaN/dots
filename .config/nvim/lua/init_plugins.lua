local bind = require('util.bind')

local npairs = require('nvim-autopairs')
npairs.setup({map_bs = false})

bind('i', '<esc>', 'pumvisible() ? "<c-e><esc>" : "<esc>"', 'expr', 'noremap')
bind('i', '<c-c>', 'pumvisible() ? "<c-e><c-c>" : "<c-c>"', 'expr', 'noremap')
bind('i', '<tab>', 'pumvisible() ? "<c-n>" : "<tab>"', 'expr', 'noremap')
bind('i', '<s-tab>', 'pumvisible() ? "<c-p>" : "<bs>"', 'expr', 'noremap')

_G.MUtils = {}

MUtils.CR = function()
  if vim.fn.pumvisible() ~= 0 then
    if vim.fn.complete_info({'selected'}).selected ~= -1 then
      return npairs.esc('<c-y>')
    else
      return npairs.esc('<c-e>') .. npairs.autopairs_cr()
    end
  else
    return npairs.autopairs_cr()
  end
end
bind('i', '<cr>', 'v:lua.MUtils.CR()', 'expr', 'noremap')

MUtils.BS = function()
  if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info({'mode'}).mode == 'eval' then
    return npairs.esc('<c-e>') .. npairs.autopairs_bs()
  else
    return npairs.autopairs_bs()
  end
end
bind('i', '<bs>', 'v:lua.MUtils.BS()', 'expr', 'noremap')
require('trouble').setup {}
