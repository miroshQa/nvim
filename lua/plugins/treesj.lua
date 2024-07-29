vim.keymap.set("n", "gs", "<cmd>lua require('treesj').toggle()<CR>", {desc = "Toggle split / join"})
vim.keymap.set("n", "gS", "<cmd>lua require('treesj').toggle({split = {recursive = true}})<CR>", {desc = "Toggle split / join recursively"})

return {
  'Wansmer/treesj',
  lazy = true,
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
  },
  config = function()
    require('treesj').setup({
      max_join_length = 250,
      use_default_keymaps = false,
    })
  end,
}
