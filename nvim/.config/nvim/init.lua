require("youzhi.vim-options")
if vim.g.vscode then
    vim.cmd('nmap j gj')
    vim.cmd('nmap k gk')
    -- VSCode extension
else
-- load plugins
		require("youzhi.lazy")

-- Obsidian settings
		vim.cmd('noremap <leader>oo :ObsidianOpen<cr>')
		vim.opt.conceallevel = 2
end
