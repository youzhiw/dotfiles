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
vim.cmd("nmap <leader>c :e ~/.config/nvim/init.lua<cr>")

-- save
vim.cmd("nmap <leader>s :w<cr>")

-- close tab
vim.cmd("nmap <leader>q :tabclose<cr>")

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
vim.keymap.set("n", "<leader>n", ":bn<cr>")
vim.keymap.set("n", "<leader>p", ":bp<cr>")
vim.keymap.set("n", "<leader>x", ":bd<cr>")

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

vim.api.nvim_create_autocmd("FileType", {
	pattern = "tex",
	callback = function()
		vim.opt_local.tabstop = 2
		vim.opt_local.shiftwidth = 2
		vim.opt_local.expandtab = true
	end,
})
