vim.keymap.set("n", "<leader>v", "<cmd>Neogit<CR>", {desc = "Open vsc (git)"})

return {
  "NeogitOrg/neogit",
  cmd = "Neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",
    "nvim-telescope/telescope.nvim",
  },
  config = true
}
