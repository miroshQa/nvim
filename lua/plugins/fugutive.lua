vim.keymap.set("n", "<leader>gg", "<cmd>Git<CR>")
vim.keymap.set("n", "<leader>gc", "<cmd>:Git add % | Git commit --quiet | startinsert<CR>", {desc = "Commit changes in current buffer"})

return {
  "tpope/vim-fugitive",
  cmd = "Git",
}

