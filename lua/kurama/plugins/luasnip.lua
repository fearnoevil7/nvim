local luasnip = require("luasnip")
local s = luasnip.snippet

-- This is an insert node.
-- It takes a position (like $1) and optionally some default text.
-- i(<position>, [default_text])
local i = luasnip.insert_node
-- The jump position for nodes that normally require one (can be nill)be nill).
local c = luasnip.choice_node
local f = luasnip.function_node

-- This will expand the current item or jump to the next item within the snippet.
vim.keymap.set({ "i", "s" }, "<C-K>", function()
    if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
    end
end, { silent = true })

-- This always moves to the previous item within the snippet.
vim.keymap.set({ "i", "s" }, "<C-J>", function()
    if luasnip.jumpable(-1) then
        luasnip.jump(-1)
    end
end, { silent = true })

-- This is useful for choice nodes.
vim.keymap.set({ "i" }, "<C-L>", function()
    if luasnip.choice_active() then
        luasnip.change_choice(1)
    end
end, { silent = true })

-- Shortcut to source luasnip file again, which will reload my snippets.
vim.keymap.set("n", "<leader><leader>s", "<cmd>source ~/.config/nvim/lua/kurama/plugins/luasnip.lua<CR>")

luasnip.add_snippets("all", {

    -- Using function nodes to set the current time.
    -- luasnip.snippet("currenttime", ),
    s(
        "curtime",
        f(function()
            return os.date("%D - %H:%M")
        end)
    ),
})

local customLuaSnippets = require("custom.snippets.lua")

local customPhpSnippets = require("custom.snippets.php")
