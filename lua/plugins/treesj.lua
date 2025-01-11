return {
  'Wansmer/treesj',
  keys = {
    {"gs", function() require('treesj').toggle() end, mode = "n"},
    {"gS", function() require('treesj').toggle({split = {recursive = true}}) end, mode = "n"}
  },
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
  },
  config = function()
    require('treesj').setup({
      max_join_length = 1000000,
      use_default_keymaps = false,
    })
  end,
}
