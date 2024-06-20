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

    local hint = [[
     _u_: Toggle DAP UI           _B_: Set conditional breakpoint   _c_: Continue from breakpoint   _L_: Run last configurations 
     _b_: Set breakpoint          _o_: Step over                    _i_: Step into                  _O_:  Step Out
     _X_: Clear all breakpoints   _A_: List all breakpoints         _*_: Run to run to cursor       _T_: Terminate 
     _r_: Repl toggle             _s_: Scope                        _g?_: Toggle hint   
     ^
     ^ ^                                          _<Esc>_: Normal mode             
    ]]

      DapHydra = Hydra({
         name = "DEBUG",
         hint = hint,
         config = {
            color = 'pink',
            desc = "Debug mode",
            invoke_on_body = true,
            hint = {
              float_opts = {
            border = "rounded",
          },
              hide_on_load = true,
              show_name = false,
            },
         },

         mode = 'n',
         body = '<Leader>d',
         heads = {
            { "u", function() require("dapui").toggle() end, {exit = false, private = true} },
            { "b", function() require("dap").toggle_breakpoint() end, { exit = false, private = true} },
            { "B", function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, { exit = false, private = true} },
            { "c", function() require("dap").continue() end, {exit = false, private = true} },
            { "O", function() require("dap").step_out() end, {exit = false, private = true} },
            { "o", function() require("dap").step_over() end, {exit = false, private = true} },
            { "i", function() require("dap").step_into() end, {exit = false, private = true} },
            { "L", function() require("dap").debug_run_last() end, {exit = false, private = true} },
            { "X", function() require("dap").clear_breakpoints() end, {exit = false, private = true} },
            { "A", '<cmd>Telescope dap list_breakpoints<cr>', {exit = false, private = true, silent = true } },
            { "*", function() require("dap").run_to_cursor() end, {exit = false, private = true} },
            { "T", function() require("dap").terminate() end, {exit = false, private = true} },
            { "r", function() require("dap").repl.toggle() end, {exit = false, private = true} },
            { "s", function() require("dap.ui.widgets").centered_float(require("dap.ui.widgets").scopes) end, {exit = false, private = true} },
            { "g?", function() if DapHydra.hint.win then DapHydra.hint:close() else DapHydra.hint:show() end end, {exit = false, private = true} },
            { '<Esc>', nil, { exit = true, nowait = true } },
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
