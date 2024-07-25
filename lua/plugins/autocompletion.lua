return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter", -- significantly increase startup time
    dependencies = {
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-emoji",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = {
          completeopt = "menu,menuone,noinsert",
        },
        mapping = cmp.mapping.preset.insert({
          ["<down>"] = cmp.mapping.select_next_item(),
          ["<up>"] = cmp.mapping.select_prev_item(),
          ["<C-u>"] = cmp.mapping.scroll_docs(-4),
          ["<C-d>"] = cmp.mapping.scroll_docs(4),
          ["<CR>"] = cmp.mapping.confirm({select = true}),
          -- https://github.com/hrsh7th/nvim-cmp/issues/1507
          ["<C-g>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c"}),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp"},
          { name = 'luasnip' },
          { name = "buffer" },
          { name = "path" }, -- type ./ to activate
          {name = "emoji"}, -- type : to activate
        }),

        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
      })
    end,
  },
}

