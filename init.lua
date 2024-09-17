-- Importing the contents of the "~/.config/nvim/lua/kurama" directory technically nvim's point of view "~/lua/kurama"
require("kurama")

-- Load setting like "set number" in .vimrc from settings.lua
require("kurama.settings")

-- Importing the "~/.config/nvim/lua/kurama/remap.lua" file or technically from nvim's point of view "~/lua/kurama/kurama.remap"
require("kurama.remap")

--vim.cmd("so ~/.config/nvim/lua/kurama/remap.lua")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

-- Install plugin
local plugins = {
    -- Color Scheme Plugin
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    -- { "rose-pine/neovim", name = "rose-pine" },
    {
        "goolord/alpha-nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },
    {
        "numToStr/Comment.nvim",
        opts = {

            -- add any options here
        },
        lazy = false,
    },
    -- { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
    { "akinsho/bufferline.nvim", version = "*", dependencies = "nvim-tree/nvim-web-devicons" },
    { "tpope/vim-surround" },
    { "ellisonleao/glow.nvim", config = true, cmd = "Glow" },
    { "junegunn/fzf.vim", dependencies = { "junegunn/fzf" } },
    -- { "junegunn/fzf", build = "./install --all" },
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.6", -- or                              , branch = '0.1.x',

        dependencies = { "nvim-lua/plenary.nvim" },
    },
    {
        "christoomey/vim-tmux-navigator",
        cmd = {
            "TmuxNavigateLeft",
            "TmuxNavigateDown",
            "TmuxNavigateUp",
            "TmuxNavigateRight",
            "TmuxNavigatePrevious",
        },
        keys = {
            { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
            { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
            { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
            { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
            { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
        },
    },

    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    { "nvim-treesitter/playground" },
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
    },

    { "mbbill/undotree" },

    { "VonHeikemen/lsp-zero.nvim", branch = "v3.x" },
    {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
        "WhoIsSethDAniel/mason-tool-installer.nvim",
    },
    {
        "hrsh7th/nvim-cmp",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lua",
        "L3MON4D3/LuaSnip",
        "rafamadriz/friendly-snippets",
        -- Not sure if still necessary
        "j-hui/fidget.nvim",
        "hrsh7th/cmp-cmdline",
    },
    {
        "stevearc/conform.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {},
    },
    {
        "mfussenegger/nvim-lint",
        event = { "BufReadPre", "BufNewFile" },
    },
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
    },
}

local opts = {}

-- Access Lazy Vim UI with the following command ":Lazy"
require("lazy").setup(plugins, opts)

require("Comment").setup()
require("kurama.plugins.alpha")
require("kurama.plugins.nvim-tree")
-- Load the settings for the following plugins that you configured in other files.
require("kurama.plugins.treesitter")
-- Importing from ~/.config/nvim/lua/kurama/plugins/telescope.lua
-- Keybindings for telescope plugin are located at ~/.config/nvim/lua/kurama/plugins/telescope.lua
require("kurama.plugins.telescope")
require("kurama.plugins.fzf")
require("kurama.plugins.harpoon")
require("kurama.plugins.colors")
require("kurama.plugins.lsp")
require("kurama.plugins.luasnip")
require("kurama.plugins.formatting")
-- Activate with ":Mason" command.
require("kurama.plugins.mason")
require("kurama.plugins.linting")
-- require("kurama.plugins.indent-blackline")
require("kurama.plugins.bufferline")
