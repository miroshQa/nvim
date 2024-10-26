


return {
  "mfussenegger/nvim-dap",
  lazy = true,
  version = "*",
  dependencies = {
    "williamboman/mason.nvim",
    "nvim-neotest/nvim-nio",
    "theHamsta/nvim-dap-virtual-text",
    "jay-babu/mason-nvim-dap.nvim",
    "rcarriga/nvim-dap-ui",
    "nvim-telescope/telescope-dap.nvim",
  },
  keys = {
    {"<M-d>", "<cmd>DapStepOver<CR>", "Step over"},
    {"<M-s>",  "<cmd>DapStepOut<CR>", "Step out"},
    {"<M-f>",   "<cmd>DapStepInto<CR>", "Step into"},
    {"<leader>dc", "<cmd>DapStepContinue<CR>", "Continue"},
    {"<leader>du", function() require('dap') require('dapui').toggle() end, "UI toggle"},
    {"<leader>dt", "<cmd>DapTerminate<CR>", "Termniate"},
    {"<leader>dh", function() require('dap').run_to_cursor() end, "Debug HERE (Run to cursoer)"},
    {"<leader>db", function() require('dap').list_breakpoints() end, "Breakpoinst list"},
    {"<leader>dB", function() require('dap').clear_breakpoints() end, "Clear breakpoints list"},
    {"<leader>df", function() require('dap').focus_frame() end, "Go to paused"},
    {"<leader>db", function() require('dap').toggle_breakpoint() end, "Toggle breakpont"},
    {"<leader>di", function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, "Set conditional breakpoint ([i]f)"},
    {"<leader>de", function() require('dap').set_exception_breakpoints() end, "Set exception breakpont"},
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
      ensure_installed = {
        "coreclr",
        "node2",
        "cppdbg"
      },
      handlers = {
        function(config)
          -- all sources with no handler get passed here
          -- Keep original functionality
          require('mason-nvim-dap').default_setup(config)
        end,

      },
    })

    require("telescope").load_extension("dap")
    -- Interface Setup
    require("nvim-dap-virtual-text").setup({ virt_text_pos = "eol"})
    local dapui = require("dapui")
    vim.fn.sign_define('DapBreakpoint',          { text='', texthl='red'})
    vim.fn.sign_define('DapBreakpointCondition', { text='', texthl='blue'})
    vim.fn.sign_define('DapBreakpointRejected',  { text='', texthl='orange'})
    vim.fn.sign_define('DapStopped',             { text='󰁕', texthl='green'})
    vim.fn.sign_define('DapLogPoint',            { text='.>', texthl='yellow', linehl='DapBreakpoint', numhl='DapBreakpoint' })

    dapui.setup()
    dap.listeners.after.event_initialized['dapui_config'] = dapui.open

    vim.api.nvim_command 'autocmd FileType dap-float nnoremap <buffer><silent> q <cmd>close!<CR>'
  end,
}
