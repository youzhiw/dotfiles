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
				ensure_installed = { "lua_ls" }, -- include clangd
			})
		end,
	},
	-- Needed so lualine's navic component works
	{ "SmiteshP/nvim-navic" },

	{
		"neovim/nvim-lspconfig",
		dependencies = { "SmiteshP/nvim-navic" },
		config = function()
			local lspconfig = require("lspconfig")
			local ok_navic, navic = pcall(require, "nvim-navic")

			-- one on_attach for all servers
			local function on_attach(client, bufnr)
				-- attach navic if symbols are supported (needed for function name in lualine)
				if ok_navic and client.server_capabilities.documentSymbolProvider then
					navic.attach(client, bufnr)
				end

				-- (your original) format on save for this buffer
				vim.api.nvim_create_autocmd("BufWritePre", {
					buffer = bufnr,
					callback = function()
						pcall(vim.lsp.buf.format, { async = false })
					end,
				})
			end

			-- Lua LSP
			lspconfig.lua_ls.setup({
				on_attach = on_attach,
				settings = {
					Lua = {
						workspace = { checkThirdParty = false },
						diagnostics = { globals = { "vim" } },
					},
				},
			})

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
				on_attach = on_attach,
				-- capabilities = require("cmp_nvim_lsp").default_capabilities(), -- if you use nvim-cmp
			})

			-- Keybindings for LSP actions (kept from your config)
			local opts = { noremap = true, silent = true }
			vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
			vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
			vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
		end,
	},
}
