return  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    config = function()
      require('which-key').setup({
    })

      -- Document existing key chains
      require('which-key').register {
        ['<leader>f'] = { name = 'Find', _ = 'which_key_ignore' },
        ['<leader>l'] = { name = 'Lsp keymaps', _ = 'which_key_ignore' },
        ['<leader>g'] = { name = 'Git', _ = 'which_key_ignore' },
        ["<leader>h"] = {name = "Hunk", _ = "which_key_ignore"},
      }
    end,
}
