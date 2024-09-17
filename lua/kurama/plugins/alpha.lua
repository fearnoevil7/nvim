local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

-- dashboard.section.header.val = {
--     [[                               __                ]],
--     [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
--     [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
--     [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
--     [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
--     [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
-- }
dashboard.section.header.val = {
    [[    ███╗   ███╗ █████╗ ██╗  ██╗███████╗   ]],
    [[    ████╗ ████║██╔══██╗██║ ██╔╝██╔════╝   ]],
    [[    ██╔████╔██║███████║█████╔╝ █████╗     ]],
    [[    ██║╚██╔╝██║██╔══██║██╔═██╗ ██╔══╝     ]],
    [[    ██║ ╚═╝ ██║██║  ██║██║  ██╗███████╗   ]],
    [[    ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝   ]],
    [[      ██████╗ ██████╗  ██████╗ ██╗        ]],
    [[     ██╔════╝██╔═══██╗██╔═══██╗██║        ]],
    [[     ██║     ██║   ██║██║   ██║██║        ]],
    [[     ██║     ██║   ██║██║   ██║██║        ]],
    [[     ╚██████╗╚██████╔╝╚██████╔╝███████╗   ]],
    [[      ╚═════╝ ╚═════╝  ╚═════╝ ╚══════╝   ]],
    [[███████╗████████╗██╗   ██╗███████╗███████╗]],
    [[██╔════╝╚══██╔══╝██║   ██║██╔════╝██╔════╝]],
    [[███████╗   ██║   ██║   ██║█████╗  █████╗  ]],
    [[╚════██║   ██║   ██║   ██║██╔══╝  ██╔══╝  ]],
    [[███████║   ██║   ╚██████╔╝██║     ██║     ]],
    [[╚══════╝   ╚═╝    ╚═════╝ ╚═╝     ╚═╝     ]],
}

local function lineColor(lines, popStart, popEnd)
    local out = {}
    for i, line in ipairs(lines) do
        local hi = "StartLogo" .. i
        if i > popStart and i <= popEnd then
            hi = "StartLogoPop" .. i - popStart
        elseif i > popStart then
            hi = "StartLogo" .. i - popStart
        else
            hi = "StartLogo" .. i
        end
        table.insert(out, { hi = hi, line = line })
    end
    return out
end

local headers = {
    lineColor(dashboard.section.header.val, 6, 12),
}

local function header_chars()
    math.randomseed(os.time())
    return headers[math.random(#headers)]
end

-- Map over the headers, setting a different color for each line.
-- This is done by setting the Highligh to StartLogoN, where N is the row index.
-- Define StartLogo1..StartLogoN to get a nice gradient.
local function header_color()
    local lines = {}
    for _, lineConfig in pairs(header_chars()) do
        local hi = lineConfig.hi
        local line_chars = lineConfig.line
        local line = {
            type = "text",
            val = line_chars,
            opts = {
                hl = hi,
                shrink_margin = false,
                position = "center",
            },
        }
        table.insert(lines, line)
    end

    local output = {
        type = "group",
        val = lines,
        opts = { position = "center" },
    }

    return output
end

local function configure()
    local theme = require("alpha.themes.theta")
    local themeconfig = theme.config
    local buttons = {
        type = "group",
        val = {
            { type = "text", val = "Quick links", opts = { hl = "SpecialComment", position = "center" } },
            { type = "padding", val = 1 },
            dashboard.button("e", "  New file", "<cmd>ene<CR>"),
            dashboard.button("SPC f", "  Find file"),
            dashboard.button("SPC F", "  Find text"),
            dashboard.button("u", "󱐥  Update plugins", "<cmd>Lazy sync<CR>"),
            dashboard.button("t", "  Install language tools", "<cmd>Mason<CR>"),
            dashboard.button("q", "󰩈  Quit", "<cmd>qa<CR>"),
        },
        position = "center",
    }

    themeconfig.layout[2] = header_color()

    return themeconfig
end

dashboard.section.buttons.val = {
    dashboard.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
    dashboard.button("q", "󰅚  Quit NVIM", ":qa<CR>"),
}

-- local handle = io.popen("fortune")
--
-- local fortune = handle:read("*a")
-- themeconfig.layout[2] = header_color()
-- handle:close()
--
-- dashboard.section.footer.val = fortune

dashboard.config.opts.noautocmd = true

vim.cmd([[autocmd User AlphaReady echo 'ready']])

alpha.setup(configure())
