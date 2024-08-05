return {
  "nvim-treesitter/nvim-treesitter",
  event = {"BufReadPost", "BufNewFile"},
  build = ":TSUpdate",
  dependencies = {
    {"nvim-treesitter/nvim-treesitter-textobjects"},
  },
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require("nvim-treesitter.configs").setup({
      auto_install = true,
      ensure_installed = {
        "lua",
        "vim",
        "vimdoc",
        "markdown",
        "html",
      },
      highlight = {
        enable = true,
      },
      indent = { enable = true},
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<Enter>",
          node_incremental = "<Enter>",
          node_decremental = "<BS>",
        },
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
            ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
          },
          include_surrounding_whitespace = false,
        },
        swap = {
          enable = true,
          swap_next = { ["}"] = "@parameter.inner", },
          swap_previous = { ["{"] = "@parameter.inner", },
        },
      },
    }
    )
  end,

}
