return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-ui-select.nvim",
            "debugloop/telescope-undo.nvim",
        },
        config = function()
            local telescope = require("telescope")
            local builtin = require("telescope.builtin")

            telescope.setup({
                defaults = {
                    file_ignore_patterns = { "node_modules", ".git/" },
                    path_display = { "filename_first", "smart" },
                    mappings = {
                        i = {
                            ["<C-p>"] = require('telescope.actions.layout').toggle_preview,
                        },
                        n = {
                            ["<C-p>"] = require('telescope.actions.layout').toggle_preview,
                        },
                    },
                    layout_strategy = "horizontal",
                    layout_config = {
                        width = 0.99,
                        height = 0.99,
                        preview_width = 0.6,
                        prompt_position = "top",
                    },
                    sorting_strategy = "ascending",
                },
                pickers = {
                    find_files = {
                        hidden = true,
                    },
                    live_grep = {
                        additional_args = function()
                            return { "--hidden" }
                        end,
                    },
                },
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({}),
                    },
                    undo = {
                        mappings = {
                            i = {
                                ["<s-cr>"] = require("telescope-undo.actions").yank_additions,
                                ["<c-cr>"] = require("telescope-undo.actions").yank_deletions,
                                ["<cr>"] = require("telescope-undo.actions").restore
                            },
                            n = {
                                ["<s-cr>"] = require("telescope-undo.actions").yank_additions,
                                ["<c-cr>"] = require("telescope-undo.actions").yank_deletions,
                                ["<cr>"] = require("telescope-undo.actions").restore
                            },
                        },
                    },
                },
            })

            telescope.load_extension("ui-select")
            telescope.load_extension("undo")

            vim.keymap.set("n", "<leader>f", builtin.find_files, {})
            vim.keymap.set("n", "<leader>g", builtin.live_grep, {})
            vim.keymap.set("n", "<leader>b", builtin.buffers, {})
            vim.keymap.set("n", "<leader>h", builtin.help_tags, {})
            vim.keymap.set("n", "<leader>sr", builtin.lsp_references, {})
            vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>")
        end,
    },

}
