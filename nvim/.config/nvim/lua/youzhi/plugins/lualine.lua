return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "SmiteshP/nvim-navic" }, -- add navic as dependency
	config = function()
		local ok_navic, navic = pcall(require, "nvim-navic")

		require("lualine").setup({
			options = {
				theme = "dracula",
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff", "diagnostics" },
				lualine_c = {
					{ "filename", path = 1 },

					-- ▼ show current function / class name via nvim-navic ▼
					{
						function()
							if ok_navic and navic.is_available() then
								return navic.get_location()
							end
							return ""
						end,
						cond = function()
							return ok_navic and navic.is_available()
						end,
						color = { fg = "#f8f8f2" }, -- optional Dracula-friendly color
					},

					-- -- existing Harpoon indicator
					-- {
					-- 	function()
					-- 		local ok, harpoon = pcall(require, "harpoon")
					-- 		if not ok then
					-- 			return ""
					-- 		end
					-- 		local list = harpoon:list()
					-- 		if not list or not list.items then
					-- 			return ""
					-- 		end
					-- 		return "󰛢 " .. tostring(#list.items)
					-- 	end,
					-- 	cond = function()
					-- 		return pcall(require, "harpoon")
					-- 	end,
					-- },
				},
				lualine_x = { "encoding", "fileformat", "filetype" },
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
		})
	end,
}
