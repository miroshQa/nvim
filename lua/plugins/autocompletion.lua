return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-emoji"
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
          ["<CR>"] = cmp.mapping.confirm({ -- Select (Не париться с C-s или C-i. Это удобнее но есть случаи когда не очень. Тем более <CR> - это дефолт везде (Chrome, pwsh, ...);
            select = true,
          }), -- Короче я потестил M-s и если и есть улучшение то оно вообще не заметно. Иногда только неудобнее. В общем не стоить заниматься этой дичью. Лишний оверхед. Тем более <CR> везде по дефолту. Не стоит создавать лишние шорткаты в памяти. Тем более я очень быстро печатаю и использую дополнение редко. Тем более <CR> расположен более чем удобно. По фатку это левосторонний CAPS который я так часто использую)
          -- Перфекционизм меня до психушки доведет...
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

