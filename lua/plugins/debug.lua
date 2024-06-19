return {
    "mfussenegger/nvim-dap",
    version = "*",
    dependencies = {
      "theHamsta/nvim-dap-virtual-text",
       "nvim-neotest/nvim-nio",
      "rcarriga/nvim-dap-ui",
    },
    config = function()
      require("nvim-dap-virtual-text").setup({})

      vim.keymap.set("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", {desc = "Toggle breakpiont"})
      vim.keymap.set("n", "<leader>dB", ":lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>", {desc = "Set conditional breakpoint"})
      vim.keymap.set("n", '<leader>dx', "<cmd>lua require'dap'.clear_breakpoints()<cr>")
      vim.keymap.set("n", '<leader>da', '<cmd>Telescope dap list_breakpoints<cr>')

      vim.keymap.set("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>")
      vim.keymap.set("n", "<leader>d*", function() require("dap").run_to_cursor() end, {desc = "Run to Cursor" })
      vim.keymap.set("n", "<leader>dg", function() require("dap").goto_() end, {desc = "Go to Line (No Execute)" })
      vim.keymap.set("n", "<leader>dj", "<cmd>lua require'dap'.step_over()<cr>")
      vim.keymap.set("n", "<leader>dk", "<cmd>lua require'dap'.step_into()<cr>")
      vim.keymap.set("n", "<leader>do", "<cmd>lua require'dap'.step_out()<cr>")
      vim.keymap.set("n", '<leader>di', require("dapui").float_element, {desc = "Hover variable info"})
      vim.keymap.set("n", '<leader>dt', function() require('dap').terminate(); require('dapui').close(); end, {desc = "Terminate"})
      vim.keymap.set("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>")
      vim.keymap.set("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>")
      vim.keymap.set("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<CR>", { desc = "Toggle Repl" })
      vim.keymap.set("n", "<leader>df", "<cmd>Telescope dap frames<CR>", { desc = "Stack frames" })
      vim.keymap.set("n", "<leader>dp", "<cmd>Telescope dap list_breakpoints<CR>", { desc = "All breakpoints" })
      vim.keymap.set("n", "<leader>ds", "<cmd>lua require'dap.ui.widgets'.centered_float(require'dap.ui.widgets'.scopes)<CR>", { desc = "View current scope" })
      vim.keymap.set("n", "<leader>du", "<cmd>lua require('dapui').toggle()<CR>", {desc = "Toggle dapui"})
      vim.keymap.set('n', '<leader>de', function() require"dap".set_exception_breakpoints({"all"}) end, {desc = "Add exceptions breakpoints"})

      local dap = require("dap")
      local dapui = require("dapui")

      require('dap').set_log_level('TRACE')
      dap.adapters.gdb = {
        type = "executable",
        id = "gdb",
        command = "gdb",
        args = {"--interpreter=dap"},
      }

      dap.configurations.cpp = {
        {
          type = "gdb",
          request = "launch",
          name = "Launch gdb",
          program = function()
            --return "mWeather"
            -- Оказывается на винде нужен путь формата a//b//b//... Часа три дебажил
            local cwd_path = string.gsub(vim.fn.getcwd(), "\\", "//")
            local path = vim.fn.input("Path to executable: ", cwd_path .. "//", "file")
            return path
          end,
          cwd = "${workspaceFolder}",
          stopAtBeginningOfMainSubprogram = false,
        },
      }




      dap.configurations.c = dap.configurations.cpp

      vim.api.nvim_command 'autocmd FileType dap-float nnoremap <buffer><silent> q <cmd>close!<CR>'
      vim.api.nvim_command 'autocmd FileType dap-float nnoremap <buffer><silent> <esc> <cmd>close!<CR>'
       dapui.setup()

    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end

    end,
}
