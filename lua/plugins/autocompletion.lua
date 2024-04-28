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
	-- https://github.com/hrsh7th/nvim-cmp
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		-- Snippet engine & associated nvim-cmp source
		-- https://github.com/L3MON4D3/LuaSnip
		"L3MON4D3/LuaSnip",
		-- https://github.com/saadparwaiz1/cmp_luasnip
		"saadparwaiz1/cmp_luasnip",

		-- LSP completion capabilities
		-- https://github.com/hrsh7th/cmp-nvim-lsp
		"hrsh7th/cmp-nvim-lsp",

		-- Additional user-friendly snippets
		-- https://github.com/rafamadriz/friendly-snippets
		"rafamadriz/friendly-snippets",
		-- https://github.com/hrsh7th/cmp-buffer
		"hrsh7th/cmp-buffer",
		-- https://github.com/hrsh7th/cmp-path
		"hrsh7th/cmp-path",
		-- https://github.com/hrsh7th/cmp-cmdline
		"hrsh7th/cmp-cmdline",
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		require("luasnip.loaders.from_vscode").lazy_load()
		luasnip.config.setup({})

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
				-- Tab through suggestions or when a snippet is active, tab to the next argument
				["<Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.expand_or_locally_jumpable() then
						luasnip.expand_or_jump()
					else
						fallback()
					end
				end, { "i", "s" }),
				-- Tab backwards through suggestions or when a snippet is active, tab to the next argument
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.locally_jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { "i", "s" }),
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" }, -- lsp
				{ name = "luasnip" }, -- snippets
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
					-- Set the menu "icon" to the shorthand for each completion source.
					item.menu = menu_icon[entry.source.name]

					-- Set the fixed width of the completion menu to 60 characters.
					-- fixed_width = 20

					-- Set 'fixed_width' to false if not provided.
					fixed_width = fixed_width or false

					-- Get the completion entry text shown in the completion window.
					local content = item.abbr

					-- Set the fixed completion window width.
					if fixed_width then
						vim.o.pumwidth = fixed_width
					end

					-- Get the width of the current window.
					local win_width = vim.api.nvim_win_get_width(0)

					-- Set the max content width based on either: 'fixed_width'
					-- or a percentage of the window width, in this case 20%.
					-- We subtract 10 from 'fixed_width' to leave room for 'kind' fields.
					local max_content_width = fixed_width and fixed_width - 10 or math.floor(win_width * 0.2)

					-- Truncate the completion entry text if it's longer than the
					-- max content width. We subtract 3 from the max content width
					-- to account for the "..." that will be appended to it.
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
}
