return {
    "mfussenegger/nvim-dap",
    version = "*",
    dependencies = {
      "theHamsta/nvim-dap-virtual-text",
     "nvim-neotest/nvim-nio",
      "rcarriga/nvim-dap-ui",
      "nvimtools/hydra.nvim",
    },
    config = function()
      require("nvim-dap-virtual-text").setup({})
      local dap = require("dap")
      local dapui = require("dapui")

      -- Run last: https://github.com/mfussenegger/nvim-dap/issues/1025
      local last_config = nil
      ---@param session Session
      dap.listeners.after.event_initialized["store_config"] = function(session)
        last_config = session.config
      end

      local function debug_run_last()
        if last_config then
          dap.run(last_config)
        else
          dap.continue()
        end
      end

    local Hydra = require('hydra')

      dap_hydra = Hydra({
         name = "DEBUG",
         config = {
            color = 'pink',
            invoke_on_body = true,
         },

         mode = 'n',
         body = '<Leader>d',
         heads = {
            { "u", function() require("dapui").toggle() end, { desc = "Toggles Dap UI", exit = false, private = true, silent = true } },
            { "b", function() require("dap").toggle_breakpoint() end, { desc = "Set breakpoint", exit = false, private = true, silent = true } },
            { "B", function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, { desc = "Set conditional breakpoint", exit = false, private = true, silent = true } },
            { "c", function() require("dap").continue() end, { desc = "Continue from breakpoint", exit = false, private = true, silent = true } },
            { "O", function() require("dap").step_out() end, { desc = "Step Out", exit = false, private = true, silent = true } },
            { "o", function() require("dap").step_over() end, { desc = "Step over", exit = false, private = true, silent = true } },
            { "i", function() require("dap").step_into() end, { desc = "Step into", exit = false, private = true, silent = true } },
            { '<Esc>', nil, { exit = true, nowait = true } },
            { "L", function() require("dap").debug_run_last() end, { desc = "Run last configuration", exit = false, private = true, silent = true } },
            { "X", function() require("dap").clear_breakpoints() end, { desc = "Clear all breakpoints", exit = false, private = true, silent = true } },
            { "A", '<cmd>Telescope dap list_breakpoints<cr>', { desc = "All breakpoints", exit = false, private = true, silent = true } },
            { "*", function() require("dap").run_to_cursor() end, { desc = "All breakpoints", exit = false, private = true, silent = true } },
            { "T", function() require("dap").terminate() end, { desc = "Terminate", exit = false, private = true, silent = true } },
            { "r", function() require("dap").repl.toggle() end, { desc = "Repl toggle", exit = false, private = true, silent = true } },
            { "s", function() require("dap").repl.toggle() end, { desc = "Stack frames", exit = false, private = true, silent = true } },
            { "w", function() require("dap.ui.widgets").centered_float(require("dap.ui.widgets").scopes, winopts) end, { desc = "View current scope", exit = false, private = true, silent = true } },
            { "g?", function() require("hydra").hint.show() end, { desc = "Stack frames", exit = false, private = true, silent = true } },
         }
      })
require('dap').set_log_level('TRACE') dap.adapters.gdb = {
        type = "executable",
        id = "gdb",
        command = "gdb",
        args = {"--interpreter=dap"},
      }

      dap.configurations.cpp = {
        {
          type = "gdb",
          request = "launch",
          name = "Launch gdb",
          program = function()
            --return "mWeather"
            -- Оказывается на винде нужен путь формата a//b//b//... Часа три дебажил
            local cwd_path = string.gsub(vim.fn.getcwd(), "\\", "//")
            local path = vim.fn.input("Path to executable: ", cwd_path .. "//", "file")
            return path
          end,
          cwd = "${workspaceFolder}",
          stopAtBeginningOfMainSubprogram = false,
        },
      }
      dap.configurations.c = dap.configurations.cpp

      dap.adapters.coreclr = {
        type = 'executable',
        command = 'C:/netcoredbg/netcoredbg',
        args = {'--interpreter=vscode'},
        console = "integratedTerminal",
      }

      dap.configurations.cs = {
        {
          type = "coreclr",
          name = "launch - netcoredbg",
        console = "integratedTerminal",
          request = "launch",
          program = function()
              return vim.fn.input('Path to dll: ', vim.fn.getcwd() .. '/bin/Debug/net8.0/', 'file')
          end,
        },
      }

      vim.api.nvim_command 'autocmd FileType dap-float nnoremap <buffer><silent> q <cmd>close!<CR>'
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
}
