vim.keymap.set("n", "<leader>n", "<cmd>TodoTelescope<CR>", {desc = "Find code Notes (todo comments)"})

return {
  "folke/todo-comments.nvim",
  cmd = "TodoTelescope",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
  }
}
