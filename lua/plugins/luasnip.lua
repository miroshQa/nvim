return {
	"L3MON4D3/LuaSnip",
	config = function()

    local luasnip = require("luasnip")
    luasnip.config.setup({ history = true, })
  end,
  keys = {
    { "<right>",   function() require("luasnip").jump(1) end,  mode = {"i", "s"}},
    { "<left>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
  },
}



