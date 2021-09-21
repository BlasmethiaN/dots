require('treesitter')

local lsp = require('lspconfig')

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
lsp.texlab.setup {}
