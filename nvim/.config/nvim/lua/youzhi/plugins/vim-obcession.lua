return {
    "tpope/vim-obsession",
    config = function()
        vim.api.nvim_create_autocmd("VimEnter", {
            nested = true,
            callback = function()
                if vim.fn.argc() == 0 and vim.fn.filereadable(".Session.vim") == 1 then
                    vim.cmd("source .Session.vim")
                end
            end
        })
        vim.api.nvim_create_user_command("Obsess", function()
            vim.cmd("Obsession .Session.vim")
        end, { bang = true })
    end
}
