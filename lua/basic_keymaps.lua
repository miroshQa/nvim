
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>le', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- easy tabs
vim.keymap.set('n', '<leader>1', '<cmd>tabn 1<CR>')
vim.keymap.set('n', '<leader>2', '<cmd>tabn 2<CR>')
vim.keymap.set('n', '<leader>3', '<cmd>tabn 3<CR>')
vim.keymap.set('n', '<leader>4', '<cmd>tabn 4<CR>')
vim.keymap.set('n', '<leader>5', '<cmd>tabn 5<CR>')
vim.keymap.set('n', '<leader>6', '<cmd>tabn 6<CR>')
vim.keymap.set('n', '<leader>7', '<cmd>tabn 7<CR>')
vim.keymap.set('n', '<leader>8', '<cmd>tabn 8<CR>')
vim.keymap.set('n', '<leader>9', '<cmd>tabn 9<CR>')
vim.keymap.set('n', '<S-l>', '<cmd>tabnext<CR>')
vim.keymap.set('n', '<S-h>', '<cmd>tabprev<CR>')

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
vim.keymap.set('n', '<leader>t', '<cmd>terminal<CR>')

local api = vim.api
api.nvim_command 'autocmd TermOpen * startinsert' -- starts in insert mode
api.nvim_command 'autocmd TermOpen * setlocal nonumber' -- no numbers
api.nvim_command 'autocmd TermEnter * setlocal signcolumn=no' -- no sign column

vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')
vim.keymap.set('n', '<Up>', ':wincmd k<CR>')
vim.keymap.set('n', '<Down>', ':wincmd j<CR>')
vim.keymap.set('n', '<Left>', ':wincmd h<CR>')
vim.keymap.set('n', '<Right>', ':wincmd l<CR>')

vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>')
vim.keymap.set('v', '<', '<gv', { noremap = true })
vim.keymap.set('v', '>', '>gv', { noremap = true })
