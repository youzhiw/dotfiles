return {
	"nvim-lualine/lualine.nvim",
	config = function()
		require("lualine").setup({
			options = {
				theme = "dracula",
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = {
					{ "filename", path = 1 },
					{
						function()
							local ok, harpoon = pcall(require, "harpoon")
							if not ok then
								return ""
							end
							local list = harpoon:list()
							if not list or not list.items then
								return ""
							end
							return "󰛢 " .. tostring(#list.items)
						end,
						cond = function()
							return pcall(require, "harpoon")
						end,
					},
				},
				lualine_x = { "encoding", "fileformat", "filetype" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
		})
	end,
}
