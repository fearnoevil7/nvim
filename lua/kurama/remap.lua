-- Keymaps - :help mapping, :help leader, :help key-notation

-- Establishes the key that will be used as the leader key.
vim.g.mapleader = " "

-- Remap page up and page down.
vim.api.nvim_set_keymap("n", "<F8>", "<C-D>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<F8>", "<C-D>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<F9>", "<C-U>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<F9>", "<C-U>", { noremap = true, silent = true })
vim.keymap.set({ "n", "i" }, "<C-X>", function()
    os.execute("/Users/kurama/Assets/Tools/CenterCursorInApp")
end)

-- Toggle auto text wrapping.
vim.keymap.set({ "n", "i" }, "<F6>", function()
    if vim.o.wrap then
        vim.opt.wrap = false
    else
        vim.opt.wrap = true
    end
end)

-- Insert Mode on mouse click.
vim.keymap.set({ "n" }, "<LeftMouse>", vim.cmd.startinsert)

-- This line states that while in normal mode (denoted by "n") it will execute the cmd "Ex" using the keys leader + pv
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Undo Tree Plugin Keybinding.
-- To Switch to Undo Tree Panel press "Control + W" twice.
vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)

-- FZF Plugin Keybinding.
-- vim.keymap.set({ "n", "i" }, "<F3>", vim.cmd.FZF("!"))
-- How to call vim commands in neovim using lua.
vim.api.nvim_set_keymap("n", "<F3>", ":FZF! ~<CR>", { noremap = true, silent = true })

-- Buffer Keymaps - :help buffers
-- vim.keymap.set({ "n", "i" }, "<F2>", vim.cmd.buffers)
vim.keymap.set({ "n", "i" }, "<S-Right>", vim.cmd.bnext)
vim.keymap.set({ "n", "i" }, "<S-Left>", vim.cmd.bprevious)
vim.keymap.set({ "n", "i" }, "<CS-W>", vim.cmd.bd)

-- Window Keymaps - :help windows, :help opening-window, :help window-move-cursor, :help window-moving, :help window-resize
-- Split Horizontal
vim.keymap.set({ "n", "i" }, "<c-'>", vim.cmd.split)
-- Split Vertical
vim.keymap.set({ "n", "i" }, "<c-;>", vim.cmd.vsplit)
-- Close split window.
vim.keymap.set({ "n", "i" }, "<c-W>", vim.cmd.clo)

-- Move cursor to other window.
vim.api.nvim_set_keymap("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-j>", "<C-w>j", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-k>", "<C-w>k", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-h>", "<C-w>h", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-l>", "<C-w>l", { noremap = true, silent = true })
-- Move window.
vim.api.nvim_set_keymap("n", "<SC-j>", "<C-W>J", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<SC-j>", "<C-W>J", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<SC-k>", "<C-W>K", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<SC-k>", "<C-W>K", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<SC-h>", "<C-W>H", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<SC-h>", "<C-W>H", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<SC-l>", "<C-W>L", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<SC-l>", "<C-W>L", { noremap = true, silent = true })
-- Window resizing.
-- Make all windows equal.
vim.api.nvim_set_keymap("n", "<C-=>", "<C-W>=", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-=>", "<C-W>=", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-+>", "<C-W>+", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-+>", "<C-W>+", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-->", "<C-W>-", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-->", "<C-W>-", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<CS-+>", "<C-W>>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<CS-+>", "<C-W>>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<CS-->", "<C-W><", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<CS-->", "<C-W><", { noremap = true, silent = true })

-- Glow Plugin Keybindings
-- Bind "F4" to open Vim CheatSheet Markdown file with "Glow".
vim.keymap.set({ "n", "i" }, "<F4>", function()
    vim.cmd.Glow("~/MyTips/vimTips.md")
end)

vim.keymap.set({ "n", "i" }, "<F5>", function()
    vim.cmd.Glow("~/MyTips/nvimKeybindings.md")
end)

vim.g.Enable_Xcode_Autocomplete = true

-- init.lua autocommand
vim.keymap.set({ "n" }, "<leader>x", function()
    if vim.g.Enable_Xcode_Autocomplete == true then
        vim.g.Enable_Xcode_Autocomplete = false
    elseif vim.g.Enable_Xcode_Autocomplete == false then
        vim.g.Enable_Xcode_Autocomplete = true
    end

    print("toggling Enable_Xcode_Autocomplete", vim.g.Enable_Xcode_Autocomplete)
end)
