-- 19:00. Короче, в итоге я решил что лучше это на отдельный кеймап вообще поместить, а конкретно на s. Потому что тогда вообще получается что ? а также n и N как таковые вообще не нужны. Так что лучше конкретно одну клавишу для flash выделить, а / и ? пуская остаюстя самостоятельными для поиска по файлу вне зоны видимости
vim.keymap.set({"x", "o", "n"}, "s", "<cmd>lua require('flash').jump()<CR>", {desc = "Flash"})
vim.keymap.set({"x", "o", "n"}, "<C-s>", "<cmd>lua require('flash').treesitter()<CR>", {desc = "Flash treesitter"})
vim.keymap.set("o", "r", "<cmd>lua require('flash').remote()<CR>", {desc = "Flash remote yank / delete"})
-- use xi instead in Normal mode. Use c or S instead s in Visual mode
return {
  "folke/flash.nvim",
  lazy = true,
  vscode = true,
  ---@type Flash.Config
  opts = {
    modes = {
      char = {
        enabled = false,
      },
    },
    label = {
      uppercase = false,
    },
    jump = {
      inclusive = false,
    }
  },
}
-- Should you use flash? (YES)
-- https://www.reddit.com/r/neovim/comments/16l27rx/what_are_yalls_opinions_on_using_plugins_like/
-- https://www.reddit.com/r/neovim/comments/1aqif1r/are_you_using_any_motionenhancing_plugins/
-- По факту flash / leap и т.д это новый современный стандарт переменщения в nvim. Всего за 3 нажатия клавиш можно перместиться куда угодно совершенно без ментальных
-- усилий (даже в другой split). Если с базовыми vim моушенами мышка могла иногда обгонять, то с такими плагинами как flash у нее больше нет шансов
-- Старым ?, / пока на покой. (Разве что для поиска вне видимости буфера годятся)
