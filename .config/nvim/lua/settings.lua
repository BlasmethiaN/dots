local cmd = require('util.cmd')

vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.tabstop = 4
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.shiftround = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.linebreak = true

vim.env.BASH_ENV = '~/.bash_functions'

cmd('colorscheme tokyonight')

require('settings.plugins')
require('settings.keys')
