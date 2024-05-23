
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })


local api = vim.api
api.nvim_command 'autocmd TermOpen * startinsert' -- starts in insert mode
api.nvim_command 'autocmd TermOpen * setlocal nonumber' -- no numbers
api.nvim_command 'autocmd TermEnter * setlocal signcolumn=no' -- no sign column

vim.keymap.set('n', '<left>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<right>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<down>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<up>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

--ignore arrow keys. Be in normal mode man
vim.keymap.set('i', '<left>', '')
vim.keymap.set('i', '<right>', "")
vim.keymap.set('i', '<down>', "")
  vim.keymap.set('i', '<up>', "")

vim.keymap.set('v', '<', '<gv', { noremap = true })
vim.keymap.set('v', '>', '>gv', { noremap = true })
vim.keymap.set("n", "g.", "<cmd>b#<CR>", {desc = "Go to previous buffer (. - most recent)"})
vim.keymap.set("n", "<leader>1", "<cmd>tabn1<CR>")
vim.keymap.set("n", "<leader>2", "<cmd>tabn2<CR>")
vim.keymap.set("n", "<leader>3", "<cmd>tabn3<CR>")
vim.keymap.set("n", "<leader>4", "<cmd>tabn4<CR>")
vim.keymap.set("n", "<leader>5", "<cmd>tabn5<CR>")


vim.keymap.set("n", "<M-l>", "<c-w>5<")
vim.keymap.set("n", "<M-h>", "<c-w>5>")
vim.keymap.set("n", "<M-k>", "<c-w>5+>")
vim.keymap.set("n", "<M-j>", "<c-w>5->")
