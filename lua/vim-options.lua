vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.swapfile = false

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2 -- Установка количества пробельных символов при сдвиге с "<", ">"
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.backspace = "indent,eol,start"
vim.opt.smartindent = true -- Подстравивать новые строки под предыдущий отступ

vim.opt.wrap = false
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.mouse = "a"

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

vim.opt.clipboard = "unnamedplus"

vim.opt.breakindent = true

vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = "yes"

vim.opt.updatetime = 250

vim.opt.timeoutlen = 500

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.inccommand = "split" -- Preview substitutions live, as you type!

vim.opt.cursorline = true

vim.opt.scrolloff = 10

vim.opt.hlsearch = true

vim.opt.autoread = true
vim.opt_local.formatoptions:remove("cro")

vim.opt.termguicolors = true

vim.opt.wrap = true
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")

-- Fix kitty Enter key
vim.api.nvim_set_keymap("n", "<kEnter>", "<Enter>", {})
vim.api.nvim_set_keymap("i", "<kEnter>", "<Enter>", {})
vim.api.nvim_set_keymap("c", "<kEnter>", "<Enter>", {})

if vim.g.neovide then
	local map = vim.keymap
	map.set({ "n", "v" }, "<C-+>", "<cmd>lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>")
	map.set({ "n", "v" }, "<C-->", "<cmd>lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<CR>")
	map.set({ "n", "v" }, "<C-0>", "<cmd>lua vim.g.neovide_scale_factor = 1<CR>")
end
