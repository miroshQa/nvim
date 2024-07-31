vim.keymap.set({ "v", "n" }, "go", function() require("actions-preview").code_actions() end, {desc = "Open actions-preview"})

return {
  "aznhe21/actions-preview.nvim",
  lazy = true,
  opts = {
  },
}
