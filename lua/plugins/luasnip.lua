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
    { "<right>",   function() require("luasnip").jump(1) end,  mode = {"i", "s"}},
    { "<left>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
    -- Таб плох тем что в инсерт моде нельзя прыгать вперед после того как отошел от области сниппета
  },
}
