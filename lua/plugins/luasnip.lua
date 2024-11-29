return {
  "L3MON4D3/LuaSnip",
  dependencies = { "rafamadriz/friendly-snippets" },
  config = function()
    require("luasnip").config.setup({ history = true })
    require("luasnip.loaders.from_vscode").lazy_load()
  end,
  keys = {
    {
      "<c-n>",
      function()
        require("luasnip").jump(1)
      end,
      mode = { "i", "s" },
    },
    {
      "<c-p>",
      function()
        require("luasnip").jump(-1)
      end,
      mode = { "i", "s" },
    },
  },
}
