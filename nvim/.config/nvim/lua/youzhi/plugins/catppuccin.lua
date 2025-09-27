return {
	"catppuccin/nvim",
	name = "catppuccin",
	config = function()
		require("catppuccin").setup({
			flavour = "auto",
			transparent_background = true,
			integrations = {
				cmp = true,
				gitsigns = true,
				treesitter = true,
				nvimtree = true,
			},
			custom_highlights = function(colors)
				return {
					LineNr = { fg = colors.overlay1 },
					CursorLineNr = { fg = colors.peach, style = { "bold" } },
				}
			end,
		})
		vim.cmd.colorscheme("catppuccin")
	end,
}
