return {
  "kylechui/nvim-surround",
  version = "*", -- Use for stability; omit to use `main` branch for the latest features
  event = {"BufReadPost", "BufNewFile"},
  config = function()
    require("nvim-surround").setup({
      keymaps = {
        insert = false,
        insert_line = false,
        normal = "yz",
        normal_cur = "yzz",
        normal_line = "yZ",
        normal_cur_line = "yZZ",
        visual = "z",
        visual_line = "z",
        delete = "dz",
        change = "cz",
        change_line = "cZ",
      },
    })
  end
}
