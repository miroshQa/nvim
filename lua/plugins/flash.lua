vim.keymap.set({"x", "o", "n"}, "s", function() require('flash').jump() end, {desc = "Flash"})
vim.keymap.set({"x", "o", "n"}, "<C-s>", function() require('flash').treesitter() end, {desc = "Flash treesitter"})
vim.keymap.set("o", "r", function() require('flash').remote() end, {desc = "Flash remote yank / delete"})
-- use cl instead in Normal mode. Use c instead s in Visual mode

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
      uppercase = true,
    },
    jump = {
      inclusive = false,
    }
  },
}
