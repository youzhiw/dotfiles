return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require("harpoon")
        harpoon:setup({})
        local conf = require("telescope.config").values

        -- NEW: live grep through Harpoon files
        local function harpoon_live_grep()
            local list = harpoon:list()
            local file_paths = {}

            for _, item in ipairs(list.items) do
                table.insert(file_paths, item.value)
            end

            if #file_paths == 0 then
                print("Harpoon list is empty!")
                return
            end
            local telescope = require("telescope.builtin")

            local keymap = vim.keymap

            telescope.live_grep({
                search_dirs = file_paths,
            })
        end

        local function toggle_telescope(harpoon_files)
            local file_paths = {}
            for _, item in ipairs(harpoon_files.items) do
                table.insert(file_paths, item.value)
            end

            require("telescope.pickers")
                .new({}, {
                    prompt_title = "Harpoon",
                    finder = require("telescope.finders").new_table({
                        results = file_paths,
                        entry_maker = require("telescope.make_entry").gen_from_file({ path_display = { "filename_first", "smart" } }),
                    }),
                    previewer = conf.file_previewer({}),
                    sorter = conf.generic_sorter({}),
                })
                :find()
        end
        -- Auto-add current file to Harpoon list on write
        vim.api.nvim_create_autocmd("BufWritePost", {
            callback = function()
                local ok, harpoon = pcall(require, "harpoon")
                if ok then
                    harpoon:list():add()
                end
            end,
        })
        -- Keymaps
        vim.keymap.set("n", "<leader>hg", harpoon_live_grep, { desc = "Live grep Harpoon files" })
        vim.keymap.set("n", "<C-e>", function()
            toggle_telescope(harpoon:list())
        end, { desc = "Open harpoon window" })
        vim.keymap.set("n", "<leader>hh", function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end)
        vim.keymap.set("n", "<leader>ha", function()
            harpoon:list():add()
        end)
        vim.keymap.set("n", "<leader>hn", function()
            harpoon:list():prev()
        end)
        vim.keymap.set("n", "<leader>hm", function()
            harpoon:list():next()
        end)
        vim.keymap.set("n", "<leader>hr", function()
            harpoon:list():remove()
        end)
        vim.keymap.set("n", "<leader>1", function()
            harpoon:list():select(1)
        end)
        vim.keymap.set("n", "<leader>2", function()
            harpoon:list():select(2)
        end)
        vim.keymap.set("n", "<leader>3", function()
            harpoon:list():select(3)
        end)
        vim.keymap.set("n", "<leader>4", function()
            harpoon:list():select(4)
        end)
        vim.keymap.set("n", "<leader>5", function()
            harpoon:list():select(5)
        end)
        vim.keymap.set("n", "<leader>6", function()
            harpoon:list():select(6)
        end)
        vim.keymap.set("n", "<leader>7", function()
            harpoon:list():select(7)
        end)
        vim.keymap.set("n", "<leader>8", function()
            harpoon:list():select(8)
        end)
    end,
}
