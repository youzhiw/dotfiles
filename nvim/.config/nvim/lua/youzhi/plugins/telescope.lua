return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.6",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local telescope = require("telescope")
			local builtin = require("telescope.builtin")
			local layout_actions = require("telescope.actions.layout")

			telescope.setup({
				defaults = {
					file_ignore_patterns = { "node_modules", ".git/" },
					mappings = {
						i = { ["<c-p>"] = layout_actions.toggle_preview },
						n = { ["<c-p>"] = layout_actions.toggle_preview },
					},
					layout_strategy = "horizontal",
					layout_config = {
						width = 0.99,
						height = 0.99,
						preview_width = 0.7,
						preview_cutoff = 1,
						prompt_position = "top",
					},
					sorting_strategy = "ascending",
				},
				pickers = {
					find_files = { hidden = true },
					live_grep = {
						additional_args = function()
							return { "--hidden" }
						end,
					},
				},
			})

			-- keymaps
			vim.keymap.set("n", "<leader>f", builtin.find_files, {})
			vim.keymap.set("n", "<leader>g", builtin.live_grep, {})
			vim.keymap.set("n", "<leader>h", builtin.help_tags, {})
			vim.keymap.set("n", "<leader>sr", builtin.lsp_references, {})
			vim.keymap.set("n", "<leader>b", builtin.buffers, {})
			vim.keymap.set("n", "<leader>/", builtin.current_buffer_fuzzy_find, {})
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				extensions = { ["ui-select"] = require("telescope.themes").get_dropdown({}) },
			})
			require("telescope").load_extension("ui-select")
		end,
	},
}
