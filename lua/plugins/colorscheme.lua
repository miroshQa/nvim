return {
  "luisiacc/gruvbox-baby",
  priority = 1000,
  config = function()
    vim.g.gruvbox_baby_use_original_palette = true
    vim.g.gruvbox_baby_color_overrides = {}
    local c = require("gruvbox-baby.colors")

    vim.g.gruvbox_baby_highlights = {
      IncSearch = { bg = "#ff9e64", fg = "White" },
      CurSearch = { link = "IncSearch" },
      NeoTreeNormal = { fg = c.foreground, bg = c.background },
      NeoTreeNormalNC = { fg = c.foreground, bg = c.background },
      FloatBorder = { bg = c.background },
      NormalFloat = { fg = c.foreground, bg = c.background },
      StatusLine = { fg = c.background },
      StatusLineTerm = { fg = c.background },
      ModeMsg = { fg = c.milk }
    }
    vim.cmd.colorscheme("gruvbox-baby")
  end,
}
