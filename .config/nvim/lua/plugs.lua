require('globals')

local cmd = require('util.cmd')
local Plug = require('util.plug')

local vim = vim
local f = vim.fn

local plug_path = f.stdpath('data') .. '/site/autoload/plug.vim'

-- Install vim-plug if not installed
if (f.filereadable(plug_path) == 0) then
  cmd.echo 'Downloading junegunn/vim-plug to manage plugins…'
  cmd.silent(
    '!curl -fLo ' .. plug_path .. ' --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  )
end

Plug.beginPlug(PLUG_DIR)

Plug('ms-jpq/coq_nvim', {branch = 'coq'})
Plug('ms-jpq/coq.artifacts', {branch = 'artifacts'})
Plug('ms-jpq/chadtree', {branch = 'chad', run = 'python3 -m chadtree deps'})

Plug('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
Plug('neovim/nvim-lspconfig')

Plug('kyazdani42/nvim-web-devicons')
Plug('iamcco/markdown-preview.nvim', {run = 'cd app && yarn install'})
Plug('xuhdev/vim-latex-live-preview', {ft = 'tex'})

Plug('morhetz/gruvbox')
Plug('joshdick/onedark.vim')

Plug.endPlug()
