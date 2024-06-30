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
    }
  },
  keys = {
    { "s", mode = {"x", "o", "n"}, function() require("flash").jump() end}, -- use xi instead
    { "<leader>s", mode = {"x", "o", "n"}, function() require("flash").treesitter() end},
  },
}
-- Should you use flash? (YES)
-- https://www.reddit.com/r/neovim/comments/16l27rx/what_are_yalls_opinions_on_using_plugins_like/
-- https://www.reddit.com/r/neovim/comments/1aqif1r/are_you_using_any_motionenhancing_plugins/
-- По факту flash / leap и т.д это новый современный стандарт переменщения в nvim. Всего за 3 нажатия клавиш можно перместиться куда угодно совершенно без ментальных
-- усилий (даже в другой split). Если с базовыми vim моушенами мышка могла иногда обгонять, то с такими плагинами как flash у нее больше нет шансов
-- Старым ?, / пока на покой. (Разве что для поиска вне видимости буфера годятся)
