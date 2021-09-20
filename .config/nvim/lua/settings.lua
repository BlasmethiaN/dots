local cmd = require('util.cmd')

local vim = vim

vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.tabstop = 4
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.shiftround = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true

cmd('colorscheme onedark')

require('settings.plugins')
require('settings.keys')
