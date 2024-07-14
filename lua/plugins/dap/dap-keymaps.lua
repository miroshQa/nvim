return {
    "nvim-neotest/nvim-nio",
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
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

    ---@param dir "next"|"prev"
    local function gotoBreakpoint(dir)
      local breakpoints = require("dap.breakpoints").get()
      if #breakpoints == 0 then
        vim.notify("No breakpoints set", vim.log.levels.WARN)
        return
      end
      local points = {}
      for bufnr, buffer in pairs(breakpoints) do
        for _, point in ipairs(buffer) do
          table.insert(points, { bufnr = bufnr, line = point.line })
        end
      end

      local current = {
        bufnr = vim.api.nvim_get_current_buf(),
        line = vim.api.nvim_win_get_cursor(0)[1],
      }

      local nextPoint
      for i = 1, #points do
        local isAtBreakpointI = points[i].bufnr == current.bufnr and points[i].line == current.line
        if isAtBreakpointI then
          local nextIdx = dir == "next" and i + 1 or i - 1
          if nextIdx > #points then nextIdx = 1 end
          if nextIdx == 0 then nextIdx = #points end
          nextPoint = points[nextIdx]
          break
        end
      end
      if not nextPoint then nextPoint = points[1] end

      vim.cmd(("buffer +%s %s"):format(nextPoint.line, nextPoint.bufnr))
    end

    local dmap = function(key, func, descritpion)
      vim.keymap.set("n", key, func, {desc = "DEBUG: " .. descritpion})
    end

    -- ESDF control like in cs go (instead wasd)
    dmap("<M-e>", function() if vim.bo.filetype ~= "dap-float" then require("dap").step_back() end end, "Step back")
    dmap("<M-d>", function() if vim.bo.filetype ~= "dap-float" then require("dap").step_over() end end, "Step over")
    dmap("<M-s>", function() if vim.bo.filetype ~= "dap-float" then print("step out") require("dap").step_out() end end, "Step out")
    dmap("<M-f>", function() if vim.bo.filetype ~= "dap-float" then print("step into") require("dap").step_into() end end, "Step into")
    dmap(">", function() if vim.bo.filetype ~= "dap-float" then require("dap").continue() end end, "Continue")
    dmap("<", function() if vim.bo.filetype ~= "dap-float" then require("dap").reverse_continue() end end, "Reverese continue")


    dmap("<leader>du", function() require("dapui").toggle() end, "UI toggle")
    dmap("<leader>dt", function() if vim.bo.filetype ~= "dap-float" then require("dap").terminate() end end, "Termniate")
    dmap("<leader>dh", function() require("dap").run_to_cursor() end, "Debug HERE (Run to cursoer)")
    dmap("<leader>db", function() require("dap").list_breakpoints() end, "Breakpoinst list")
    dmap("<leader>dB", function() require("dap").clear_breakpoints() end, "Clear breakpoints list")
    dmap("<leader>df", function() require("dap").focus_frame() end, "Go to paused")
    dmap("<leader>dl", function() debug_run_last() end, "Run last configuration")
    dmap("<leader>db", function() require("dap").toggle_breakpoint() end, "Toggle breakpont")
    dmap("<leader>dc", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, "Set conditional breakpoint")
    dmap("<leader>de", function() require("dap").set_exception_breakpoints() end, "Set exception breakpont")
    dmap("gs", function() if vim.bo.filetype ~= "dap-float" then require("dap.ui.widgets").centered_float(require("dap.ui.widgets").scopes) end end, "Scopes")
    dmap("[b", function() gotoBreakpoint("prev") end, "Prev breakpoint")
    dmap("]b", function() gotoBreakpoint("next") end, "Next breakpoint")
    dmap("[s", function() require("dap").down() end, "Stack frame down")
    dmap("]s", function() require("dap").up() end, "Stack frame up")


    vim.api.nvim_command 'autocmd FileType dap-float nnoremap <buffer><silent> q <cmd>close!<CR>'
    end,
}
