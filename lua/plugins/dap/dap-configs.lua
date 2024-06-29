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

    dap.adapters["pwa-node"] = {
      type = "server",
      host = "localhost",
      port = "${port}",
      executable = {
        command = "node",
        args = {vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js", "${port}"},
      }
    }

    dap.configurations.javascript = {
      {
        type = "pwa-node",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        cwd = "${workspaceFolder}",
      },
    }


    end,
}
