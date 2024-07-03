return {
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-ui-select.nvim" },
		{ "nvim-tree/nvim-web-devicons" },
    "nvim-telescope/telescope-dap.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
    },
	},
	config = function()
		require("telescope").setup({
			defaults = {
        file_ignore_patterns = {
          "%.png",
          "%.pdf",
        },

				mappings = {
					i = {
						["<esc>"] = require("telescope.actions").close,
            ["<left>"] = require("telescope.actions").select_horizontal, -- ctrl + h
            ["<right>"] = require("telescope.actions").complete_tag, -- Ctrl + l
					},
				},

			},

			pickers = {
				colorscheme = {
					enable_preview = true,
				},
			},

			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
			},
		})

    local is_success, _ = pcall(require('telescope').load_extension, 'fzf')
    if not is_success then
      print("Telescope native is not installed")
    end
    require("telescope").load_extension("ui-select")
    require("telescope").load_extension("dap")

		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
		vim.keymap.set("n", "<leader>fw", builtin.live_grep, { desc = "Find Word (Using ripgrep)" })
		vim.keymap.set("n", "<leader>fb", builtin.builtin, { desc = "Find builtin Telescope" })
		vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Find Diagnostics" })
		vim.keymap.set("n", "<leader>f.", builtin.oldfiles, { desc = 'Find Recent Files ("." for repeat)' })
		vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = 'Find resume' })
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = 'Find help tags' })
		vim.keymap.set("n", "<leader>gs", function() builtin.git_status({path_display = {"tail"}}) end, { desc = 'Git status (using telescope)' })

    local ignore_symbols = {"variable", "string", "boolean", "object", "field", "enummember", "property", "array"}
		vim.keymap.set("n", "<leader>fs", function() builtin.lsp_document_symbols({ignore_symbols = ignore_symbols}) end, { desc = "Find symbols" })
		vim.keymap.set("n", "<leader>fS", function() builtin.lsp_workspace_symbols({ignore_symbols = ignore_symbols}) end , { desc = "Find symbols in workspace" })
    vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, {desc = "Lsp actions"});

		vim.keymap.set(
			"n",
			"<leader><leader>",
			"<cmd>lua require('telescope.builtin').buffers{path_display = {'tail'}, sort_mru = true, ignore_current_buffer = true}<CR>",
			{ desc = "Find open buffers" }
		)
	end,
}
