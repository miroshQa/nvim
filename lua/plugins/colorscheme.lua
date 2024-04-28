return {

  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme catppuccin-frappe]])
    end,
  },

  {
    "rebelot/kanagawa.nvim",
  },

  {
    "Everblush/nvim",
    name = "everblush",
  },
  { "Mofiqul/dracula.nvim" },
}
