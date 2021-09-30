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

g.livepreview_previewer = 'zathura'
