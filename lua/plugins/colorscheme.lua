return {

	{
		"catppuccin/nvim",
		name = "catppuccin",
	},

	{
		"rebelot/kanagawa.nvim",
	},

	{
		"Everblush/nvim",
		name = "everblush",
	},
	{ "sainnhe/everforest" },
	{
		"luisiacc/gruvbox-baby",
    priority = 1000,
		config = function()
      vim.g.gruvbox_baby_use_original_palette = true

			require("lualine").setup({
				options = {
					-- ... your lualine config,
					theme = "gruvbox-baby",
					-- ... your lualine config,
				},
			})
			vim.cmd.colorscheme("gruvbox-baby")
		end,
	},
}
