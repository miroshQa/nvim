return { -- Fuzzy Finder (files, lsp, etc)
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

    pcall(require('telescope').load_extension, 'fzf')
    require("telescope").load_extension("ui-select")
    require("telescope").load_extension("dap")

		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
		vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Find by Grep" })
		vim.keymap.set("n", "<leader>fb", builtin.builtin, { desc = "Find builtin Telescope" })
		vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Find Diagnostics" })
		vim.keymap.set("n", "<leader>f.", builtin.oldfiles, { desc = 'Find Recent Files ("." for repeat)' })
		vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = 'Find resume' })
		vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = 'Find help tags' })

    local ignore_symbols = {"variable", "string", "boolean", "object", "field", "enummember", "property"}
		vim.keymap.set("n", "<leader>fs", function() builtin.lsp_document_symbols({ignore_symbols = ignore_symbols}) end, { desc = "Find symbols" })
		vim.keymap.set("n", "<leader>fS", function() builtin.lsp_workspace_symbols({ignore_symbols = ignore_symbols}) end , { desc = "Find symbols in workspace" })
    -- ctrl + l To choose from query type (variables, classess, functions, etc)

    vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, {desc = "Lsp actions"});
		vim.keymap.set(
			"n",
			"<leader><leader>",
			"<cmd>lua require('telescope.builtin').buffers{path_display = {'tail'}, sort_mru = true, ignore_current_buffer = true}<CR>",
			{ desc = "Find open buffers" }
		)
	end,
}
