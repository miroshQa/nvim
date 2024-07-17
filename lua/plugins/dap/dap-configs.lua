return {
  "mfussenegger/nvim-dap",
  version = "*",
  dependencies = {
    "williamboman/mason.nvim",
    "nvim-neotest/nvim-nio",
    "jay-babu/mason-nvim-dap.nvim",
  },
  config = function()
    require("mason").setup() -- Function vim.fn.exepath will not work if we do not setup mason first
    local dap = require("dap")
    dap.set_log_level('TRACE')
    -- https://github.com/jay-babu/mason-nvim-dap.nvim/blob/main/lua/mason-nvim-dap/mappings/source.lua
    require("mason-nvim-dap").setup({
      ensure_installed = { "coreclr", "node2", "cppdbg" },
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

        -- coreclr = function()
        --   dap.adapters.coreclr = {
        --     type = 'executable',
        --     command = vim.fn.stdpath("data") .. "/mason/packages/netcoredbg/netcoredbg/netcoredbg.exe",
        --     args = { '--interpreter=vscode' }, -- :lua print(vim.inspect(require("dap").adapters)) VERY USEFUL FOR DEBUG
        --   }
        --
        --   dap.configurations.cs = {
        --     {
        --       type = "coreclr",
        --       name = "launch - netcoredbg",
        --       request = "launch",
        --       program = function()
        --         return vim.fn.input('Path to dll (Do not forget recompile your project!): ',
        --           vim.fn.getcwd() .. '/bin/Debug/net8.0/', 'file')
        --       end,
        --     },
        --   }
        -- end,

      },
    })
  end,
}
