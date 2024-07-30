vim.keymap.set("n", "<leader>n", "<cmd>Neogit<CR>", {desc = "Open Neogit"})

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
