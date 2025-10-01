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
vim.opt.mouse = "a"

vim.env.BASH_ENV = vim.fn.expand("~/.bash_functions")

-- Colorscheme
vim.cmd("colorscheme catppuccin_macchiato")

-- Vimtex
vim.g.vimtex_view_method = "zathura"
vim.g.vimtex_compiler_method = "latexmk"

local opts = { noremap = true, silent = true }
local map = vim.keymap.set
local leader = " "  -- protože vim.g.mapleader = " " v settings.lua

-- Disable space in normal mode
map("n", "<space>", "<nop>", opts)

-- Remap 0 to first non-blank character
map({ "n", "v" }, "0", "^", opts)

-- Window navigation
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- Splits with new buffer
map("n", leader .. "V", ":vsplit<CR>", opts)
map("n", leader .. "H", ":split<CR>", opts)

-- Exit insert mode
map("i", "jk", "<Esc>", opts)
map("i", "kj", "<Esc>", opts)

-- Disable search highlight
map("n", "<Esc>", ":nohlsearch<CR>", opts)

-- Reload file
map("n", leader .. "R", ":edit<CR>", opts)

-- CHADTree (pokud ho stále používáš)
map("n", leader .. "n", ":CHADopen --always-focus<CR>", opts)

-- Disable arrow keys
map({ "n", "i", "v" }, "<Up>", "<nop>", opts)
map({ "n", "i", "v" }, "<Down>", "<nop>", opts)
map({ "n", "i", "v" }, "<Left>", "<nop>", opts)
map({ "n", "i", "v" }, "<Right>", "<nop>", opts)

-- LSP mappings
map("n", "gd", vim.lsp.buf.definition, opts)
map("n", "gr", vim.lsp.buf.rename, opts)
map("n", "gh", vim.lsp.buf.hover, opts)
map("n", leader .. "f", function() vim.lsp.buf.format({ async = true }) end, opts)

-- Telescope mappings
map("n", leader .. "tp", ":Telescope find_files<CR>", opts)
map("n", leader .. "tl", ":Telescope live_grep<CR>", opts)
map("n", leader .. "td", ":Telescope diagnostics<CR>", opts)
