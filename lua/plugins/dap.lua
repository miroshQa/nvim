local dmap = function(key, func, descritpion)
  vim.keymap.set("n", key, func, {desc = descritpion})
end

-- ESDF control like in cs go (instead wasd)
--  syntax '<cmd> lua require(...)...' allow us to lazy load this  (It is a false actually, We can use just function() ... end)
dmap("<M-e>", function() require('dap').step_back() end, "Step back")
dmap("<M-d>", function() require('dap').step_over() end, "Step over")
dmap("<M-s>", function() require('dap').step_out() end, "Step out")
dmap("<M-f>", function() require('dap').step_into() end, "Step into")
dmap("<leader>dc", function() require('dap').continue() end , "Continue")
dmap("<leader>dC", function() require('dap').reverse_continue() end, "Reverese continue")


dmap("<leader>du", function() require('dap') require('dapui').toggle() end, "UI toggle")
dmap("<leader>dt", function() require('dap').terminate() end, "Termniate")
dmap("<leader>dh", function() require('dap').run_to_cursor() end, "Debug HERE (Run to cursoer)")
dmap("<leader>db", function() require('dap').list_breakpoints() end, "Breakpoinst list")
dmap("<leader>dB", function() require('dap').clear_breakpoints() end, "Clear breakpoints list")
dmap("<leader>df", function() require('dap').focus_frame() end, "Go to paused")
dmap("<leader>db", function() require('dap').toggle_breakpoint() end, "Toggle breakpont")
dmap("<leader>di", function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, "Set conditional breakpoint ([i]f)")
dmap("<leader>de", function() require('dap').set_exception_breakpoints() end, "Set exception breakpont")
dmap("<leader>ds", function() require('dap.ui.widgets').centered_float(require('dap.ui.widgets').scopes) end, "Scopes")
dmap("[s", function() require('dap').down() end, "Stack frame down")
dmap("]s", function() require('dap').up() end, "Stack frame up")

vim.api.nvim_command 'autocmd FileType dap-float nnoremap <buffer><silent> q <cmd>close!<CR>'



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

        python = function(config)
          config.adapters = {
            type = "executable",
            command = "/usr/bin/python3",
            args = {
              "-m",
              "debugpy.adapter",
            },
          }
          require('mason-nvim-dap').default_setup(config) -- don't forget this!
        end,

        coreclr = function()
          dap.adapters.coreclr = {
            type = 'executable',
            command = vim.fn.stdpath("data") .. "/mason/packages/netcoredbg/netcoredbg/netcoredbg.exe",
            args = { '--interpreter=vscode' }, -- :lua print(vim.inspect(require("dap").adapters)) VERY USEFUL FOR DEBUG
          }

          dap.configurations.cs = {
            {
              type = "coreclr",
              name = "launch - netcoredbg",
              request = "launch",
              program = function()
                return vim.fn.input('Path to dll (Do not forget recompile your project!): ',
                  vim.fn.getcwd() .. '/bin/Debug/net8.0/', 'file')
              end,
            },
          }
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
  end,
}
