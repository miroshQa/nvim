
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('n', '<left>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<right>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<down>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<up>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('v', '<', '<gv', { noremap = true })
vim.keymap.set('v', '>', '>gv', { noremap = true })
vim.keymap.set("n", "g.", "<cmd>b#<CR>", {desc = "Go to previous buffer (. - most recent)"})
vim.keymap.set("n", "<tab>", "gt")
vim.keymap.set("n", "<S-tab>", "gT")

vim.keymap.set("n", "<M-l>", "<c-w>5<")
vim.keymap.set("n", "<M-h>", "<c-w>5>")
vim.keymap.set("n", "<M-k>", "<c-w>5+>")
vim.keymap.set("n", "<M-j>", "<c-w>5->")


local diagnostics_active = true
Toggle_diagnostics = function()
  diagnostics_active = not diagnostics_active
  if diagnostics_active then
    vim.api.nvim_echo({ { "Show diagnostics" } }, false, {})
    vim.diagnostic.enable()
  else
    vim.api.nvim_echo({ { "Disable diagnostics" } }, false, {})
    vim.diagnostic.enable(false)
  end
end

vim.api.nvim_set_keymap(
    'n',
    '<Leader>ud',
    '<Cmd>lua Toggle_diagnostics()<CR>',
    {silent=true, noremap=true}
)
