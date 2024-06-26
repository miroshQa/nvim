-- Самое балдежное что это не добавляет новые кеймапы, а расширяет возможность существующих нативных f, t, F, T, /, ?
-- So it is basically / and ? on steroids
-- По факту это все те же / и ? но они очень помогают когда есть много одних и тех же слов. + Фича с treesitter тоже топчег
-- Сторонники leap nvim заявляют что у них преимущество в том что всегда нужно ввести только два символа и переход произойдет если больше совпадений нет
-- Но по факту переход происходит только в 50 процентов случаев (потому что совпадения есть почти всегда), что очень выбивает тебя потока, лучше уж всегда знать что нужно нажать на label чтобы перейти
-- К тому же путь расширения функциональности ? и / не добавляется новые кеймапы и не портит существующие как это было бы с кеймапами на s / S в leap. 
-- С ? / все также можно искать как и раньше нажимая CR по окончанию, но если много слов теперь есть функциональнасть удобно прыгнуть к конкретному 
-- не нажимая n / N тысячу раз + можно вообще прыгнуть в другой сплит.
--
--
-- Короче, в итоге я решил что лучше это на отдельный кеймап вообще поместить, а конкретно на s. Потому что тогда вообще получается что ? а также n и N как таковые вообще не нужны. Так что лучше конкретно одну клавишу для flash выделить, а / и ? пуская остаюстя самостоятельными
return {
    "folke/flash.nvim",
    event = "VeryLazy",
    vscode = true,
    ---@type Flash.Config
    opts = {
      modes = {
      char = {
        enabled = false,
      }
    }
  },
  keys = {
    { "<leader>s", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash Treesitter" }, -- Use xi or cl instead of s
  },
}


-- https://www.reddit.com/r/neovim/comments/16l27rx/what_are_yalls_opinions_on_using_plugins_like/
-- https://www.youtube.com/live/eJ3XV-3uoug?t=666s Takeaway: Flash nvim is better than leap nvim. 
