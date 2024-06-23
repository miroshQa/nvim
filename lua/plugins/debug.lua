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
         ^ ^Step^ ^ ^      ^ ^     Action
     ----^-^-^-^--^-^----  ^-^-------------------  
         ^ ^back^ ^ ^      _m_: toggle breakpoint 
         ^ ^ _K_^ ^         _M_: Set conditional breakpoint 
     out _H_ ^ ^ _L_ into   _z_: Continue
         ^ ^ _J_ ^ ^        _X_: Terminate
         ^ ^over ^ ^      ^^_s_: open scope
                      _U_: UI toggle
                      _g?_: Hydra hint
                      _gl_: Run last configuration
                      _*_: Run to cursor

         ^ ^  _<Esc>_: Normal mode
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
            { "U", function() require("dapui").toggle() end},
            { "m", function() require("dap").toggle_breakpoint() end },
            { "M", function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end },
            { "z", function() if vim.bo.filetype ~= "dap-float" then require("dap").continue() end end},
            { "K", function() if vim.bo.filetype ~= "dap-float" then require("dap").step_back() end end},
            { "H", function() if vim.bo.filetype ~= "dap-float" then require("dap").step_out() end end},
            { "J", function() if vim.bo.filetype ~= "dap-float" then print(vim.bo.filetype) require("dap").step_over() end end},
            { "L", function() if vim.bo.filetype ~= "dap-float" then require("dap").step_into() end end},
            { "gl", function() debug_run_last() end},
            { "X", function() require("dap").terminate() end},
            { "*", function() require("dap").run_to_cursor() end},
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
              if hydra_statusline.is_active() == true and vim.fn.mode() == "n" then
                return hydra_statusline.get_name()
              end
              return str
            end,

            color = function(tb)
              if hydra_statusline.is_active() == true and vim.fn.mode() == "n" then
                return {bg = hydra_statusline.get_color()}
              end
              return tb
            end,
          }
        }
      }
    })

      vim.fn.sign_define('DapBreakpoint',          { text='', texthl='red'})
      vim.fn.sign_define('DapBreakpointCondition', { text='', texthl='blue'})
      vim.fn.sign_define('DapBreakpointRejected',  { text='', texthl='orange'})
      vim.fn.sign_define('DapStopped',             { text='󰁕', texthl='green'})
      vim.fn.sign_define('DapLogPoint',            { text='.>', texthl='yellow', linehl='DapBreakpoint', numhl='DapBreakpoint' })


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
