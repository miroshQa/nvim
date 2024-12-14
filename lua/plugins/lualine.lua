local lsp_server_component = {
  -- Lsp server name .
  function()
    local msg = ''
    local buf_ft = vim.api.nvim_get_option_value("filetype", {buf = 0})
    local clients = vim.lsp.get_clients()
    if next(clients) == nil then
      return msg
    end
    for _, client in ipairs(clients) do
      local filetypes = client.config.filetypes
      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
        return client.name
      end
    end
    return msg
  end,
  icon = ' LSP:',
}

local macro = function()
  local reg = vim.fn.reg_recording()
  if reg == "" then return "" end -- not recording
  return "recording macro to " .. reg
end


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
          {"diagnostics"},
          macro,
        },
        lualine_x = {
          lsp_server_component,
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
