vim.keymap.set("n", "}", "<cmd>TSTextobjectSwapNext @parameter.inner<CR>", {desc = "Swap next text object"})
vim.keymap.set("n", "{", "<cmd>TSTextobjectSwapPrev @parameter.inner<CR>", {desc = "Swap prev text object"})

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
        "cpp",
        "python",
        "json",
        "bash",
        "c",
        "html",
        "lua",
        "markdown",
        "vim",
        "vimdoc",
        "go",
        "c_sharp",
        "javascript",
        "typescript",
        "yaml",
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
          selection_modes = {
            ['@parameter.outer'] = 'v', -- charwise
            ['@function.outer'] = 'V', -- linewise
            ['@class.outer'] = '<c-v>', -- blockwise
          },
          include_surrounding_whitespace = false,
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ["L"] = "@parameter.inner",
        },
        swap_previous = {
          ["H"] = "@parameter.inner",
        },
      },
    }
    )
  end,

}
