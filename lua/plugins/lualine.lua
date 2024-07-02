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
      },
      sections = {
      lualine_a = {"mode", },
        lualine_c = {
          {"filename", path = 1},
        },
        lualine_x = {{"tabs", mode = 1, cond = function() return #vim.fn.gettabinfo() > 1 end}},
        lualine_y = {"filetype"},
        lualine_z = {"progress","location" },
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
