local vim = vim
local bind = require('util.bind')

local leader = '<leader>'
local nop = '<nop>'

local noremap = 'noremap'

local any = ''
local insert = 'i'
local normal = 'n'

vim.g.mapleader = ' '
bind(normal, '<space>', nop, noremap)

-- Remap 0 to first non-blank character
bind(any, '0', '^')

-- Reasonable window switching
bind(any, '<C-j>', '<Esc><C-w>j', noremap)
bind(any, '<C-k>', '<Esc><C-w>k', noremap)
bind(any, '<C-h>', '<Esc><C-w>h', noremap)
bind(any, '<C-l>', '<Esc><C-w>l', noremap)

-- Split with new buffer
bind(normal, leader .. 'V', ':vsplit<CR>', noremap)
bind(normal, leader .. 'H', ':split<CR>', noremap)

-- Exit insert mode
bind(insert, 'jk', '<Esc>')
bind(insert, 'kj', '<Esc>')

-- Disable search highlight
bind(normal, '<Esc>', ':nohlsearch<CR>', noremap)

-- Reload file
bind(normal, leader .. 'R', ':edit<CR>', noremap)

-- CHADTree
bind(normal, leader .. 'n', ':CHADopen --always-focus<CR>', noremap)

-- Disable arrow keys
bind(any, '<Up>', nop, noremap)
bind(any, '<Down>', nop, noremap)
bind(any, '<Left>', nop, noremap)
bind(any, '<Right>', nop, noremap)

-- LSP
bind(normal, 'gd', ':lua vim.lsp.buf.definition()<CR>', noremap)
bind(normal, 'gr', ':lua vim.lsp.buf.rename()<CR>', noremap)
bind(normal, 'gh', ':lua vim.lsp.buf.hover()<CR>', noremap)
bind(normal, leader .. 'f', ':lua vim.lsp.buf.formatting()<CR>', noremap)

-- Telescope
bind(normal, leader .. 'tp', ':Telescope find_files<cr>', noremap)
bind(normal, leader .. 'tl', ':Telescope live_grep<cr>', noremap)
