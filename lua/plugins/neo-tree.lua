return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
		"3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
	},
	config = function()
		require("neo-tree").setup({
			hijack_netrw_behavior = "disabled",
			filesystem = {
				filtered_items = {
					visible = false, -- when true, they will just be displayed differently than normal items
					hide_dotfiles = false,
					hide_gitignored = false,
					hide_hidden = false,
				},
			},

			window = {
        position = "current",
				mappings = {
					["<bs>"] = "navigate_up",
					["."] = "set_root",
					["H"] = "toggle_hidden",
					["/"] = false,
          ["<esc>"] = false, -- close preview or floating neo-tree window
				},
			},

		}
    )
		vim.keymap.set(
			"n",
			"<leader>e",
			"<cmd>Neotree toggle reveal<CR>",
			{ desc = "Open file explorer" }
		)
	end,
}
