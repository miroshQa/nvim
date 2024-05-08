local format_fn = function(entry, item)
  item.menu = ""
  local fixed_width = 40
  local content = item.abbr

  if fixed_width then
    vim.o.pumwidth = fixed_width
  end

  local win_width = vim.api.nvim_win_get_width(0)

  local max_content_width = fixed_width and fixed_width - 10 or math.floor(win_width * 0.2)

  if #content > max_content_width then
    item.abbr = vim.fn.strcharpart(content, 0, max_content_width - 3) .. "..."
  else
    item.abbr = content .. (" "):rep(max_content_width - #content)
  end

  return item
end

-- Auto-completion / Snippets
return {
  {
    -- https://github.com/hrsh7th/nvim-cmp
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "rafamadriz/friendly-snippets",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
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
          ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
          ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
          ["<C-u>"] = cmp.mapping.scroll_docs(-4), -- scroll backward
          ["<C-d>"] = cmp.mapping.scroll_docs(4), -- scroll forward
          ["<C-Space>"] = cmp.mapping.complete({}), -- show completion suggestions
          ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          }),
        }),
        sources = cmp.config.sources({
          {
            name = "nvim_lsp",
            max_item_count = 15,
            --entry_filter = function(entry)
            --  return require("cmp").lsp.CompletionItemKind.Snippet ~= entry:get_kind()
            --end,
          },              -- lsp
          { name = 'luasnip' },
          { name = "buffer" }, -- text within current buffer
          { name = "path" }, -- file system paths
        }),

        window = {
          -- Add borders to completions popups
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        formatting = {
          fields = { "abbr", "menu", "kind" },
          format = function(entry, item)
            -- Define menu shorthand for different completion sources.
            local menu_icon = {
              nvim_lsp = "",
              nvim_lua = "",
              luasnip = "",
              buffer = "",
              path = "",
            }
            item.menu = menu_icon[entry.source.name]
            fixed_width = fixed_width or false

            local content = item.abbr

            if fixed_width then
              vim.o.pumwidth = fixed_width
            end

            local win_width = vim.api.nvim_win_get_width(0)

            local max_content_width = fixed_width and fixed_width - 10 or math.floor(win_width * 0.2)

            if #content > max_content_width then
              item.abbr = vim.fn.strcharpart(content, 0, max_content_width - 3) .. "..."
            else
              item.abbr = content .. (" "):rep(max_content_width - #content)
            end
            return item
          end,
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


    -- stylua: ignore
    keys = {
      {
        "<tab>",
        function()
          return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
        end,
        expr = true,
        silent = true,
        mode = "i",
      },
      { "<tab>",   function() require("luasnip").jump(1) end,  mode = "s" },
      { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
    },
  },
}


