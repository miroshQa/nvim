return  {
    'folke/which-key.nvim',
    event = "VeryLazy",
    config = function()
      require('which-key').setup({
        notify = false,
        modes = {
        s = false,
        x = false,
      }
    })

      require('which-key').add {
        { "<leader>d", group = "DEBUG" },
        { "<leader>o", group = "OVERSEER" },
        { "<leader>a", group = "AI" },
        { "<leader>f", group = "FIND" },
        { "<leader>g", group = "GIT" },
        { "<leader>l", group = "LSP" },
        { "<leader>u", group = "UI/Update" },
      }
    end,
}
