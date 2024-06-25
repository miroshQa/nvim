return {
	"L3MON4D3/LuaSnip",
	config = function()
    local ls = require "luasnip"
    local s = ls.snippet
    local t = ls.text_node
    local i = ls.insert_node
    local extras = require("luasnip.extras")
    local rep = extras.rep
    local fmt = require("luasnip.extras.fmt").fmt
    local c = ls.choice_node
    local f = ls.function_node
    local d = ls.dynamic_node
    local sn = ls.snippet_node
    ls.config.setup({ history = true, })

    ls.add_snippets("cs", {
    })


  end,
  keys = {
    { "<right>",   function() require("luasnip").jump(1) end,  mode = {"i", "s"}},
    { "<left>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
    -- Таб плох тем что в инсерт моде нельзя прыгать вперед после того как отошел от области сниппета
  },
}
