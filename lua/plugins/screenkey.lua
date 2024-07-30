vim.keymap.set("n", "<leader>uk", "<cmd>Screenkey toggle<CR>", {desc = "Toggle screenkey"})

return {
  "NStefan002/screenkey.nvim",
  version = "*",
  cmd = "Screenkey",
  opts = {
    win_opts = {
      title = "KeysTracking",
      border = "rounded",
    }
  }
}
