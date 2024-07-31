vim.keymap.set("n", "<leader>f", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
vim.keymap.set("n", "<leader>/", "<cmd>Telescope live_grep<cr>", { desc = "Find grep in current working directory" })
vim.keymap.set("n", "<leader>;", "<cmd>Telescope resume<cr>", { desc = 'Find open last picker' })
vim.keymap.set("n", "<leader>ab", "<cmd>Telescope builtin<cr>", { desc = "Find builtin Telescope" })
vim.keymap.set("n", "<leader>an", "<cmd>Telescope notify<cr>", { desc = "Find notification" })
vim.keymap.set("n", "<leader>o", "<cmd>Telescope oldfiles<cr>", { desc = 'Find old files' })
vim.keymap.set("n", "<leader>ah", "<cmd>Telescope help_tags<cr>", { desc = 'Find help tags' })
vim.keymap.set("n", "<leader>g", function() require('telescope.builtin').git_status({path_display = {'tail'}}) end,
  { desc = 'Find edited / added files' })
vim.keymap.set("n", "<leader>b",
  function() require('telescope.builtin').buffers{path_display = {'tail'}, sort_mru = true, ignore_current_buffer = true} end,
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
