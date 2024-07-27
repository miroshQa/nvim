vim.keymap.set("n", "<leader>gg", "<cmd>Neogit<CR>", {desc = "Open Neogit Status"})
vim.keymap.set("n", "<leader>gc", "<cmd>Neogit commit<CR>", {desc = "Open Commit Menu"})

return {
  "NeogitOrg/neogit",
  cmd = "Neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",         -- required
    "sindrets/diffview.nvim",        -- optional - Diff integration
    "nvim-telescope/telescope.nvim",
  },
  config = true
}
