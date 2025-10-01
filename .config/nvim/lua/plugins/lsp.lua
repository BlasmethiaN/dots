return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            { "williamboman/mason.nvim", opts = {} },
            "williamboman/mason-lspconfig.nvim",
            "WhoIsSethDaniel/mason-tool-installer.nvim",
            { "j-hui/fidget.nvim", opts = {} },  -- optional, progress UI
            "saghen/blink.cmp",                  -- capabilities provider
            "folke/lsp-colors.nvim",             -- optional colors for diagnostics
        },
        lazy = false,
        config = function()
            -- Basic LSP keymaps
            vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
            vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, {})

            -- Diagnostics config
            vim.diagnostic.config {
                virtual_text = true,
                signs = true,
                underline = true,
                update_in_insert = false,
                severity_sort = true,
            }

            -- LspAttach autocmd for buffer-local mappings
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("user-lsp-attach", { clear = true }),
                callback = function(event)
                    local buf = event.buf
                    local map = function(keys, func, desc, mode)
                        mode = mode or "n"
                        vim.keymap.set(mode, keys, func, { buffer = buf, desc = "LSP: " .. desc })
                    end

                    -- Rename, code actions, references, definitions, implementations
                    map("grn", vim.lsp.buf.rename, "Rename")
                    map("gra", vim.lsp.buf.code_action, "Code Action", { "n", "x" })
                    map("grr", require("telescope.builtin").lsp_references, "References")
                    map("gri", require("telescope.builtin").lsp_implementations, "Implementations")
                    map("grd", require("telescope.builtin").lsp_definitions, "Definitions")
                    map("grD", vim.lsp.buf.declaration, "Declaration")
                    map("gO", require("telescope.builtin").lsp_document_symbols, "Document Symbols")
                    map("gW", require("telescope.builtin").lsp_dynamic_workspace_symbols, "Workspace Symbols")
                    map("grt", require("telescope.builtin").lsp_type_definitions, "Type Definitions")

                    -- Highlight references under cursor
                    local client = vim.lsp.get_client_by_id(event.data.client_id)
                    if client and client.supports_method("textDocument/documentHighlight") then
                        local highlight_augroup = vim.api.nvim_create_augroup("user-lsp-highlight", { clear = false })
                        vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                            buffer = buf,
                            group = highlight_augroup,
                            callback = vim.lsp.buf.document_highlight,
                        })
                        vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                            buffer = buf,
                            group = highlight_augroup,
                            callback = vim.lsp.buf.clear_references,
                        })
                    end

                    -- Toggle inlay hints
                    if client and client.supports_method("textDocument/inlayHint") then
                        map("<leader>th", function()
                            vim.lsp.inlay_hint.enable(
                                not vim.lsp.inlay_hint.is_enabled({ bufnr = buf })
                            )
                        end, "Toggle Inlay Hints")
                    end
                end,
            })

            -- LSP capabilities from blink.cmp
            local capabilities = require("blink.cmp").get_lsp_capabilities()

            -- Define LSP servers
            local servers = {
                bashls = {},
                cssls = {},
                html = {},
                lua_ls = {},
                pyright = {},
                rust_analyzer = {},
                terraformls = {},
                ts_ls = {},
                jsonls = {},
                yamlls = {},
                vimls = {},
                marksman = {},
            }

            -- Ensure Mason installs LSP servers
            local ensure_installed = vim.tbl_keys(servers)
            vim.list_extend(ensure_installed, { "stylua" }) -- formatters etc

            require("mason-tool-installer").setup { ensure_installed = ensure_installed }
            require("mason-lspconfig").setup {
                ensure_installed = vim.tbl_keys(servers),
                automatic_installation = false,
                handlers = {
                    function(server_name)
                        local server_opts = servers[server_name] or {}
                        server_opts.capabilities = vim.tbl_deep_extend(
                            "force",
                            {},
                            capabilities,
                            server_opts.capabilities or {}
                        )
                        require("lspconfig")[server_name].setup(server_opts)
                    end,
                },
            }
        end,
    },
}

