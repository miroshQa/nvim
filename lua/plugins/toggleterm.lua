return {
  -- amongst your other plugins
  { 'akinsho/toggleterm.nvim', version = "*",
    config = function()
      local powershell_options = {
        shell = vim.fn.executable "pwsh" == 1 and "pwsh",
        shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
        shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
        shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
        shellquote = "",
        shellxquote = "",
      }

      for option, value in pairs(powershell_options) do
        vim.opt[option] = value
      end

      require("toggleterm").setup({
        open_mapping = "<c-t>",
        autochdir = true,
        terminal_mappings = true,
        direction = "float",
      })

      vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })
    end
  },
}
