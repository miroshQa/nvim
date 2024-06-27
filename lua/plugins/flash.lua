-- 19:00. Короче, в итоге я решил что лучше это на отдельный кеймап вообще поместить, а конкретно на s. Потому что тогда вообще получается что ? а также n и N как таковые вообще не нужны. Так что лучше конкретно одну клавишу для flash выделить, а / и ? пуская остаюстя самостоятельными для поиска по файлу вне зоны видимости
return {
    "folke/flash.nvim",
    event = "VeryLazy",
    vscode = true,
    ---@type Flash.Config
    opts = {
      modes = {
      char = {
        enabled = false,
      },
      search = {
        enabled = true,
      }
    }
  },
  keys = {
    { "<leader>s", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "s", mode = { "n"}, function() require("flash").jump() end},
  },
}


-- https://www.reddit.com/r/neovim/comments/16l27rx/what_are_yalls_opinions_on_using_plugins_like/
-- https://www.youtube.com/live/eJ3XV-3uoug?t=666s Takeaway: Flash nvim is better than leap nvim. 
