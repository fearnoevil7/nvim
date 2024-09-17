local luasnip = require("luasnip")

-- This is a format node.
-- It takes a format string, and list of nodes.
-- fmt(<fmt_string>, {...nodes})
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local bladeTemplateAutoCommandGroup = vim.api.nvim_create_augroup("is_it_a_php_blade_template", { clear = true })
vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
        local currentFilePath = vim.fn.expand("%")
        -- local parts = vim.split(currentFilePath, "/", true)
        -- local currentFile = parts[#parts]

        local same = function(index)
            return luasnip.function_node(function(arg)
                -- Console.log for vim.
                -- print(vim.inspect(arg))
                return arg[1]
            end, { index })
        end

        luasnip.add_snippets("blade", {
            -- snippetProxy(
            --     "!DOC",
            --     '<!DOCTYPE html>\n<HTML lang="en">\n\n<HEAD>\n\t<TITLE>$1</TITLE>\n\t<meta charset="utf-8">\n\t<meta name="viewport" content="width=device-width, initial-scale=1.0">\n\t$0\n</HEAD>\n\n<BODY>\n\t$1\n</BODY>\n\n</HTML>'
            -- ),
            luasnip.snippet(
                "!DOCTYPE",
                fmt(
                    [[
                    <!DOCTYPE html>
                    <HTML lang="en">

                    <HEAD>
                        <TITLE>{}</TITLE>
                        <meta charset="utf-8">
                        <meta name="viewport" content="width=device-width, initial-scale=1.0">
                        {}
                    </HEAD>

                    <BODY>
                        {}
                    </BODY>

                    </HTML>
                ]],
                    {
                        luasnip.insert_node(2),
                        luasnip.choice_node(
                            1,
                            { luasnip.text_node("@vite('resources/js/app.js')"), luasnip.text_node("") }
                        ),
                        luasnip.insert_node(0),
                    }
                )
            ),

            luasnip.snippet(
                { trig = ">" },
                fmt([[<{}{}{}>{}</{}>]], {
                    luasnip.insert_node(1, "div"),
                    luasnip.choice_node(3, { luasnip.text_node(""), luasnip.text_node(' class=""') }),
                    luasnip.choice_node(4, { luasnip.text_node(""), luasnip.text_node(' type=""') }),
                    luasnip.insert_node(0),
                    luasnip.choice_node(2, { luasnip.text_node("div"), luasnip.text_node("") }),
                })
            ),

            luasnip.snippet(
                { trig = ">" },
                fmt([[<{}{}{}/>]], {
                    luasnip.insert_node(0, "input"),
                    luasnip.choice_node(1, { luasnip.text_node(""), luasnip.text_node(' type=""') }),
                    luasnip.choice_node(2, { luasnip.text_node(""), luasnip.text_node(' class=""') }),
                })
            ),
        })
    end,
    group = bladeTemplateAutoCommandGroup,
})
