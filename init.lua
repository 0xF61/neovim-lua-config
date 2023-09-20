-- KEYBINDINGS
vim.g.mapleader = ' '

-- EDITOR SETTINGS
vim.opt.backup = false
vim.opt.breakindent = true
vim.opt.clipboard = 'unnamedplus'
vim.opt.colorcolumn = "80"
vim.opt.guicursor = "a:ver100-blinkon0"
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.isfname:append("@-@")
vim.opt.mouse = 'a'
vim.opt.scrolloff=8
vim.opt.shiftwidth = 2
vim.opt.signcolumn="yes"
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.tabstop = 2
vim.opt.undodir = os.getenv("HOME") .. "/.local/share/nvimundo"
vim.opt.undofile = true
vim.opt.updatetime =50
vim.opt.wrap = false

-- COLORSCHEME
vim.opt.termguicolors = true
vim.cmd.colorscheme('minimalist')

-- Disable netrw at the very start of our init.lua, because we use nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- IMPORT LUA CONFIGURATION
require("config")
