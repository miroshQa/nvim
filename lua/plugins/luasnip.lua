return {
  "L3MON4D3/LuaSnip",
  config = function()
    require("luasnip").config.setup({ history = true })
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
