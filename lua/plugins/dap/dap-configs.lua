return {
    "mfussenegger/nvim-dap",
    version = "*",
    dependencies = {
      "williamboman/mason.nvim",
      "nvim-neotest/nvim-nio",
    },
    config = function()

      require("mason").setup() -- Function vim.fn.exepath will not work if we do not setup mason first
      local dap = require("dap")
      dap.set_log_level('TRACE')

      dap.adapters.coreclr = {
       type = 'executable',
      command = vim.fn.stdpath("data") .."/mason/packages/netcoredbg/netcoredbg/netcoredbg.exe" ,
       args = {'--interpreter=vscode'}, -- :lua print(vim.inspect(require("dap").adapters)) VERY USEFUL FOR DEBUG
      }

      dap.configurations.cs = {
       {
         type = "coreclr",
         name = "launch - netcoredbg",
         request = "launch",
         program = function()
             return vim.fn.input('Path to dll (Do not forget recompile your project!): ', vim.fn.getcwd() .. '/bin/Debug/net8.0/', 'file')
         end,
       },
     }

    dap.adapters.codelldb = {
      type = 'server',
      port = "${port}",
      executable = {
        command = vim.fn.stdpath("data") .."/mason/packages/codelldb/extension/adapter/codelldb.exe" , -- executable and exepath are different functions!!!
        args = {"--port", "${port}"},
        detached = false,
      }
    }

  dap.defaults.fallback.external_terminal = { command = 'wt'}

--https://github.com/vadimcn/codelldb/blob/master/MANUAL.md
  dap.configurations.cpp = {
    {
      name = "Launch file",
      type = "codelldb",
      request = "launch",
      program = function()
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
      end,
      cwd = '${workspaceFolder}',
      stopOnEntry = false,
      terminal = "external",
    },
  }
    end,
}
