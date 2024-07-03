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



ls.add_snippets("lua", {
  s("key",
    fmt(
      [[vim.keymap.set("{}", "{}", {})]],
      { i(1, "mode"), i(2, "keymap"), i(3, "action")}
    )
  ),

  s("set",
    fmt(
      [[
      require("{}").setup({{
        {}
      }})]],
      {i(1), i(2)}
    )
  ),

  s("conf",
    fmt(
      [[
      config = function()
        {}
      end,
      ]],
      {i(1)}
    )
  ),
})
