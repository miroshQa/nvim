return { -- Adds git related signs to the gutter, as well as utilities for managing changes
	"lewis6991/gitsigns.nvim",
	event = "VeryLazy",
	config = function()
		require("gitsigns").setup({
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		})
	end,
}
