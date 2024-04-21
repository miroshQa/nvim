vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- vim.opt.autowriteall = true
-- vim.opt.autochdir = true
vim.opt.swapfile = false
-- vim.opt.autochdir = true

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.backspace = "indent,eol,start"

vim.opt.wrap = false

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

vim.opt.clipboard = 'unnamedplus'

vim.opt.breakindent = true

vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = 'yes'

vim.opt.updatetime = 250

vim.opt.timeoutlen = 500

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

vim.opt.cursorline = true

vim.opt.scrolloff = 10

vim.opt.hlsearch = true

vim.opt.autoread = true
-- vim.opt.autochdir = true Выключил после того как установил project telescope

-- turn off auto commenting next line
vim.opt_local.formatoptions:remove("cro")

vim.cmd([[autocmd FileType * set formatoptions-=ro]])