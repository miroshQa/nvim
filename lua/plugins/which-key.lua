return  {
    'folke/which-key.nvim',
    event = 'VimEnter',
    enabled = true,
    dependecies = {"Wansmer/langmapper.nvim"},
    config = function()



      require('which-key').setup({
    })

      require('which-key').register {
        ['<leader>f'] = { name = 'Find', _ = 'which_key_ignore' },
        ['<leader>l'] = { name = 'Lsp keymaps', _ = 'which_key_ignore' },
        ['<leader>g'] = { name = 'Git', _ = 'which_key_ignore' },
        ["<leader>d"] = {name = "DEBUG", _ = "which_key_ignore"},
        ["<leader>u"] = {name = "UI", _ = "which_key_ignore"},
      }
    end,
}
