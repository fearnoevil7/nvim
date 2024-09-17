--vim.keymap.set("n", "<C-N>", "<cmd>NvimTreeToggle<CR>")
vim.api.nvim_set_keymap("n", "<C-g>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

local function my_on_attach(bufnr)
    local api = require("nvim-tree.api")

    local function opts(desc)
        return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- default mappings
    api.config.mappings.default_on_attach(bufnr)

    -- custom mappings
    vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
end

require("nvim-tree").setup({
    on_attach = my_on_attach,
    view = {
        width = 35,
        relativenumber = true,
    },

    renderer = {
        indent_markers = {
            enable = true,
        },

        icons = {
            glyphs = {
                folder = {
                    arrow_closed = "↓",
                    arrow_open = "→",
                },
            },
        },
    },

    filters = {
        dotfiles = true,
    },
})
