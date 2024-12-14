-- https://github.com/mfussenegger/nvim-dap/issues/786
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("PromptBufferCtrlwFix", {}),
  pattern = {"dap-repl"},
  callback = function()
    vim.keymap.set("i", "<C-w>", "<C-S-w>", {buffer = true})
  end
})


return {
  "mfussenegger/nvim-dap",
  lazy = true,
  version = "*",
  dependencies = {
    "williamboman/mason.nvim",
    "nvim-neotest/nvim-nio",
    "theHamsta/nvim-dap-virtual-text",
    "jay-babu/mason-nvim-dap.nvim",
    "nvim-telescope/telescope-dap.nvim",
    {"rcarriga/nvim-dap-ui", opts = {}}
  },
  keys = {
    {"<leader>do", "<cmd>DapStepOver<CR>", "Step over"},
    {"<leader>dO", "<cmd>DapStepOut<CR>", "Step out"},
    {"<leader>di", "<cmd>DapStepInto<CR>", "Step into"},
    {"<leader>dr", "<cmd>Telescope dap configurations<CR>", "Toggle repl"},
    {"<leader>dc", "<cmd>DapContinue<CR>", "Continue"},
    {"<leader>dt", "<cmd>DapTerminate<CR>", "Termniate"},
    {"<leader>dh", function() require('dap').run_to_cursor() end, "Debug HERE (Run to cursoer)"},
    {"<leader>df", "<cmd>Telescope dap frames<CR>", "Go to paused"},
    {"<leader>du", function() require("dapui").toggle() end, "Go to paused"},
    {"<leader>dF", function() require('dap').focus_frame() end, "Go to paused"},
    {"<leader>db", function() require('dap').toggle_breakpoint() end, "Toggle breakpont"},
    {"<leader>dB", "<cmd>Telescope dap list_breakpoints<CR>", "Toggle breakpont"},
    {"<leader>ds", function() require('dap.ui.widgets').centered_float(require('dap.ui.widgets').scopes) end, "Scopes"},
    {"[s", function() require('dap').down() end, "Stack frame down"},
    {"]s", function() require('dap').up() end, "Stack frame up"},
  },
  config = function()
    require("mason").setup() -- Function vim.fn.exepath will not work if we do not setup mason first
    local dap = require("dap")
    dap.set_log_level('TRACE')
    -- https://github.com/jay-babu/mason-nvim-dap.nvim/blob/main/lua/mason-nvim-dap/mappings/source.lua
    require("mason-nvim-dap").setup({
      automatic_installation = true,
      ensure_installed = {},
      handlers = {
        function(config)
          require('mason-nvim-dap').default_setup(config)
        end,

      },
    })

    require("telescope").load_extension("dap")
    require("nvim-dap-virtual-text").setup({ virt_text_pos = "eol"})

    local wpath = vim.fn.exepath("wezterm")
    if not wpath then
      print("Wezterm haven't found. External terminal launch will fail")
    end

    dap.defaults.fallback.external_terminal = {
      command = wpath,
      args = {"start", "--always-new-process"}
    }

    dap.defaults.fallback.force_external_terminal = true

    local dapui = require("dapui")
    dap.listeners.before.attach.dapui_config = function() dapui.open() end
    dap.listeners.before.launch.dapui_config = function() dapui.open() end
    dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
    dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

    vim.fn.sign_define('DapBreakpoint',          { text='', texthl='red'})
    vim.fn.sign_define('DapBreakpointCondition', { text='', texthl='blue'})
    vim.fn.sign_define('DapBreakpointRejected',  { text='', texthl='orange'})
    vim.fn.sign_define('DapStopped',             { text='󰁕', texthl='green'})
    vim.fn.sign_define('DapLogPoint',            { text='.>', texthl='yellow', linehl='DapBreakpoint', numhl='DapBreakpoint' })

    vim.api.nvim_command 'autocmd FileType dap-float nnoremap <buffer><silent> q <cmd>close!<CR>'
  end,
}
