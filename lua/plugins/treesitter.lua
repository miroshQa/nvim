return {
  {
  "nvim-treesitter/nvim-treesitter",
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require("nvim-treesitter.configs").setup({
    auto_install = true,
      highlight = {
        enable = true,
      }
    }
    )
  end,
  },
  -- Automatically add closing tags for HTML and JSX
  {
    "windwp/nvim-ts-autotag",
    ft = {"js", "html"},
    opts = {},
  },
}
