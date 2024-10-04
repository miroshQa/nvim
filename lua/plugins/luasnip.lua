return {
	"L3MON4D3/LuaSnip",
	config = function()

    require("luasnip").config.setup({ history = true, })


  end,

  keys = {
    -- { "<right>",   function() require("luasnip").jump(1) end,  mode = {"i", "s"}}, -- Alt + h
    -- { "<left>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } }, -- Alt + l (physically on keyboard for me)
  },
}
