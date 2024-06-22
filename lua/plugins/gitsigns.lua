return {
	"lewis6991/gitsigns.nvim",
	event = "VeryLazy",
	config = function()
    vim.keymap.set("n", "<leader>hr", function() require("gitsigns").reset_hunk() end, {desc = "Reset hunk"})
    vim.keymap.set("n", "<leader>hp", function() require("gitsigns").preview_hunk() end, {desc = "Reset hunk"})
    vim.keymap.set("n", "[g", function() require("gitsigns").prev_hunk() require("gitsigns").preview_hunk() end, {desc = "Prev hunk"})
    vim.keymap.set("n", "]g", function() require("gitsigns").next_hunk() require("gitsigns").preview_hunk() end, {desc = "Next hunk"})

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
