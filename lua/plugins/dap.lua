-- https://github.com/mfussenegger/nvim-dap/issues/786
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("PromptBufferCtrlwFix", {}),
  pattern = {"dap-repl"},
  callback = function()
    vim.keymap.set("i", "<C-w>", function() vim.cmd("normal! bcw") end, {buffer = true})
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
  },
  keys = {
    {"<leader>do", "<cmd>DapStepOver<CR>", "Step over"},
    {"<leader>dO",  "<cmd>DapStepOut<CR>", "Step out"},
    {"<leader>di",   "<cmd>DapStepInto<CR>", "Step into"},
    {"<leader>dr",   "<cmd>DapToggleRepl<CR>", "Toggle repl"},
    {"<leader>dc", "<cmd>DapContinue<CR>", "Continue"},
    {"<leader>dt", "<cmd>DapTerminate<CR>", "Termniate"},
    {"<leader>dh", function() require('dap').run_to_cursor() end, "Debug HERE (Run to cursoer)"},
    {"<leader>db", function() require('dap').list_breakpoints() end, "Breakpoinst list"},
    {"<leader>dB", function() require('dap').clear_breakpoints() end, "Clear breakpoints list"},
    {"<leader>df", function() require('dap').focus_frame() end, "Go to paused"},
    {"<leader>db", function() require('dap').toggle_breakpoint() end, "Toggle breakpont"},
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
          require('mason-nvim-dap').default_setup(config)
        end,

      },
    })

    require("telescope").load_extension("dap")
    -- Interface Setup
    require("nvim-dap-virtual-text").setup({ virt_text_pos = "eol"})
    vim.fn.sign_define('DapBreakpoint',          { text='', texthl='red'})
    vim.fn.sign_define('DapBreakpointCondition', { text='', texthl='blue'})
    vim.fn.sign_define('DapBreakpointRejected',  { text='', texthl='orange'})
    vim.fn.sign_define('DapStopped',             { text='󰁕', texthl='green'})
    vim.fn.sign_define('DapLogPoint',            { text='.>', texthl='yellow', linehl='DapBreakpoint', numhl='DapBreakpoint' })

    vim.api.nvim_command 'autocmd FileType dap-float nnoremap <buffer><silent> q <cmd>close!<CR>'
  end,
}
