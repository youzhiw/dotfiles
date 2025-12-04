-- source previous vim configs
vim.cmd.source("~/.vimrc")

-- set tab space
vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")

-- <leader> key
vim.keymap.set("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- show line number
vim.opt.number = true
vim.opt.relativenumber = true

-- paste without overwriting
vim.keymap.set("v", "p", "P")

-- redo
vim.keymap.set("n", "U", "<C-r>")

-- Map jj to ESC in insert mode
vim.api.nvim_set_keymap("i", "jj", "<Esc>", { noremap = true })

-- clear search highlighting
vim.keymap.set("n", "<Esc>", ":nohlsearch<cr>")

-- open config
vim.keymap.set("n", "<leader>cc", function()
	vim.cmd.cd(vim.fn.stdpath("config")) -- usually ~/.config/nvim
	vim.cmd.edit("init.lua")
end, { silent = true, desc = "CD into config and open init.lua" })

-- save
vim.cmd("nmap <leader>s :w<cr>")

-- close tab
vim.cmd("nmap <leader>q :q<cr>")

-- skip folds (down, up)
-- vim.cmd('nmap j gj')
-- vim.cmd('nmap k gk')

-- sync system clipboard
--vim.g.clipboard = {
-- name = "xsel",
-- copy = {
--  ["+"] = "xsel --nodetach -i -b",
--  ["*"] = "xsel --nodetach -i -p",
-- },
-- paste = {
--  ["+"] = "xsel  -o -b",
--  ["*"] = "xsel  -o -b",
-- },
-- cache_enabled = 1,
--}
vim.opt.clipboard = "unnamedplus"

-- search ignoring case
vim.opt.ignorecase = true

-- disable "ignorecase" option if the search parttern contains upper case characters
vim.opt.smartcase = true

-- split right
vim.opt.splitright = true

-- fold option
vim.opt.foldmethod = "indent"
vim.opt.foldlevelstart = 99

--tab option
vim.keymap.set("n", "<leader>n", "gt", { silent = true })
vim.keymap.set("n", "<leader>p", "gT", { silent = true })

--lsp
-- vim.keymap.set("n", "<leader>mp", ":silent !black %<cr>")

--scrolloff
vim.o.scrolloff = 5

--cursor
-- vim.opt.guicursor = "a:blinkon0"  -- Disable Neovim's cursor blink control
--
--
vim.opt.tabstop = 8
vim.opt.shiftwidth = 8
vim.opt.expandtab = false

-- Command: :OpenBootlinHere
vim.api.nvim_create_user_command("OpenBootlinHere", function()
	local file = vim.fn.expand("%:p")
	if file == "" then
		vim.notify("No file", vim.log.levels.WARN)
		return
	end
	local line = tostring(vim.fn.line("."))
	local script = vim.fn.expand("~/dotfiles/scripts/open_bootlin.sh")
	if vim.fn.executable(script) == 0 then
		vim.notify("Script not found or not executable: " .. script, vim.log.levels.ERROR)
		return
	end
	-- Run detached so Neovim isn't blocked
	vim.fn.jobstart({ script, file, line }, { detach = true })
end, {})

-- Keymap: <leader>lx to open current file on Bootlin v6.14
vim.keymap.set("n", "<leader>lx", ":OpenBootlinHere<CR>", { silent = true, desc = "Open file on Bootlin v6.14" })
