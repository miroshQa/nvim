return {
    "mfussenegger/nvim-dap",
    version = "*",
    dependencies = {
      "theHamsta/nvim-dap-virtual-text",
     "nvim-neotest/nvim-nio",
      "rcarriga/nvim-dap-ui",
      "nvimtools/hydra.nvim",
      "nvim-lualine/lualine.nvim",
    },
    config = function()

      require("nvim-dap-virtual-text").setup({
         virt_text_pos = "eol",
      })

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
            { "u", function() require("dapui").toggle() end},
            { "b", function() require("dap").toggle_breakpoint() end },
            { "B", function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end },
            { "c", function() require("dap").continue() end},
            { "O", function() require("dap").step_out() end},
            { "o", function() require("dap").step_over() end},
            { "i", function() require("dap").step_into() end},
            { "L", function() debug_run_last() end},
            { "X", function() require("dap").clear_breakpoints() end},
            { "A", '<cmd>Telescope dap list_breakpoints<cr>'},
            { "*", function() require("dap").run_to_cursor() end},
            { "T", function() require("dap").terminate() end},
            { "r", function() require("dap").repl.toggle() end},
            { "s", function() require("dap.ui.widgets").centered_float(require("dap.ui.widgets").scopes) end},
            { "g?", function() if DapHydra.hint.win then DapHydra.hint:close() else DapHydra.hint:show() end end},
            { '<Esc>', nil, { exit = true, nowait = true } },
         }
      })

    local hydra_statusline = require("hydra.statusline");
    require("lualine").setup({
      options = {
        refresh = {
          statusline = 250,
        }
      },
      sections = {
      lualine_a = {
          {
            'mode',
            fmt = function(str)
              if hydra_statusline.is_active() == true then
                return hydra_statusline.get_name()
              end
              return str
            end,

            color = function(tb)
              if hydra_statusline.is_active() == true then
                return {bg = hydra_statusline.get_color()}
              end
              return tb
            end,
          }
        }
      }
    })

    dap.adapters.gdb = {
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
