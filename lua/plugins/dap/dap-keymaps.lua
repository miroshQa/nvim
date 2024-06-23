return {
    "nvimtools/hydra.nvim",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
      "rcarriga/nvim-dap-ui",
      "nvim-lualine/lualine.nvim",
    },
    config = function()
      local dap = require("dap")
    --
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
         ^ ^back^ ^ ^      _z_: toggle breakpoint 
         ^ ^ _K_^ ^         _Z_: Set conditional breakpoint 
     out _H_ ^ ^ _L_ into   _>_: Continue
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
            { "z", function() require("dap").toggle_breakpoint() end },
            { "Z", function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end },
            { ">", function() if vim.bo.filetype ~= "dap-float" then require("dap").continue() end end},
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
    end,
}
