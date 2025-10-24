return {
	-- Installers only
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

	-- Use Neovim’s native LSP config/enable (no legacy lspconfig.setup)
	{
		"neovim/nvim-lspconfig", -- keep for utilities like root_pattern
		dependencies = { "SmiteshP/nvim-navic", "williamboman/mason-lspconfig.nvim" },
		config = function()
			local ok_navic, navic = pcall(require, "nvim-navic")
			local util_ok, util = pcall(require, "lspconfig.util")

			-- Buffer-local keymaps + format-on-save + navic attach for any LSP
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local bufnr = args.buf
					local client = vim.lsp.get_client_by_id(args.data.client_id)

					if ok_navic and client and client.server_capabilities.documentSymbolProvider then
						pcall(navic.attach, client, bufnr)
					end

					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						callback = function()
							pcall(vim.lsp.buf.format, { async = false })
						end,
					})

					local opts = { noremap = true, silent = true, buffer = bufnr }
					vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
					vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, opts)
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
					vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
				end,
			})

			-- Small helper for roots
			local function root_from(markers)
				if util_ok then
					return util.root_pattern(unpack(markers))
				end
				-- fallback using vim.fs (0.10+)
				return function(fname)
					local m = vim.fs.find(markers, { upward = true, path = fname })[1]
					return m and vim.fs.dirname(m) or vim.fs.dirname(fname)
				end
			end

			-- === DEFINE CONFIGS (NOTE: first arg is the NAME string) ===
			vim.lsp.config("lua_ls", {
				cmd = { "lua-language-server" },
				root_dir = root_from({ ".luarc.json", ".stylua.toml", ".luacheckrc", ".git" }),
				settings = {
					Lua = {
						workspace = { checkThirdParty = false },
						diagnostics = { globals = { "vim" } },
					},
				},
			})

			vim.lsp.config("clangd", {
				cmd = {
					"clangd", -- prefer PATH; change if you need an absolute path
					"--background-index",
					"--clang-tidy",
					"--completion-style=detailed",
					"--header-insertion=iwyu",
					"--fallback-style=LLVM",
				},
				root_dir = root_from({ "compile_commands.json", "compile_flags.txt", ".git" }),
			})

			-- === ENABLE CONFIGS ===
			-- This registers them with Neovim and will start/attach in matching buffers.
			vim.lsp.enable({ "lua_ls", "clangd" })
			-- (Optional) If you want to delay enable until a filetype is opened:
			-- vim.api.nvim_create_autocmd("FileType", {
			--   pattern = { "lua" },
			--   once = true,
			--   callback = function() vim.lsp.enable('lua_ls') end,
			-- })
			-- vim.api.nvim_create_autocmd("FileType", {
			--   pattern = { "c", "cpp", "objc", "objcpp" },
			--   once = true,
			--   callback = function() vim.lsp.enable('clangd') end,
			-- })
		end,
	},
}
