local bufferline = require("bufferline")

bufferline.setup({
    options = {
        mode = "buffers", -- set to "tabs" to only show tabpages instead
        style_preset = bufferline.style_preset.default, -- or bufferline.style_preset.minimal,
        themable = true, -- allows highlight groups to be overriden i.e. sets highlights as default
        -- separator_style = "thick",
        separator_style = "thick",
    },
})
