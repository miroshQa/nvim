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
    { "rcarriga/nvim-dap-ui", opts = {} },
  },
  keys = {

    {"<C-n>", "<cmd>DapStepOver<CR>", "Debug: step over (next line)"},
    {"<C-p>", "<cmd>DapStepOut<CR>", "Debug: step out (prev func call)"},
    {"<C-g>", "<cmd>DapStepInto<CR>", "Debug: step into (Go deeper)"},
    {"<C-c>", "<cmd>DapContinue<CR>", "Debug: continue"},

    {"<leader>db", "<cmd>DapToggleBreakpoint<CR>", "Debug: toggle breakpoint"},
    { '<leader>dB', function() require('dap').set_breakpoint(vim.fn.input 'Breakpoint condition: ') end, desc = 'Debug: Set Breakpoint', },
    {"<leader>r", function() require('dap').run_to_cursor() end, "Debug: run to cursor"},

    {"<leader>dt", "<cmd>DapTerminate<CR>", "Termniate"},
    -- {"<leader>ds", function() require('dap.ui.widgets').centered_float(require('dap.ui.widgets').scopes) end, "Scopes"},
    {"U", function() require('dap.ui.widgets').hover() end}
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

    require("nvim-dap-virtual-text").setup({ virt_text_pos = "eol"})

    local wpath = vim.fn.exepath("wezterm")
    if not wpath then
      print("Wezterm haven't found. External terminal launch will fail")
    end

    require("dap").defaults.fallback.auto_continue_if_many_stopped = false

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

    -- dap.defaults.fallback.external_terminal = {
    --   command = wpath,
    --   args = {"start", "--always-new-process"}
    -- }
    --
    -- dap.defaults.fallback.force_external_terminal = true
    --
    -- vim.fn.sign_define('DapBreakpoint',          { text='', texthl='red'})
    -- vim.fn.sign_define('DapBreakpointCondition', { text='', texthl='blue'})
    -- vim.fn.sign_define('DapBreakpointRejected',  { text='', texthl='orange'})
    -- vim.fn.sign_define('DapStopped',             { text='󰁕', texthl='green'})
    -- vim.fn.sign_define('DapLogPoint',            { text='.>', texthl='yellow', linehl='DapBreakpoint', numhl='DapBreakpoint' })
    --
    --
    -- local widgets = require('dap.ui.widgets')
    -- local scopes = widgets.sidebar(widgets.scopes, {}, 'vs | wincmd l')
    -- local repl = require("dap.repl")
    -- local op = function()
    --     scopes.toggle()
    --     repl.toggle({}, 'wincmd l | split')
    --   end
    --
    -- vim.keymap.set( "n", "<leader>du", op)
    --
    -- dap.listeners.before.attach.ui = function () op() end
    -- dap.listeners.before.launch.ui = function() op() end
    -- dap.listeners.before.event_terminated.dapui_config = function() op() end
    -- dap.listeners.before.event_exited.dapui_config = function() op() end

    vim.api.nvim_command 'autocmd FileType dap-float nnoremap <buffer><silent> q <cmd>close!<CR>'
  end,
}
