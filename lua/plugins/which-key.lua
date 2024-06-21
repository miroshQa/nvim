return  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    config = function() -- This is the function that runs, AFTER loading
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
