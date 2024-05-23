local plugins = {
  {
    "rcarriga/nvim-dap-ui",
      keys = {
        { "<leader>du", function() require("dapui").toggle({ }) end, desc = "Dap UI" },
        { "<leader>de", function() require("dapui").eval(nil, {enter = true}) end, desc = "Eval", mode = {"n", "v"} },
      },
    event = "VeryLazy",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end


    end,
  },
    -- virtual text for the debugger
    {
      "theHamsta/nvim-dap-virtual-text",
      opts = {},
    },
  {
    "jay-babu/mason-nvim-dap.nvim",
    event = "VeryLazy",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
    },
    opts = {
      handlers = {},
    },
  },
  {
    "mfussenegger/nvim-dap",
    config = function(_, _)
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
    end,
  },
}
return plugins
