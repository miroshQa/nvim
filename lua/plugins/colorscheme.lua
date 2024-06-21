return {
	{
		"luisiacc/gruvbox-baby",
		priority = 1000,
		config = function()
			vim.g.gruvbox_baby_use_original_palette = true

			require("lualine").setup({
				options = {
					theme = "gruvbox-baby",
				},
			})
			vim.cmd.colorscheme("gruvbox-baby")
		end,
	},
}
