return {
  "aznhe21/actions-preview.nvim",
  keys = {
    {"go", function() require("actions-preview").code_actions() end, mode = { "v", "n" }, desc = "Open actions-preview"}
  },
  opts = {
  },
}
