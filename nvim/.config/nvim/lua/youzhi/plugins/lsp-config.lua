return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = { "lua_ls" },
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")

			-- Lua LSP
			lspconfig.lua_ls.setup({})

			-- clangd
			lspconfig.clangd.setup({
				cmd = {
					"/usr/bin/clangd", -- adjust if different on your system
					"--background-index",
					"--clang-tidy",
					"--completion-style=detailed",
					"--header-insertion=iwyu",
					"--fallback-style=LLVM",
				},
				-- capabilities = require("cmp_nvim_lsp").default_capabilities(), -- if you use nvim-cmp
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
		end,
	},
}
