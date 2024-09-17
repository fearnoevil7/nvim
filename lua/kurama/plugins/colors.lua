function setColorScheme(color)
    -- Require Plugin
    -- require("rose-pine").setup()
    -- vim.cmd.colorscheme "rose-pine"

    color = color or "catppuccin"
    vim.cmd.colorscheme(color)
    require(color).setup()

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

-- setColorScheme("rose-pine")
-- setColorScheme("catppuccin")

--pine- Custom Color Schemes Saved @ "~/nvim/colors/adCode.vim"
vim.cmd.colorscheme("adCode")

-- Set Opacity.
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
