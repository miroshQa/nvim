return {
  "nvim-telescope/telescope.nvim",
  keys = {
    {"<leader>f", "<cmd>Telescope find_files<cr>", mode = "n",  desc = "Find files" },
    {"<leader><leader>", "<cmd>Telescope buffers<cr>", mode = "n",  desc = "Find buffers" },
    {"<leader>/", "<CMD>lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", mode = "n", desc = "Search for cwd"},
    {"<leader>'", "<cmd>Telescope resume<cr>", mode = "n",  desc = 'Search resume' },
    {"<leader>b", "<cmd>Telescope git_branches<cr>", mode = "n",  desc = "Search branches" },
    {"<leader>se", function () require("telescope.builtin").symbols({sources = {"emoji", "gitmoji"}}) end, mode = "n",  desc = "Search emoji" },
    {"<leader>.", "<cmd>Telescope oldfiles<cr>", mode = "n",  desc = 'Search old files ("." for repeat)' },
    {"<leader>k", "<cmd>Telescope help_tags<cr>", mode = "n",  desc = 'Search help tags' },
    {"<leader>c", "<cmd>Telescope git_bcommits<cr>", mode = "n",  desc = 'Search commits for current buffer' },
    {"<leader>C", "<cmd>Telescope git_commits<cr>", mode = "n",  desc = 'Search commits' },
    {"<leader>g", "<cmd>silent! Telescope git_status<CR>", mode = "n",  desc = 'Search edited / added files' },
    {"<leader>i", "<cmd>Telescope diagnostics<CR>", mode = "n", desc = "Search code [I]nfo (code diagnostics)"},
    {"<leader>m", "<cmd>Telescope man_pages<CR>", mode = "n", desc = "Search man pages"},
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-symbols.nvim",
    "nvim-telescope/telescope-live-grep-args.nvim" ,
    "nvim-tree/nvim-web-devicons",
    'nvim-telescope/telescope-ui-select.nvim'
  },
  config = function()
    require("telescope").setup( {
      defaults = {
        -- https://github.com/nvim-telescope/telescope.nvim/issues/3032
        preview = {
          filesize_limit = 0.5555,
        },
        file_ignore_patterns = { "%.png", "%.pdf", },
        mappings = {
          i = {
            ["<esc>"] = require("telescope.actions").close,
            ["<C-s>"] = require("telescope.actions").select_horizontal,
            ['<c-x>'] = require('telescope.actions').delete_buffer,
            ["<c-f>"] = require("telescope.actions").complete_tag,
          },
        },
      },
    })

  require("telescope").load_extension("ui-select")
  end,
}
