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
                ensure_installed = { "lua_ls", "ts_ls", "jdtls", "pyright" }
            })
        end
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")
            -- -- Python LSP
            lspconfig.pyright.setup({})

			-- Lua LSP
			lspconfig.lua_ls.setup({})

			-- lspconfig.jdtls.setup({})

			-- C / C++: clangd
			lspconfig.clangd.setup({
				-- mason-lspconfig will point to Mason's clangd automatically if installed there
				cmd = {
					"clangd",
					"--background-index",
					"--clang-tidy", -- run clang-tidy checks
					"--completion-style=detailed",
					"--header-insertion=iwyu", -- smarter include insertion
					"--fallback-style=LLVM", -- fallback formatting style
				},
				-- Uncomment if you use nvim-cmp capabilities
				-- capabilities = require("cmp_nvim_lsp").default_capabilities(),
				on_attach = function(client, bufnr)
					-- optional: format on save for C/C++
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({ async = false })
						end,
					})
				end,
			})
			-- Keybindings for LSP actions
			vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
			vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostics" })
		end,
	},
}
