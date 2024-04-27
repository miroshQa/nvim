return {

	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
      
			vim.cmd([[colorscheme catppuccin-frappe]])
      vim.opt.termguicolors = true
      vim.opt.background = "dark"
		end,
	},

	{
		"rebelot/kanagawa.nvim",
	},

	{
		"Everblush/nvim",
		name = "everblush",
	},
}
