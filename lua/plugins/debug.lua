return {
  {
    "mfussenegger/nvim-dap",
    version = "*",
    config = function()

      vim.keymap.set("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", {desc = "Toggle breakpiont"})
      vim.keymap.set("n", "<leader>dB", ":lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", {desc = "Set conditional breakpoint"})
      vim.keymap.set("n", '<leader>dx', "<cmd>lua require'dap'.clear_breakpoints()<cr>")
      vim.keymap.set("n", '<leader>da', '<cmd>Telescope dap list_breakpoints<cr>')
      vim.keymap.set("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>")
      vim.keymap.set("n", "<leader>d*", function() require("dap").run_to_cursor() end, {desc = "Run to Cursor" })
      vim.keymap.set("n", "<leader>dg", function() require("dap").goto_() end, {desc = "Go to Line (No Execute)" })
      vim.keymap.set("n", "<leader>dj", "<cmd>lua require'dap'.step_over()<cr>")
      vim.keymap.set("n", "<leader>dk", "<cmd>lua require'dap'.step_into()<cr>")
      vim.keymap.set("n", "<leader>do", "<cmd>lua require'dap'.step_out()<cr>")
      vim.keymap.set("n", '<leader>dd', function() require('dap').disconnect(); require('dapui').close(); end, {desc = "Disconnect"})
      vim.keymap.set("n", '<leader>dt', function() require('dap').terminate(); require('dapui').close(); end, {desc = "Terminate"})
      vim.keymap.set("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>")
      vim.keymap.set("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>")
      vim.keymap.set("n", '<leader>di', require("dapui").float_element, {desc = "Hover variable info"})
      vim.keymap.set("n", '<leader>d?', function() local widgets = require "dap.ui.widgets"; widgets.centered_float(widgets.scopes) end)
      vim.keymap.set("n", '<leader>df', '<cmd>Telescope dap frames<cr>')
      vim.keymap.set("n", '<leader>dh', '<cmd>Telescope dap commands<cr>')



      local dap = require("dap")
      dap.set_log_level('TRACE')

      dap.adapters.gdb = {
        type = "executable",
        id = "gdb",
        command = "gdb",
        args = {"--silent", "--interpreter=dap"},
      }

      dap.configurations.cpp = {
        {
          type = "gdb",
          request = "launch",
          name = "Launch",
          program = function()
            --return "mWeather"
            -- Оказывается на винде нужен путь формата a//b//b//... Часа три дебажил
            local cwd_path = string.gsub(vim.fn.getcwd(), "\\", "//")
            local path = vim.fn.input("Path to executable: ", cwd_path .. "//", "file")
            return path
          end,
          cwd = "${workspaceFolder}",
          stopAtBeginningOfMainSubprogram = true,
        },
      }

      dap.configurations.c = dap.configurations.cpp
    end,
  },

  {
    "rcarriga/nvim-dap-ui",
    dependencies = {"nvim-neotest/nvim-nio"},

    keys = {
      { "<Leader>du", function() require("dapui").toggle({}) end, desc = "DAP: Toggle DAP GUI" },
    },
    config = function(_, opts)
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup(opts)
      dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
    end,
    opts = {...},
  }
}
