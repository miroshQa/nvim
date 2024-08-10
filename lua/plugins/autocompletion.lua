local kind_icons = {
  Text = "",
  Method = "󰆧",
  Function = "󰊕",
  Constructor = "",
  Field = "󰇽",
  Variable = "󰂡",
  Class = "󰠱",
  Interface = "",
  Module = "",
  Property = "󰜢",
  Unit = "",
  Value = "󰎠",
  Enum = "",
  Keyword = "󰌋",
  Snippet = "",
  Color = "󰏘",
  File = "󰈙",
  Reference = "",
  Folder = "󰉋",
  EnumMember = "",
  Constant = "󰏿",
  Struct = "",
  Event = "",
  Operator = "󰆕",
  TypeParameter = "󰅲",
}



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
        formatting = {
          format = function(entry, vim_item)
            vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)
            vim_item.menu = ({
              buffer = "",
              nvim_lsp = "",
              luasnip = "",
              nvim_lua = "",
              latex_symbolc = ""
            })[entry.source.name]
            return vim_item
          end,
          expandable_indicator = false,
          fields = {"abbr", "kind", "menu"},
        },
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
          ["<CR>"] = cmp.mapping.confirm({select = true}),
          ["<C-;>"] = cmp.mapping.confirm({select = true}),
          ["<C-g>"] = function()
            if cmp.visible() then
              cmp.abort()
            else
              cmp.complete()
            end
          end,
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


