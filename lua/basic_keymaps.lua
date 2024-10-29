local better_search_and_replace = require("personal.search_and_replace")

-- Windows / Tabs Navigation
vim.keymap.set('n', '<left>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<right>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<down>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<up>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
vim.keymap.set("n", "[t", "<cmd>tabp<CR>", {desc = "Go to prev tab"})
vim.keymap.set("n", "]t", "<cmd>tabn<CR>", {desc = "Go to next tab"})

vim.keymap.set("n", "<leader>w", function() vim.cmd("silent! w") end)
vim.keymap.set("n", "ga", "<cmd>b#<CR>", {desc = "Go to last Accessed file (Ctrl + ^ synonim)"})
vim.keymap.set("n", "+", "ggVG=<C-o>", {desc = "Autoindent all text in buffer"})
vim.keymap.set("x", "R", ":s##<left>", {desc = "Start replacement in selected range"})
vim.keymap.set("c", "<down>", "<C-n>")
vim.keymap.set("c", "<up>", "<C-p>")
vim.keymap.set("n", "dd", better_search_and_replace.smart_line_delete, { expr = true, silent = true })
vim.keymap.set("n", "<C-p>", "<cmd>cprev<CR>", {desc = "Go to prev quickfixlist entry"})
vim.keymap.set("n", "<C-n>", "<cmd>cnext<CR>", {desc = "Go to next quickfixlist entry"})
vim.keymap.set("n", "zo", "za", {desc = "Toggle fold"})
vim.keymap.set("n", "zO", "zA", {desc = "Toggle all folds under cursor"})
vim.keymap.set("n", "zm", "zM", {desc = "Close all folds"})
vim.keymap.set("n", "zr", "zR", {desc = "Open all folds"})
vim.keymap.set("n", "p", "p=`]") -- https://vim.fandom.com/wiki/Format_pasted_text_automatically

-- Improved motions (Visual mode)
vim.keymap.set("v", "<C-r>", function() better_search_and_replace.changeSelected(false) end, {desc = "Replace selected in whole buffer"})
vim.keymap.set("v", "<C-right>", function() better_search_and_replace.changeSelected(true) end, {desc = "Edit selected in whole buffer (Use Ctrl + f to edit prompt and Ctrl + c to return)"})
vim.keymap.set('v', '<', '<gv', { noremap = true })
vim.keymap.set('v', '>', '>gv', { noremap = true })

-- UI
vim.keymap.set( 'n', '<Leader>ud', better_search_and_replace.toggle_diagnostic, {silent=true, noremap=true, desc = "Toggle LSP diagnostic"})
