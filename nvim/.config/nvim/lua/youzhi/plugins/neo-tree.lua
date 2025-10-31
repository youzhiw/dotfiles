return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		-- Toggle Neo-tree on the left (common)
		vim.keymap.set('n', '<leader>ee', '<cmd>Neotree toggle right<CR>', { desc = "Toggle Neo-tree" })

		-- Reveal current file in Neo-tree (like VSCode's "Reveal in Explorer")
		vim.keymap.set('n', '<leader>er', '<cmd>Neotree reveal<CR>', { desc = "Reveal file in Neo-tree" })
	end
}
