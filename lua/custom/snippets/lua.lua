local luasnip = require("luasnip")

local s = luasnip.snippet
-- This is an insert node.
-- It takes a position (like $1) and optionally some default text.
-- i(<position>, [default_text])
local i = luasnip.insert_node

-- Function node.
local f = luasnip.function_node

-- This is a format node.
-- It takes a format string, and list of nodes.
-- fmt(<fmt_string>, {...nodes})
local fmt = require("luasnip.extras.fmt").fmt

-- Repeats a node.
-- rep(<position>)
local rep = require("luasnip.extras").rep
local snippetProxy = require("luasnip.nodes.snippetProxy")

local same = function(index)
    return f(function(arg)
        -- Console.log for vim.
        -- print(vim.inspect(arg))
        return arg[1]
    end, { index })
end

luasnip.add_snippets("lua", {
    -- Parse snippet on startup.
    luasnip.snippet("!MyFirstSnippet", luasnip.text_node("-- this is what gets expanded.")),
    -- Parse snippet on upon expansion.. Info: https://github.com/L3MON4D3/LuaSnip/blob/master/DOC.md
    snippetProxy("expand", "-- this is what was expanded!"),
    snippetProxy("lf", "local $1 = function($2)\n  $0\nend"),
    snippetProxy("mf", "$1.$2 = function($3)\n $0\nend"),
    -- Intro to function nodes.
    s("sametest", fmt([[example: {}, function: {}]], { i(1), same(1) })),

    s(
        "req",
        fmt([[local {} = require "{}"]], {
            f(function(import_name)
                -- print(vim.inspect(import_name))
                local parts = vim.split(import_name[1][1], ".", true)
                return parts[#parts] or ""
            end, { 1 }), -- 1 = luasnip.insert_node(1)
            i(1), -- Causes cursor to start infront of "require".
        })
    ),

    luasnip.snippet("req", fmt([[local {} = require "{}"]], { luasnip.insert_node(1, "default"), rep(1) })),
})
