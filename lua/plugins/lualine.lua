return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  config = function()

    require("lualine").setup({
      options = {
        globalstatus = true, -- https://www.youtube.com/watch?v=jH5PNvJIa6o
        ignore_focus = {
          "dapui_watches",
          "dapui_breakpoints",
          "dapui_scopes",
          "dapui_console",
          "dapui_stacks",
          "dap-repl",
        },
      component_separators = {left = '', right = ''},
      section_separators = {left = '', right = ''},
      },
      sections = {
      lualine_a = {
          {"mode"},
        },
      lualine_b = {
        },
      lualine_c = {
          {"filename", path = 1},
          {"branch"},
          {"diff"},
          {"diagnostics"}
        },
        lualine_x = {
          {"filetype"},
          {
          "tabs",
          mode = 0,
          cond = function() return #vim.fn.gettabinfo() > 1 end,
          tabs_color = {
            active = {bg = "#4081f5", fg = "#FFFFFF"},
            inactive = {bg = "#f5f5f5", fg = "#4081f5"},
            },
          }
        },
        lualine_y = {
          {"progress"},
          {"location"}
        },
        lualine_z = {},
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
    })
  end,
}
