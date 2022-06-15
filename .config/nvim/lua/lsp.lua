require('treesitter')

local lsp = require('lspconfig')
local coq = require('coq')

local coq_setup = coq.lsp_ensure_capabilities

lsp.bashls.setup(coq_setup {})
lsp.ccls.setup(coq_setup {})
lsp.cssls.setup {}
lsp.efm.setup {
  init_options = {documentFormatting = true},
  filetypes = {'lua', 'sh', 'python'},
  settings = {
    rootMarkers = {'.git/'},
    languages = {
      lua = {
        {
          formatCommand = 'lua-format -i --indent-width=2 --double-quote-to-single-quote',
          formatStdin = true
        }
      },
      sh = {
        {
          formatCommand = 'shfmt -ci -i 2 -s -bn',
          formatStdin = true,
          lintCommand = 'shellcheck -f gcc -x',
          lintSource = 'shellcheck',
          lintFormats = {
            '%f:%l:%c: %trror: %m', '%f:%l:%c: %tarning: %m',
            '%f:%l:%c: %tote: %m'
          }
        }
      },
      python = {{formatCommand = 'yapf --quiet', formatStdin = true}}
    }
  }
}
-- lsp.graphql.setup {}
lsp.hls
    .setup(coq_setup {settings = {haskell = {formattingProvider = 'ormolu'}}})

lsp.rust_analyzer.setup(coq_setup {
  settings = {
    ['rust-analyzer'] = {rustfmt = {extraArgs = {'--config', 'tab_spaces=2'}}}
  }
})
lsp.pyright.setup(coq_setup {})
lsp.html.setup {}
lsp.jsonls.setup {}

-- lsp.asm_lsp.setup(coq_setup {})

lsp.lemminx.setup {cmd = {'/usr/bin/lemminx'}}

local sumneko_binary_path = 'lua-language-server'
local sumneko_root_path = '/usr/share/lua-language-server'

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

lsp.sumneko_lua.setup(coq_setup {
  cmd = {sumneko_binary_path, '-E', sumneko_root_path .. '/main.lua'},
  settings = {
    Lua = {
      runtime = {version = 'LuaJIT', path = runtime_path},
      diagnostics = {globals = {'vim'}},
      workspace = {library = vim.api.nvim_get_runtime_file('', true)}
    }
  }
})

lsp.texlab.setup(coq_setup {})
