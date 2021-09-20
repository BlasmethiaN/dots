require('treesitter')

-- Defaults
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
lsp.ccls.setup {
  init_options = {
    compilationDatabaseDirectory = 'build',
    index = {
      threads = 0
    },
    clang = {
      excludeArgs = {'-frounding-math'}
    }
  }
}
-- lsp.html.setup {}
-- lsp.jsonls.setup {}
