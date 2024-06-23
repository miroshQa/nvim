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

    vim.keymap.set("n", "K", function() if vim.bo.filetype ~= "dap-float" then require("dap").step_back() end end)
    vim.keymap.set("n", "H", function() if vim.bo.filetype ~= "dap-float" then require("dap").step_out() end end)
    vim.keymap.set("n", "J", function() if vim.bo.filetype ~= "dap-float" then require("dap").step_over() end end)
    vim.keymap.set("n", "L", function() if vim.bo.filetype ~= "dap-float" then require("dap").step_into() end end)

    vim.keymap.set("n", ">", function() if vim.bo.filetype ~= "dap-float" then require("dap").continue() end end)
    vim.keymap.set("n", "<", function() if vim.bo.filetype ~= "dap-float" then require("dap").reverse_continue() end end)
    vim.keymap.set("n", "gu", function() require("dapui").toggle() end)
    vim.keymap.set("n", "gs", function() if vim.bo.filetype ~= "dap-float" then require("dap.ui.widgets").centered_float(require("dap.ui.widgets").scopes) end end)
    vim.keymap.set("n", "g*", function() if vim.bo.filetype ~= "dap-float" then require("dap").reverse_continue() end end)
    vim.keymap.set("n", "g-", function() if vim.bo.filetype ~= "dap-float" then require("dap").terminate() end end)
    vim.keymap.set("n", "<leader>db", function() require("dap").list_breakpoints() end)
    vim.keymap.set("n", "<leader>dB", function() require("dap").clear_breakpoints() end)
    vim.keymap.set("n", "gc", function() require("dap").set_exception_breakpoints() end)
    vim.keymap.set("n", "gp", function() require("dap").focus_frame() end)
    vim.keymap.set("n", "[b", function() gotoBreakpoint("prev") end)
    vim.keymap.set("n", "]b", function() gotoBreakpoint("next") end)
    vim.keymap.set("n", "[s", function() require("dap").down() end)
    vim.keymap.set("n", "]s", function() require("dap").up() end)
    vim.keymap.set("n", "ga", function() debug_run_last() end)
    vim.keymap.set("n", "z", function() require("dap").toggle_breakpoint() end)
    vim.keymap.set("n", "Z", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end)


    vim.api.nvim_command 'autocmd FileType dap-float nnoremap <buffer><silent> q <cmd>close!<CR>'
    end,
}
