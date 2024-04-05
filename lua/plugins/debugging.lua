return {
	"mfussenegger/nvim-dap",
	dependencies = {
    "nvim-neotest/nvim-nio",
		"leoluz/nvim-dap-go",
		"rcarriga/nvim-dap-ui",
    "mfussenegger/nvim-dap-python"
	},
	config = function()
    require("dapui").setup()
		require("dap-go").setup()
    require("dap-python").setup()

		local dap, dapui = require("dap"), require("dapui")

		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

		vim.keymap.set("n", "<Leader>dt", "<cmd>DapToggleBreakpoint<CR>")
		vim.keymap.set("n", "<Leader>dc", "<cmdDapContinue<CR>")
		vim.keymap.set("n", "<Leader>dx", "<cmd>DapTerminate<CR>")
		vim.keymap.set("n", "<Leader>do", "<cmd>DapStepOver<CR>")
	end,
}
