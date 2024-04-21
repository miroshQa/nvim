
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>le', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })


local api = vim.api
api.nvim_command 'autocmd TermOpen * startinsert' -- starts in insert mode
api.nvim_command 'autocmd TermOpen * setlocal nonumber' -- no numbers
api.nvim_command 'autocmd TermEnter * setlocal signcolumn=no' -- no sign column

vim.keymap.set('n', '<left>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<right>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<down>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<up>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

--ignore arrow keys. Be in normal mode man!
vim.keymap.set('i', '<left>', '')
vim.keymap.set('i', '<right>', "")
vim.keymap.set('i', '<down>', "")
vim.keymap.set('i', '<up>', "")

-- window management
vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
vim.keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
vim.keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

vim.keymap.set('v', '<', '<gv', { noremap = true })
vim.keymap.set('v', '>', '>gv', { noremap = true })

-- easy tabs
--vim.keymap.set("n", "<tab>", "<cmd>tabn<CR>", {desc = "Go to next tab"})
--vim.keymap.set("n", "<S-tab>", "<cmd>tabn<CR>", {desc = "Go to prev tab"})
