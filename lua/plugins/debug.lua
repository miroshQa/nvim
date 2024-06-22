return {
    "mfussenegger/nvim-dap",
    version = "*",
    dependencies = {
      "williamboman/mason.nvim",
    --This shit doesn't work properly. It is easiest to install adapters manually through Mason
      --- "jay-babu/mason-nvim-dap.nvim",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",
      "rcarriga/nvim-dap-ui",
      "nvimtools/hydra.nvim",
      "nvim-lualine/lualine.nvim",
    },
    config = function()

      require("nvim-dap-virtual-text").setup({ virt_text_pos = "eol"})
      local dap = require("dap")
      local dapui = require("dapui")
      dap.set_log_level('TRACE')
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
     _u_: Toggle DAP UI           _A_: Set conditional breakpoint   _c_: Continue from breakpoint   _L_: Run last configurations 
     _a_: Set breakpoint          _o_: Step over                    _i_: Step into                  _O_:  Step Out
     _X_: Clear all breakpoints   _P_: List all breakpoints         _*_: Run to run to cursor       _T_: Terminate 
     _r_: Repl toggle             _s_: Scope                        _g?_: Toggle hint   
     ^
     ^ ^                                       _<Esc>_: Back to Normal mode             
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
            { "a", function() require("dap").toggle_breakpoint() end },
            { "A", function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end },
            { "c", function() if vim.bo.filetype ~= "dap-float" then require("dap").continue() end end},
            { "O", function() if vim.bo.filetype ~= "dap-float" then require("dap").step_out() end end},
            { "o", function() if vim.bo.filetype ~= "dap-float" then print(vim.bo.filetype) require("dap").step_over() end end},
            { "i", function() if vim.bo.filetype ~= "dap-float" then require("dap").step_into() end end},
            { "L", function() debug_run_last() end},
            { "X", function() require("dap").clear_breakpoints() end},
            { "P", '<cmd>Telescope dap list_breakpoints<cr>'},
            { "*", function() require("dap").run_to_cursor() end},
            { "T", function() require("dap").terminate() end},
            { "r", function() require("dap").repl.toggle() end},
            { "s", function() if vim.bo.filetype ~= "dap-float" then require("dap.ui.widgets").centered_float(require("dap.ui.widgets").scopes) end end},
            { "g?", function() if DapHydra.hint.win then DapHydra.hint:close() else DapHydra.hint:show() end end},
            { '<Esc>', nil, { exit = true, nowait = true } },
         }
      })

    --Setup status line for Hydra
    local hydra_statusline = require("hydra.statusline")
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

      require("mason").setup() -- Function vim.fn.exepath will not work if we do not setup mason first
     dap.adapters.coreclr = {
       type = 'executable',
      command = vim.fn.stdpath("data") .."/mason/packages/netcoredbg/netcoredbg/netcoredbg.exe" ,
       args = {'--interpreter=vscode'}, -- :lua print(vim.inspect(require("dap").adapters)) VERY USEFUL FOR DEBUG
      }

      dap.configurations.cs = {
       {
         type = "coreclr",
         name = "launch - netcoredbg",
         request = "launch",
         program = function()
             return vim.fn.input('Path to dll (Do not forget recompile your project!): ', vim.fn.getcwd() .. '/bin/Debug/net8.0/', 'file')
         end,
       },
     }

    dap.adapters.codelldb = {
      type = 'server',
      port = "${port}",
      executable = {
        command = vim.fn.stdpath("data") .."/mason/packages/codelldb/extension/adapter/codelldb.exe" , -- executable and exepath are different functions!!!
        args = {"--port", "${port}"},
        detached = false,
      }
    }

  dap.defaults.fallback.external_terminal = {
    command = 'wt';
  }

--https://github.com/vadimcn/codelldb/blob/master/MANUAL.md
dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    terminal = "external",
  },
}


    --- Setup DapUi
    vim.api.nvim_command 'autocmd FileType dap-float nnoremap <buffer><silent> <q> <cmd>close!<CR>'
    dapui.setup()
    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    end,
}
