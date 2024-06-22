return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "rafamadriz/friendly-snippets",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-emoji"
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      require("luasnip.loaders.from_vscode").lazy_load()
      luasnip.config.setup({ history = true })

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
          ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<C-k>"] = cmp.mapping.select_prev_item(),
          ["<C-u>"] = cmp.mapping.scroll_docs(-4),
          ["<C-d>"] = cmp.mapping.scroll_docs(4),
          ["<CR>"] = cmp.mapping.confirm({
            select = true,
          }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp", max_item_count = 15, },
          { name = 'luasnip' },
          { name = "buffer" },
          { name = "path" }, -- type ./ to activate
          {name = "emoji"}, -- type : to activate
        }),

        window = {
          -- Add borders to completions popups
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
      })

    end,
  },



  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      {
        "rafamadriz/friendly-snippets",
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
        end,
  },
      {
        "nvim-cmp",
        dependencies = {
          "saadparwaiz1/cmp_luasnip",
        },
        opts = function(_, opts)
          opts.snippet = {
            expand = function(args)
              require("luasnip").lsp_expand(args.body)
            end,
          }
        end,
      },
    },
    opts = {
      history = true,
      delete_check_events = "TextChanged",
    },

    keys = {
      { "<right>",   function() require("luasnip").jump(1) end,  mode = {"i", "s"}},
      { "<left>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
    },
  },
}



