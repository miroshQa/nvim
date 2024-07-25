return  {
    'folke/which-key.nvim',
    event = "VeryLazy",
    version = "3.x.x",
    config = function()
      require('which-key').setup({
        notify = false,
        triggers = { "<auto>", mode = "niotc" },
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
