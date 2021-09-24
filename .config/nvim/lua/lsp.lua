require('treesitter')

local lsp = require('lspconfig')
local coq = require('coq')

local enable_snippets = coq.lsp_ensure_capabilities

lsp.bashls.setup(enable_snippets {})
lsp.ccls.setup{}
lsp.denols.setup{}
-- lsp.cssls.setup {}
lsp.graphql.setup {}
lsp.hls.setup {
  settings = {
    haskell = {
      formattingProvider = 'stylish-haskell'
    }
  }
}
-- lsp.html.setup {}
-- lsp.jsonls.setup {}
lsp.texlab.setup(enable_snippets {})
