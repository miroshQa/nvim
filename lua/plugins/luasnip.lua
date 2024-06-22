return {
	"L3MON4D3/LuaSnip",
	config = function()
 	local snippet_path = vim.fn.stdpath("config") .. "/snips/"
  vim.opt.rtp:append(snippet_path)

    local luasnip = require("luasnip")
    require("luasnip.loaders.from_vscode").load()
    luasnip.config.setup({ history = true, })
  end,
  keys = {
    { "<right>",   function() require("luasnip").jump(1) end,  mode = {"i", "s"}},
    { "<left>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
  },
}



