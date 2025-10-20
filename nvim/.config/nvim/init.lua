require("youzhi.vim-options")
if vim.g.vscode then
	vim.cmd("nmap j gj")
	vim.cmd("nmap k gk")
	-- VSCode extension
else
	-- load plugins
	require("youzhi.lazy")

	-- Obsidian settings
	vim.cmd("noremap <leader>oo :ObsidianOpen<cr>")
	vim.opt.conceallevel = 2
	vim.api.nvim_create_autocmd("VimEnter", {
		callback = function()
			if vim.env.TMUX and vim.fn.exists(":Obsession") == 2 then
				vim.cmd("silent! Obsession")
			end
		end,
	})
end
