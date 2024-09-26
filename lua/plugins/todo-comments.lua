vim.keymap.set("n", "<leader>n", "<cmd>TodoTelescope<CR>", {desc = "Find code Notes (todo comments)"})

return {
  "folke/todo-comments.nvim",
  event = {"BufReadPost", "BufNewFile"},
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
  }
}
