vim.keymap.del("s", "<")
vim.keymap.del("s", ">")

return {
	"L3MON4D3/LuaSnip",
	config = function()

    require("luasnip").config.setup({ history = true, })

    for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("lua/plugins/snippets/*.lua", true)) do
      loadfile(ft_path)()
    end

    vim.keymap.set("n", "<leader>us",
      function()
        for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("lua/plugins/snippets/*.lua", true)) do
          require("luasnip.loaders").reload_file(ft_path)
        end
      end,
      {desc = "Update snippets"}
    )
  end,

  keys = {
    { "<right>",   function() require("luasnip").jump(1) end,  mode = {"i", "s"}}, -- Alt + h
    { "<left>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } }, -- Alt + l (physically on keyboard for me)
  },
}
