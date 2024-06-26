-- Самое балдежное что это не добавляет новые кеймапы, а расширяет возможность существующих нативных f, t, F, T, /, ?
-- So it is basically / and ? on steroids
return {
    "folke/flash.nvim",
    event = "VeryLazy",
    vscode = true,
    ---@type Flash.Config
    opts = {
      modes = {
      search = {
        enabled = true,
      },
      char = {
        enabled = false,
      }
    }
  },
  keys = {
    { "<leader>s", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
  },
}


-- https://www.reddit.com/r/neovim/comments/16l27rx/what_are_yalls_opinions_on_using_plugins_like/
-- https://www.youtube.com/live/eJ3XV-3uoug?t=666s Takeaway: Flash nvim is better than leap nvim. 
