require('plugins')
require('settings')
require('lsp')
require('init_plugins')

vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy", -- Ensures Lazy.nvim is fully initialized
    callback = function()
        -- Run Lazy.nvim update in a background job
        vim.fn.jobstart({"nvim", "--headless", "-c", "Lazy update", "-c", "q"}, {detach = true})

        -- Run COQ update silently
        vim.fn.jobstart({"nvim", "--headless", "-c", "COQdeps", "-c", "q"}, {detach = true})

        -- Run CHADdeps update silently
        vim.fn.jobstart({"nvim", "--headless", "-c", "CHADdeps", "-c", "q"}, {detach = true})
    end,
})
