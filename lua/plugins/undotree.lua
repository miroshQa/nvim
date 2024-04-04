return {
  'mbbill/undotree',
    config = function()
      vim.keymap.set('n', '<leader>ut', vim.cmd.UndotreeToggle, {desc = "Toggle undo tree"})
    end,
}

