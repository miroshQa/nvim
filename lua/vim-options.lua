-- Leader 
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Better UX
vim.opt.autowriteall = true
vim.opt.autoread = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.clipboard = "unnamedplus"
vim.opt.mouse = "a"
vim.opt.scrolloff = 20

-- Indents settings
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.backspace = "indent,eol,start"
vim.opt.smartindent = true

-- UI
vim.opt.showcmd = false
vim.opt.wrap = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.showtabline = 0
vim.opt.cursorline = true
vim.opt.showmode = false
vim.opt.signcolumn = "yes"
vim.opt.breakindent = true
vim.g.termguicolors = true
vim.opt.updatetime = 250

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true

-- https://www.jackfranklin.co.uk/blog/code-folding-in-vim-neovim/
-- I couldn't open files greater than 5mb, after I comment this lines below I solve this problem. So, don't use treesitter for folds, it is garbage
-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
-- vim.opt.foldnestmax = 2
-- vim.opt.foldtext = ""
-- vim.opt.foldlevelstart = 99
