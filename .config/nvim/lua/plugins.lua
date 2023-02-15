local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = ' '

require('lazy').setup({
  -- General
  'nvim-lua/plenary.nvim',

  -- ms-jpq
  {'ms-jpq/coq_nvim', branch = 'coq'},
  {'ms-jpq/coq.artifacts', branch = 'artifacts'},
  {'ms-jpq/chadtree', branch = 'chad', build = 'python3 -m chadtree deps'},

  -- folke
  'folke/lsp-colors.nvim',
  'folke/trouble.nvim',
  'folke/which-key.nvim',

  -- tpope
  'tpope/vim-commentary',
  'tpope/vim-eunuch',
  'tpope/vim-repeat',
  'tpope/vim-sensible',
  'tpope/vim-surround',

  -- windwp
  'windwp/nvim-autopairs',
  'windwp/nvim-ts-autotag',

  -- mhinz
  'mhinz/vim-signify',
  'mhinz/vim-startify',

  -- Utility
  {'nvim-treesitter/nvim-treesitter', build = ':TSUpdate'},
  'neovim/nvim-lspconfig',
  'easymotion/vim-easymotion',
  'nvim-telescope/telescope.nvim',
  'lervag/vimtex',
  'github/copilot.vim',
  'mattn/emmet-vim',


  -- Visual
  'kyazdani42/nvim-web-devicons',
  {'iamcco/markdown-preview.nvim', build = 'cd app && yarn install'},
  {'xuhdev/vim-latex-live-preview', ft = 'tex'},

  -- Color schemes
  'joshdick/onedark.vim',
  'doki-theme/doki-theme-vim',
  'ghifarit53/tokyonight-vim',
  'thedenisnikulin/vim-cyberpunk',
  'catppuccin/vim',

})

