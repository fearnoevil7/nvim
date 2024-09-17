-- Treesitter Plugin Configs
local configs = require("nvim-treesitter.configs")
configs.setup({
    ensure_installed = { "c", "lua", "vim", "javascript", "html", "css", "typescript", "rust", "php", "cpp" },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    indent = { enable = true },
})

-- To view the treesitter AST tree use the following commands :TSPlaygroundToggle

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

parser_config.blade = {
    install_info = {
        url = "https://github.com/EmranMR/tree-sitter-blade",
        files = { "src/parser.c" },
        branch = "main",
    },
    filetype = "blade",
}
