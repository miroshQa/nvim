vim.keymap.set("n", "<C-t>", "<cmd>lua require('toggleterm') vim.cmd('ToggleTerm')<CR>", {desc = "description"})

return {
  -- amongst your other plugins
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    lazy = true,
    config = function()


      if vim.loop.os_uname().sysname ~= "Linux" then
        local powershell_options = {
          shell = "pwsh",
          shellcmdflag = "-NoLogo -NoProfile -NoExit -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;",
          shellredir = "-RedirectStandardOutput %s -NoNewWindow -Wait",
          shellpipe = "2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode",
          shellquote = "",
          shellxquote = "",
        }

        for option, value in pairs(powershell_options) do
          vim.opt[option] = value
        end
      end


      require("toggleterm").setup({
        open_mapping = "<C-t>",
        autochdir = true,
        terminal_mappings = true,
        shade_terminals = false,
        direction = "float",
        float_opts = {
          title_pos = "center",
        },
      })

      vim.api.nvim_command 'autocmd TermOpen * startinsert' -- starts in insert mode
      vim.api.nvim_command 'autocmd TermOpen * setlocal nonumber' -- no numbers
      vim.api.nvim_command 'autocmd TermEnter * setlocal signcolumn=no' -- no sign column
      vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Go to normal mode' })
    end
  },
}
