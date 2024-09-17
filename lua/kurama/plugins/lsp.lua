-- PrimeEdgen's Config but he uses packer!!!

-- return {
--     "neovim/nvim-lspconfig",
--     dependencies = {
--         "williamboman/mason.nvim",
--         "williamboman/mason-lspconfig.nvim",
--         "hrsh7th/cmp-nvim-lsp",
--         "hrsh7th/cmp-buffer",
--         "hrsh7th/cmp-path",
--         "hrsh7th/cmp-cmdline",
--         "hrsh7th/nvim-cmp",
--         "L3MON4D3/LuaSnip",
--         "saadparwaiz1/cmp_luasnip",
--         "j-hui/fidget.nvim",
--     },
--
--     config = function()
--         local cmp = require('cmp')
--         local cmp_lsp = require("cmp_nvim_lsp")
--         local capabilities = vim.tbl_deep_extend(
--             "force",
--             {},
--             vim.lsp.protocol.make_client_capabilities(),
--             cmp_lsp.default_capabilities())
--
--         require("fidget").setup({})
--         require("mason").setup()
--         require("mason-lspconfig").setup({
--             ensure_installed = {
--                 "lua_ls",
--                 "rust_analyzer",
--                 "tsserver",
--             },
--             handlers = {
--                 function(server_name) -- default handler (optional)
--
--                     require("lspconfig")[server_name].setup {
--                         capabilities = capabilities
--                     }
--                 end,
--
--                 ["lua_ls"] = function()
--                     local lspconfig = require("lspconfig")
--                     lspconfig.lua_ls.setup {
--                         capabilities = capabilities,
--                         settings = {
--                             Lua = {
--                                 diagnostics = {
--                                     globals = { "vim", "it", "describe", "before_each", "after_each" },
--                                 }
--                             }
--                         }
--                     }
--                 end,
--             }
--         })
--
--         local cmp_select = { behavior = cmp.SelectBehavior.Select }
--
--         cmp.setup({
--             snippet = {
--                 expand = function(args)
--                     require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
--                 end,
--             },
--             mapping = cmp.mapping.preset.insert({
--                 ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
--                 ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
--                 ['<C-y>'] = cmp.mapping.confirm({ select = true }),
--                 ["<C-Space>"] = cmp.mapping.complete(),
--             }),
--             sources = cmp.config.sources({
--                 { name = 'nvim_lsp' },
--                 { name = 'luasnip' }, -- For luasnip users.
--             }, {
--                 { name = 'buffer' },
--             })
--         })
--
--         vim.diagnostic.config({
--             -- update_in_insert = true,
--             float = {
--                 focusable = false,
--                 style = "minimal",
--                 border = "rounded",
--                 source = "always",
--                 header = "",
--                 prefix = "",
--             },
--         })
--     end
-- }

-- lsp zero config
local lsp_zero = require("lsp-zero")

-- "on_attach" happens on every single buffer that has a lsp that is associated with it. That means all the following keymaps only exist for the current buffer that you am on. That means keymaps only exist for the life of this buffer. Which means if you go to something that doesn't have a buffer you can still use "gd" for "jump to definition" and it will try to do vim's best jump to definition effort. But if you do have an lsp it will use the lsp instead.
lsp_zero.on_attach(function(client, bufnr)
    -- see :help lsp-zero-keybindings
    -- to learn the available actions
    local opts = { buffer = bufnr, remap = false }

    -- can't search for comments.
    vim.keymap.set("n", "gd", function()
        vim.lsp.buf.definition()
    end, opts)
    vim.keymap.set("n", "gr", function()
        vim.lsp.buf.references()
    end, opts)
    vim.keymap.set("n", "K", function()
        vim.lsp.buf.hover()
    end, opts)
    -- can search for comments.
    vim.keymap.set("n", "<leader>ws", function()
        vim.lsp.buf.workspace_symbol()
    end, opts)
    vim.keymap.set("n", "<leader>vd", function()
        vim.diagnostic.open_float()
    end, opts)
    vim.keymap.set("n", "[d", function()
        vim.diagnostic.goto_next()
    end, opts)
    vim.keymap.set("n", "]d", function()
        vim.diagnostic.goto_prev()
    end, opts)
    vim.keymap.set("n", "<leader>vca", function()
        vim.lsp.buf.code_action()
    end, opts)
    vim.keymap.set("n", "<leader>vrn", function()
        vim.lsp.buf.rename()
    end, opts)
    vim.keymap.set("i", "<C-h>", function()
        vim.lsp.buf.signature_help()
    end, opts)
    lsp_zero.default_keymaps({ buffer = bufnr })
end)

require("mason").setup({})
require("mason-lspconfig").setup({
    -- Replace the language servers listed here
    -- with the ones you want to install

    -- Use the command :LspInstall to install a language server. If you call this command while you are in a file it'll suggest a list of language servers bases on the type of that file.
    -- Or you can just use the command :Mason to pull up a list of language servers.
    ensure_installed = { "tsserver", "rust_analyzer", "eslint", "lua_ls", "cssls", "intelephense" },
    handlers = {
        lsp_zero.default_setup,
        function(server_name)
            require("lspconfig")[server_name].setup({})
        end,
        lua_ls = function()
            local lua_opts = lsp_zero.nvim_lua_ls()
            require("lspconfig").lua_ls.setup(lua_opts)
        end,
    },
})

-- Lsp Completions
local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }

-- this is the function that loads the extra snippets to luasnip
-- from rafamadriz/friendly-snippets
require("luasnip.loaders.from_vscode").lazy_load()

-- Completion Keybindings
cmp.setup({
    sources = {
        { name = "path" },
        { name = "luasnip" },
        { name = "nvim_lsp", keyword_length = 2 },
        { name = "nvim_lua", keyword_length = 2 },
        { name = "buffer", keyword_length = 3 },
    },
    formatting = lsp_zero.cmp_format({ details = false }),
    mapping = cmp.mapping.preset.insert({
        -- Previouse completions
        ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
        -- Next completions
        ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
        -- Accept completion
        ["<Enter>"] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
    }),
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
})

-- `/` cmdline setup.
cmp.setup.cmdline("/", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = "buffer" },
    },
})

cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = "path" },
    }, {
        { name = "cmdline" },
    }),
    matching = { disallow_symbol_nonprefix_matching = false },
})
