return {
  "L3MON4D3/LuaSnip",
  config = function()
    require("luasnip").config.setup({ history = true })
  end,

  keys = {
    {
      "<C-n>",
      function()
        require("luasnip").jump(1)
      end,
      mode = { "i", "s" },
    }, -- Alt + h
    {
      "<C-p>",
      function()
        require("luasnip").jump(-1)
      end,
      mode = { "i", "s" },
    }, -- Alt + l (physically on keyboard for me)
  },
}
