return {
	"lewis6991/gitsigns.nvim",
	event = {"BufReadPost", "BufNewFile"},
	config = function()
    vim.keymap.set("n", "<leader>hr", "<cmd>Gitsigns reset_hunk<CR>", {desc = "Reset hunk"})
    vim.keymap.set("n", "<leader>hR", "<cmd>Gitsigns reset_buffer<CR>", {desc = "Reset Buffer"})
    vim.keymap.set("n", "<leader>hu", "<cmd>Gitsigns undo_stage_hunk<CR>", {desc = "Undo stage hunk"})
    vim.keymap.set("n", "<leader>hU", "<cmd>Gitsigns reset_buffer_index<CR>", {desc = "Undo buffer staging"})
    vim.keymap.set("n", "H", "<cmd>Gitsigns preview_hunk<CR>", {desc = "Preview hunk"})
    vim.keymap.set("n", "<leader>hs", "<cmd>Gitsigns stage_hunk<CR>", {desc = "Stage hunk"})
    vim.keymap.set("n", "<leader>hS", "<cmd>Gitsigns stage_buffer<CR>", {desc = "Stage Buffer"})
    vim.keymap.set("n", "<leader>hw", "<cmd>Gitsigns blame_line<CR>", {desc = "Git blame ([W]ho did this??)"})

    vim.keymap.set("n", "[h", function() require("gitsigns").nav_hunk("prev", {preview = true, navigation_message = false}) end, {desc = "Prev hunk"})
    vim.keymap.set("n", "]h", function() require("gitsigns").nav_hunk("next", {preview = true, navigation_message = false}) end, {desc = "Next hunk"})
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
