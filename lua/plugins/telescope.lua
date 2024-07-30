vim.keymap.set("n", "<leader>f", "<cmd>Telescope find_files<cr>", { desc = "Telescope Find files" })
vim.keymap.set("n", "<leader>/", "<cmd>Telescope live_grep<cr>", { desc = "Telescope Grep in current working directory" })
vim.keymap.set("n", "<leader>;", "<cmd>Telescope resume<cr>", { desc = 'Open last picker' })
-- vim.keymap.set("n", "<leader>fc", "<cmd>Telescope commands<cr>", { desc = "Find commands" })
-- vim.keymap.set("n", "<leader>fb", "<cmd>Telescope builtin<cr>", { desc = "Find builtin Telescope" })
vim.keymap.set("n", "<leader>un", "<cmd>Telescope notify<cr>", { desc = "Find notification" })
vim.keymap.set("n", "<leader>.", "<cmd>Telescope oldfiles<cr>", { desc = 'Find Recent Files ("." for repeat)' })
-- vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = 'Find help tags' })
vim.keymap.set("n", "<leader>g", "<cmd>lua require('telescope.builtin').git_status({path_display = {'tail'}})<cr>",
  { desc = 'Git Status Files Picker (Telescope)' })
vim.keymap.set("n", "<leader>b",
  "<cmd>lua require('telescope.builtin').buffers{path_display = {'tail'}, sort_mru = true, ignore_current_buffer = true}<CR>",
  { desc = "Find open buffers" })

return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-ui-select.nvim" },
    { "nvim-tree/nvim-web-devicons" },
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build =
      "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
    },
  },
  config = function()
    require("telescope").setup(
      {
        defaults = {
          file_ignore_patterns = { "%.png", "%.pdf", },

          mappings = {
            i = {
              ["<esc>"] = require("telescope.actions").close,
              ["<C-s>"] = require("telescope.actions").select_horizontal,
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
  end,
}
