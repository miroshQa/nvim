return {
  "luisiacc/gruvbox-baby",
  priority = 1000,
  config = function()
    vim.g.gruvbox_baby_use_original_palette = true
    vim.g.gruvbox_baby_color_overrides = {}

    -- See help IncSearch / CurSearch

    vim.g.gruvbox_baby_highlights = {
      IncSearch = { bg = "#ff9e64", fg = "White" },
      CurSearch = { link = "IncSearch" },
      FlashLabel = { bg = "#0076CE" },
    }
    vim.cmd.colorscheme("gruvbox-baby")
  end,
}
