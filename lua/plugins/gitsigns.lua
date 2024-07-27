return {
	"lewis6991/gitsigns.nvim",
	event = "BufReadPost",
	config = function()
    vim.keymap.set("n", "<leader>gH", function() require("gitsigns").reset_hunk() end, {desc = "Reset hunk"})
    vim.keymap.set("n", "<leader>gh", function() require("gitsigns").preview_hunk() end, {desc = "Preview hunk"})
    vim.keymap.set("n", "<leader>gb", function() require("gitsigns").preview_hunk() end, {desc = "Preview hunk"})
    vim.keymap.set("n", "[h", function() require("gitsigns").prev_hunk() require("gitsigns").preview_hunk() end, {desc = "Prev hunk"})
    vim.keymap.set("n", "]h", function() require("gitsigns").next_hunk() require("gitsigns").preview_hunk() end, {desc = "Next hunk"})

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
