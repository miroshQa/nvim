vim.keymap.set({"x", "o", "n"}, "s", function() require('flash').jump() end, {desc = "Flash"})
vim.keymap.set({"x", "o", "n"}, "<C-s>", "<cmd>lua require('flash').treesitter()<CR>", {desc = "Flash treesitter"})
vim.keymap.set("o", "r", "<cmd>lua require('flash').remote()<CR>", {desc = "Flash remote yank / delete"})
-- use xi / cl instead in Normal mode. Use c or S instead s in Visual mode

return {
  "folke/flash.nvim",
  lazy = true,
  vscode = true,
  ---@type Flash.Config
  opts = {
    modes = {
      char = {
        enabled = false,
      },
    },
    label = {
      uppercase = false,
    },
    jump = {
      inclusive = false,
    }
  },
}
