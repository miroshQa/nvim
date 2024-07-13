return  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    enabled = true,
    config = function()

      require('which-key').setup({ })

      require('which-key').add {
        { "<leader>d", group = "DEBUG" },
        { "<leader>d_", hidden = true },
        { "<leader>f", group = "Find" },
        { "<leader>f_", hidden = true },
        { "<leader>g", group = "Git" },
        { "<leader>g_", hidden = true },
        { "<leader>l", group = "Lsp keymaps" },
        { "<leader>l_", hidden = true },
        { "<leader>u", group = "UI / Update" },
        { "<leader>u_", hidden = true },
      }
    end,
}
