local user_functions = require("user_functions")

-- Windows / Tabs Navigation
vim.keymap.set('n', '<left>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<right>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<down>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<up>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
vim.keymap.set("n", "[t", "<cmd>tabp<CR>", {desc = "Go to prev tab"})
vim.keymap.set("n", "]t", "<cmd>tabn<CR>", {desc = "Go to next tab"})
vim.keymap.set("n", "<leader>Q", "<cmd>quitall!<CR>", {desc = "Force quit all (Be careful!)"})

vim.keymap.set("i", "<up>", "")
vim.keymap.set("i", "<down>", "")
vim.keymap.set("i", "<left>", "")
vim.keymap.set("i", "<right>", "")


-- Improved motions (Normal mode)
vim.keymap.set({"n", "x", "o"}, 'gh', '^')
vim.keymap.set({"n", "x", "o"}, 'gl', '$')
vim.keymap.set("n", "ga", "<cmd>b#<CR>", {desc = "Go to last Accessed file (Ctrl + ^ synonim)"})
vim.keymap.set("n", "+", "ggVG=<C-o>", {desc = "Autoindent all text in buffer"})
vim.keymap.set("x", "R", ":s##<left>", {desc = "Start replacement in selected range"})
vim.keymap.set("c", "<down>", "<C-n>")
vim.keymap.set("c", "<up>", "<C-p>")
vim.keymap.set("n", "dd", user_functions.smart_line_delete, { expr = true, silent = true })
vim.keymap.set("n", "<C-p>", "<cmd>cprev<CR>", {desc = "Go to prev quickfixlist entry"})
vim.keymap.set("n", "<C-n>", "<cmd>cnext<CR>", {desc = "Go to next quickfixlist entry"})
vim.keymap.set("n", "zo", "za", {desc = "Toggle fold"})
vim.keymap.set("n", "zO", "zA", {desc = "Toggle all folds under cursor"})
vim.keymap.set("n", "zm", "zM", {desc = "Close all folds"})
vim.keymap.set("n", "zr", "zR", {desc = "Open all folds"})

-- Improved motions (Visual mode)
vim.keymap.set("v", "J", ":m '>+1<CR>gv==kgvo<esc>=kgvo", { desc = "Move highlighted text down", silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv==jgvo<esc>=jgvo", { desc = "Move highlighted text up", silent = true })
vim.keymap.set("v", "<C-r>", function() user_functions.changeSelected(false) end, {desc = "Replace selected in whole buffer"})
vim.keymap.set("v", "<C-right>", function() user_functions.changeSelected(true) end, {desc = "Edit selected in whole buffer (Use Ctrl + f to edit prompt and Ctrl + c to return)"})
vim.keymap.set('v', '<', '<gv', { noremap = true })
vim.keymap.set('v', '>', '>gv', { noremap = true })

-- Some fixes
vim.keymap.del("s", "<", {desc = "Without this you can't use '<' char in Select mode when use snippets"})
vim.keymap.del("s", ">")
vim.keymap.set({"n", "i", "c"}, "<kEnter>", "<Enter>", {desc = "Fix for Kitty Enter key"})
-- UI
vim.keymap.set( 'n', '<Leader>ud', user_functions.toggle_diagnostic, {silent=true, noremap=true, desc = "Toggle LSP diagnostic"})
