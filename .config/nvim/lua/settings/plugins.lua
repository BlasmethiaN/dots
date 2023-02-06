local cmd = require('util.cmd')
local vim = vim
local g = vim.g

g.coq_settings = {
  auto_start = 'shut-up',
  keymap = {jump_to_mark = '<C-y>', recommended = false}
}

g.chadtree_settings = {
  view = {width = 32, open_direction = 'left'},
  theme = {text_colour_set = 'nerdtree_syntax_dark'}
}

g.user_emmet_install_global = 0
g.user_emmet_expandabbr_key='<space>m'
g.user_emmet_leader_key='<C-Y><C-y>'
cmd('autocmd FileType html,css EmmetInstall')

g.livepreview_previewer = 'zathura'
