return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {"gopls", "lua_ls"}
            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")
            -- -- Python LSP
            -- lspconfig.pyright.setup({})

            -- Lua LSP
            lspconfig.lua_ls.setup({})

            lspconfig.gopls.setup({})

            -- -- TypeScript and JavaScript LSP
            -- lspconfig.tsserver.setup({
            --     on_attach = function(client, bufnr)
            --         -- Disable tsserver's formatting (optional if using Prettier)
            --         client.server_capabilities.documentFormattingProvider = false
            --         client.server_capabilities.documentRangeFormattingProvider = false
            --     end
            -- })

            -- Keybindings for LSP actions
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
            vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, {})
        end
    }
}
