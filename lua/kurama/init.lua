print("Hello from kurama")

-- Autocommands
-- To view autocommand events use the following command. ":help events"

-- Source: https://m.youtube.com/watch?v=m8C0Cq9Uv9o
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("highlight-yank-on-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

function xcode_autocomplete()
    local currentPosition = vim.api.nvim_win_get_cursor(0)
    local line_number, indexAtCurrentPosition = unpack(currentPosition)
    local current_line = vim.api.nvim_get_current_line()
    local characterAtCurrentIndex = current_line:sub(indexAtCurrentPosition, indexAtCurrentPosition)

    local closingCharacter
    if characterAtCurrentIndex == '"' then
        local count_quotes = 0
        for doubleQuote in current_line:gmatch('"') do
            count_quotes = count_quotes + 1
        end
        if count_quotes % 2 == 1 then
            if vim.v.char ~= '"' then
                closingCharacter = '"'
            end
        end
    elseif characterAtCurrentIndex == "'" then
        local count_quotes = 0
        for singleQuotes in current_line:gmatch("'") do
            count_quotes = count_quotes + 1
        end
        if count_quotes % 2 == 1 then
            closingCharacter = "'"
        end
    elseif characterAtCurrentIndex == "[" then
        local count_square_brackets = 0
        for squareBracketPairs in current_line:gmatch("[%[%]]") do
            count_square_brackets = count_square_brackets + 1
        end

        if count_square_brackets % 2 == 1 then -- Comparing to the remainder of bracket pairs. Can also count the number of opening brackets and compare to that as well for more fine grained control.
            if vim.v.char == '"' then
                closingCharacter = '"]'
            elseif vim.v.char ~= "]" then
                closingCharacter = "]"
            end
        end
    elseif characterAtCurrentIndex == "{" then
        local count_bracket_pairs = 0
        for bracketPair in current_line:gmatch("[%{%}]") do
            count_bracket_pairs = count_bracket_pairs + 1
        end
        -- local count_opening_brackets = 0
        -- for openingBracket in current_line:gmatch("[%{]") do
        --     count_opening_brackets = count_opening_brackets + 1
        -- end

        if count_bracket_pairs % 2 == 1 then
            if vim.v.char == '"' then
                closingCharacter = '"}'
            elseif vim.v.char ~= "}" then
                closingCharacter = "}"
            end
        end
    elseif characterAtCurrentIndex == "(" then
        local count_parentheses_pairs = 0
        for parenthesesPairs in current_line:gmatch("[%(%)]") do
            count_parentheses_pairs = count_parentheses_pairs + 1
        end

        print("Number of parentheses: ", count_parentheses_pairs)

        if count_parentheses_pairs % 2 == 1 then
            if vim.v.char == '"' then
                closingCharacter = '")'
            elseif vim.v.char == "{" then
                closingCharacter = "})"
            elseif vim.v.char ~= ")" then
                closingCharacter = ")"
            end
        end
    elseif characterAtCurrentIndex == "<" and vim.g.Enable_Xcode_Autocomplete == true then
        closingCharacter = ">"
    end

    -- Neovim throws an error if you try and edit text in an autocommand in order to work around this you must use the "schedule" function or "defer_fn" function which will then run the code that edits text when in a safer context.
    vim.schedule(function()
        current_line = vim.api.nvim_get_current_line()
        local current_buffer = vim.api.nvim_get_current_buf()

        if
            pcall(function() -- https://www.lua.org/pil/8.4.html
                vim.api.nvim_buf_set_text(
                    current_buffer,
                    line_number - 1,
                    indexAtCurrentPosition + 1,
                    line_number - 1,
                    indexAtCurrentPosition + 1,
                    { closingCharacter }
                )
                -- print(
                --     "Success!  Line Number - 1: "
                --         .. line_number - 1
                --         .. " indexAtCurrentPosition + 1: "
                --         .. indexAtCurrentPosition + 1
                --         .. " characterAtCurrentIndex: "
                --         .. characterAtCurrentIndex
                --         .. " vim.v.char: "
                --         .. vim.v.char
                --         .. " characterAtCurrentIndex + 1: "
                --         .. current_line:sub(indexAtCurrentPosition + 1, indexAtCurrentPosition + 1)
                --         .. " Current Line: "
                --         .. line_number
                -- )

                -- print("Current Line: ", current_line, " *Line Number: ", line_number)
            end)
        then
        else
            print(
                "Error!  Line Number - 1: "
                    .. line_number - 1
                    .. " indexAtCurrentPosition + 1: "
                    .. indexAtCurrentPosition + 1
                    .. " Current Line: "
                    .. line_number
            )
        end
    end)
end

vim.api.nvim_create_autocmd("InsertCharPre", {
    desc = "Replicate xcode auto completion.",
    group = vim.api.nvim_create_augroup("xcode-autocomplete", { clear = true }),
    callback = function()
        -- if vim.g.Enable_Xcode_Autocomplete == true then
        --     xcode_autocomplete()
        -- end
        xcode_autocomplete()
    end,
})

vim.on_key(function(key) -- Function that runs on key press.
    -- if key == vim.api.nvim_replace_termcodes("<CR>", true, true, true) then -- In Neovim Lua scripting, "nvim_replace_termcodes" is a function provided by the API that allows you to convert special key sequences or characters into their corresponding termcodes. Termcodes are representations of special keys or key combinations that Neovim understands and can interpret correctly, especially in mappings or keybindings.
    --     print("Enter key pressed!")
    -- end

    -- Checking if the enter key was pressed in insert mode and if the previous line has an opening bracket, parentheses, or square bracket... create a new line with the matching closing bracket.
    if key == "\13" and vim.fn.mode() == "i" then -- Making a comparison to the ascii value of the enter key.
        local current_line = vim.api.nvim_get_current_line()
        local line_length = #current_line
        local bufnr, line_number, indexAtCurrentPosition = unpack(vim.fn.getcurpos())

        if indexAtCurrentPosition == line_length + 1 then
            -- print("Line Length: ", line_length)
            -- print("Enter key pressed!      CurrentLine: ", current_line)
            -- print("Enter key pressed!      CurrentLine: ", unpack(vim.fn.getcurpos()))

            if current_line:sub(line_length, line_length) == "{" then
                vim.api.nvim_buf_set_lines(bufnr, line_number, line_number, false, { "}" })
            elseif current_line:sub(line_length, line_length) == "(" then
                vim.api.nvim_buf_set_lines(bufnr, line_number, line_number, false, { ")" })
            elseif current_line:sub(line_length, line_length) == "[" then
                vim.api.nvim_buf_set_lines(bufnr, line_number, line_number, false, { "]" })
            end
            -- else
            --     print("cursor is not at the end of the line")
        elseif indexAtCurrentPosition == line_length then
            if
                current_line:sub(line_length, line_length) == ")"
                and current_line:sub(line_length - 1, line_length - 1) == "{"
            then
                local current_buffer = vim.api.nvim_get_current_buf()
                vim.api.nvim_buf_set_text(
                    current_buffer,
                    line_number - 1,
                    line_length - 1,
                    line_number - 1,
                    line_length - 1,
                    { "}" }
                )
            end
        end
    end
end)

local color_scheme = vim.api.nvim_create_augroup("color_scheme", { clear = true })
vim.api.nvim_create_autocmd("ColorScheme", {
    desc = "Modify cursorline color.",
    group = color_scheme,
    pattern = "*",
    callback = function()
        -- vim.api.nvim_set_hl(0, "CursorLineNr", { ctermbg = red })
        -- vim.api.nvim_command("highlight CursorLine guibg=#444444")

        vim.api.nvim_command("highlight CursorLine guibg=#6B6B6B gui=bold cterm=bold")

        -- vim.api.nvim_command("highlight Visual guibg=#A2A2F9")
        vim.api.nvim_command("highlight Visual guibg=#A2C3F9 gui=bold cterm=bold")
    end,
})

local toggle_xcode_autocomplete_group = vim.api.nvim_create_augroup("toggle_xcode_autocomplete", { clear = true })
vim.api.nvim_create_autocmd("BufEnter", {
    desc = "Turn off certain xcode autocomplete features when entering buffers opened with certain file extensions.",
    group = toggle_xcode_autocomplete_group,
    pattern = "*.php,*.cpp",
    callback = function()
        vim.g.Enable_Xcode_Autocomplete = false
    end,
})
vim.api.nvim_create_autocmd("BufLeave", {
    desc = "Renable xcode autocomplete features that may have been turned off.",
    group = toggle_xcode_autocomplete_group,
    pattern = "*.php,*.cpp",
    callback = function()
        vim.g.Enable_Xcode_Autocomplete = true
    end,
})

vim.api.nvim_create_autocmd(
    { "BufEnter", "WinEnter", "WinNew", "VimResized" }, -- Event list
    {
        group = vim.api.nvim_create_augroup("VCenterCursor", { clear = true }), -- Use the created augroup
        pattern = "*", -- Apply to all buffers
        callback = function()
            -- Set scrolloff to half the window height
            local win_id = vim.api.nvim_get_current_win()
            local win_height = vim.api.nvim_win_get_height(win_id)
            vim.wo.scrolloff = math.floor(win_height / 2)
        end,
    }
)

-- vim.api.nvim_create_autocmd("ModeChanged", {
--     desc = "Turn off hlsearch when entering insert mode.",
--     group = vim.api.nvim_create_augroup("mode_changed_from_normal_to_insert", { clear = true }),
--     pattern = "*",
--     callback = function()
--         -- if vim.v.event.new_mode == "i" then
--         --     vim.opt.hlsearch = false
--         -- elseif vim.v.event.new_mode == "n" then
--         --     vim.opt.hlsearch = true
--         -- end
--         vim.cmd(":noh")
--
--         -- print("Old Mode: ", vim.v.event.old_mode, "New Mode: ", vim.v.event.new_mode)
--     end,
-- })
