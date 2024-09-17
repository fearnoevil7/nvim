local builtin = require("telescope.builtin")
local actions = require("telescope.actions")
local action_layout = require("telescope.actions.layout")

vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})

-- Custom function bound to the mapped key.
-- Function is calling one of telescope's "Builtins" which "is a collection of community maintained pickers to support common workflows". Refer to the man pages for more info ":help telescope" or ":help telescope.builtin"
-- This function will prompt you for a string and then look for every instance of that string in every file.
vim.keymap.set("n", "<leader>ps", function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)

-- Search from home directory.
--vim.keymap.set("n", "<F3>", function()
--    builtin.find_files({ cwd = "~/" })
--end, { desc = "[S]earch [N]eovim files" })

return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.6",

    -- or                              , branch = '0.1.x',
    dependencies = {
        "nvim-lua/plenary.nvim",
        --"nvim-telescope/telescope-fzf-native.nvim",
    },

    require("telescope").setup({

        defaults = {
            prompt_prefix = "🔎 ",
            selection_caret = "🎯",
            path_display = "absolute",
            dynamic_preview_title = "true",
            layout_strategy = "flex",
            preview_cutoff = 10,
            layout_config = {
                horizontal = {
                    height = 0.9999999,
                    width = 0.9999999,
                    preview_width = 0.6,
                },
                vertical = {
                    height = 0.9999999,
                    prompt_position = "bottom",
                    width = 0.9999999,
                    preview_height = 0.7,
                },
            },

            layout_options = {
                preview_width = 0.75,
            },

            mappings = {
                -- "n" stands for vim normal mode.
                n = {
                    -- Toggle preview window. Bound to Command + Shift + F
                    ["<F2>"] = action_layout.toggle_preview,
                    -- Preview Scroll Up. Bound to Command + Up Arrow
                    ["<F9>"] = actions.preview_scrolling_up,
                    -- Preview Scroll Down. Bound to Command + Down Arrow
                    ["<F8>"] = actions.preview_scrolling_down,
                    -- Results Scroll Up. Bound to Command + Option + Up Arrow
                    ["<D-F9>"] = actions.results_scrolling_up,
                    -- Results Scroll Down. Bound to Command + Option + Down Arrow
                    ["<D-F8>"] = actions.results_scrolling_down,
                },

                -- "i" stands for vim insert mode
                i = {
                    -- Toggle preview window. Bound to Command + Shift + F
                    ["<F2>"] = action_layout.toggle_preview,
                    -- Preview Scroll Up. Bound to Command + Up Arrow
                    ["<F9>"] = actions.preview_scrolling_up,
                    -- Preview Scroll Down. Bound to Command + Down Arrow
                    ["<F8>"] = actions.preview_scrolling_down,
                    -- Results Scroll Up. Bound to Command + Option + Up Arrow
                    ["<D-F9>"] = actions.results_scrolling_up,
                    -- Results Scroll Down. Bound to Command + Option + Down Arrow
                    ["<D-F8>"] = actions.results_scrolling_down,
                },
            },
        },

        pickers = {},

        extensions = {},
    }),
}
