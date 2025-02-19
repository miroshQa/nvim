return {
  "NeogitOrg/neogit",
  cmd = "Neogit",
  keys = {
    {"<leader>v", "<cmd>Neogit<CR>", mode = "n", desc = "Open vsc (git)"}
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = true
}
