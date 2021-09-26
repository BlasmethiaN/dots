require('treesitter')

local lsp = require('lspconfig')
local coq = require('coq')

local enable_snippets = coq.lsp_ensure_capabilities

lsp.bashls.setup(enable_snippets {})
lsp.ccls.setup {}
lsp.efm.setup {
  init_options = {documentFormatting = true},
  filetypes = {'lua'},
  settings = {
    rootMarkers = {'.git/'},
    languages = {
      lua = {
        {
          formatCommand = 'lua-format -i --indent-width=2 --double-quote-to-single-quote',
          formatStdin = true
        }
      }
    }
  }
}
lsp.denols.setup {}
-- lsp.cssls.setup {}
lsp.graphql.setup {}
lsp.hls.setup {settings = {haskell = {formattingProvider = 'stylish-haskell'}}}

local sumneko_binary_path = 'lua-language-server'
local sumneko_root_path = '/usr/share/lua-language-server'

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

require'lspconfig'.sumneko_lua.setup {
  cmd = {sumneko_binary_path, '-E', sumneko_root_path .. '/main.lua'},
  settings = {
    Lua = {
      runtime = {version = 'LuaJIT', path = runtime_path},
      diagnostics = {globals = {'vim'}},
      workspace = {library = vim.api.nvim_get_runtime_file('', true)}
    }
  }
}
-- lsp.html.setup {}
-- lsp.jsonls.setup {}
lsp.texlab.setup(enable_snippets {})
