vim.keymap.set('n', '<left>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<right>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<down>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<up>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set("n", "<leader>Q", ":quitall!<CR>", {desc = "Force quit all (Be careful!)"})

vim.keymap.set('v', '<', '<gv', { noremap = true })
vim.keymap.set('v', '>', '>gv', { noremap = true })
vim.keymap.set("n", "g.", "<cmd>b#<CR>", {desc = "Go to previous buffer (. - most recent)"})
vim.keymap.set("n", "<tab>", "gt")
vim.keymap.set("n", "<S-tab>", "gT")

vim.keymap.set("i", "<esc>", "<esc><cmd>write<CR>", {silent = true, noremap = true}) -- Autowrite

-- For convinience when use snippets
vim.keymap.del("s", "<")
vim.keymap.del("s", ">")

vim.keymap.set("i", "<up>", "")
vim.keymap.set("i", "<down>", "")

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
