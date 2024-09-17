-- vim.cmd("set expandtab")
vim.opt.expandtab = true
-- vim.cmd("set tabstop=4")
vim.opt.tabstop = 4
-- vim.cmd("set softtabstop=4")
vim.opt.softtabstop = 4
-- vim.cmd("set shiftwidth=4")
vim.opt.shiftwidth = 4

-- Set line numbers
-- vim.cmd("set number")
-- or
vim.opt.nu = true

-- Set relative line numbers
-- vim.opt.relativenumber = true

vim.opt.smartindent = true

-- Toggle text wrapping for lines of text.
vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

-- Connect to macOS clipboard manager.
vim.cmd("set clipboard+=unnamedplus")

-- set window title.
vim.cmd("set title")

-- Set key to open command line history while in command line mode with.
-- vim.cmd("set cedit=<C-H>")

-- Vim code folds. Source: https://www.jackfranklin.co.uk/blog/code-folding-in-vim-neovim/
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldtext = "v:lua.vim.treesitter.foldtext()"
vim.opt.foldcolumn = "0"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 1
vim.opt.foldnestmax = 7

-- Cursorline highlight.
vim.opt.cursorline = true
-- vim.cmd([[highlight CursorLine cterm=white ctermbg=black]])

vim.opt.hlsearch = true
