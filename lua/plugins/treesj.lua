vim.keymap.set("n", "gs", function() require('treesj').toggle() end, {desc = "Toggle split / join"})
vim.keymap.set("n", "gS", function() require('treesj').toggle({split = {recursive = true}}) end, {desc = "Toggle split / join recursively"})

return {
  'Wansmer/treesj',
  lazy = true,
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
