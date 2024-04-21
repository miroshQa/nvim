return  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    config = function() -- This is the function that runs, AFTER loading
      require('which-key').setup({
    })

      -- Document existing key chains
      require('which-key').register {
        ['<leader>d'] = { name = 'Debug', _ = 'which_key_ignore' },
        ['<leader>f'] = { name = 'Find', _ = 'which_key_ignore' },
        ['<leader>t'] = { name = 'Terminal (<ctrl-t> = close/toggle)', _ = 'which_key_ignore' },
        ['<leader>s'] = { name = 'Splits keymaps', _ = 'which_key_ignore' },
        ['<leader>l'] = { name = 'Lsp keymaps', _ = 'which_key_ignore' },
      }
    end,
}
