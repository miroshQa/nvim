local user_functions = require("user_functions")

-- Windows / Tabs Navigation
vim.keymap.set('n', '<left>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<right>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<down>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<up>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
vim.keymap.set("n", "[t", "<cmd>tabp<CR>", {desc = "Go to prev tab"})
vim.keymap.set("n", "]t", "<cmd>tabn<CR>", {desc = "Go to next tab"})
-- vim.keymap.set("n", "<tab>", "<cmd>tabn<CR>") these mappings break Ctrl + i (because tab has the same key code as Ctrl+ i) :help tui-input
-- vim.keymap.set("n", "<S-tab>", "<cmd>tabp<CR>")
vim.keymap.set("n", "<leader>Q", "<cmd>quitall!<CR>", {desc = "Force quit all (Be careful!)"})
vim.keymap.set("n", "<leader>q", "<cmd>quit<CR>", {desc = "Close current buffer"})

-- Improved motions
vim.keymap.set("v", "J", ":m '>+1<CR>gv==kgvo<esc>=kgvo", { desc = "move highlighted text down", silent = true }) -- Use gs / gS in Normal mode instead (And can even much more!)
vim.keymap.set("v", "K", ":m '<-2<CR>gv==jgvo<esc>=jgvo", { desc = "move highlighted text up", silent = true })
vim.keymap.set({"n", "x", "o"}, 'gh', '^')
vim.keymap.set({"n", "x", "o"}, 'gl', '$')
vim.keymap.set('v', '<', '<gv', { noremap = true })
vim.keymap.set('v', '>', '>gv', { noremap = true })
vim.keymap.set("n", "ga", "<cmd>b#<CR>", {desc = "Go to last Accessed file (Ctrl + ^ synonim)"})
vim.keymap.set("n", "+", "ggVG=<C-o>", {desc = "Autoindent all text in buffer"})
vim.keymap.set("x", "R", ":s##<left>", {desc = "Start replacement in selected range"})

-- Quickfix list
vim.keymap.set("n", "<C-p>", "<cmd>cprev<CR>", {desc = "Go to prev quickfixlist entry"})
vim.keymap.set("n", "<C-n>", "<cmd>cnext<CR>", {desc = "Go to next quickfixlist entry"})

vim.keymap.set("n", "<leader>uh", "<cmd>checkhealth<CR>", {desc = "Run editor checkhealth"})
vim.keymap.set("i", "<esc>", "<esc><cmd>write<CR>", {silent = true, noremap = true, desc = "Autowrite"})

-- Smart delete lines; don't clutter clipboard with whitespace lines
vim.keymap.set("n", "dd", user_functions.smart_line_delete, { expr = true, silent = true })
vim.keymap.set("i", "<up>", "")
vim.keymap.set("i", "<down>", "")
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.del("s", "<")
vim.keymap.del("s", ">")

-- Fix kitty Enter key
vim.keymap.set({"n", "i", "c"}, "<kEnter>", "<Enter>", {})
vim.keymap.set( 'n', '<Leader>ud', user_functions.toggle_diagnostic, {silent=true, noremap=true, desc = "Toggle diagnostic"})

vim.keymap.set("v", "<C-r>", function() user_functions.changeSelected(false) end) -- Replace selected
vim.keymap.set("v", "<C-right>", function() user_functions.changeSelected(true) end) -- Edit selected (C-right equal to C-e because of my keymaps in the OS)
-- very convinient to combine with Ctrl + f and Ctrl + c to return after

