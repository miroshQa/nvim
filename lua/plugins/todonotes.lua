return {
  "folke/todo-comments.nvim",
	event = {"BufReadPost", "BufNewFile"},
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    {"<leader>n", "<cmd>TodoTelescope<CR>", "n", desc = "Telescope code notes"},
  },
  opts = {}
}
