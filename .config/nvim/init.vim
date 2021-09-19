" Install vim-plug if not installed
if ! filereadable(expand('~/.local/share/nvim/site/autoload/plug.vim'))
  echo "Downloading junegunn/vim-plug to manage plugins…"
  silent !mkdir -p ~/.local/share/nvim/site/autoload/
  silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
    \ > ~/.local/share/nvim/site/autoload/plug.vim
endif

" Install new plugins
autocmd VimEnter *
  \ if len(filter(values(g:plugs), '!isdirectory(v:val.dir)')) |
  \   PlugInstall --sync | q |
  \ endif

" Run some stuff
autocmd VimEnter * COQnow

call plug#begin('~/.vim/plugged')

Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': 'python3 -m chadtree deps'}

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'neovim/nvim-lspconfig'

Plug 'kyazdani42/nvim-web-devicons'

Plug 'morhetz/gruvbox'
Plug 'joshdick/onedark.vim'

call plug#end()

colorscheme onedark

luafile $HOME/.config/nvim/lua/init.lua

runtime! keys.vim
runtime! plugins.vim
