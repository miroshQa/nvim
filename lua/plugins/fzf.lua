return {
  "ibhagwan/fzf-lua",
  keys = {
    { "<leader>f", function() require('fzf-lua').files() end },
    { "<leader>'", function() require("fzf-lua").resume() end },
    { "<leader>k", function() require("fzf-lua").help_tags() end },
    { "<leader>.", function() require("fzf-lua").oldfiles() end },
    { "<leader>/", function() require("fzf-lua").live_grep() end },
    { "<leader>g", function() require("fzf-lua").git_status() end },
    -- { "<leader>b", function() require("fzf-lua").buffers() end },
    { "<leader>m", function() require("fzf-lua").manpages() end },
    { "<leader>z", function() require("fzf-lua").zoxide() end },
    { "<leader>c", function() require("fzf-lua").git_bcommits() end },
    { "<leader>b", function() require("fzf-lua").git_branches() end },
    { "<leader>C", function() require("fzf-lua").git_commits() end },

    -- LSP
    { "<leader>s", function() require("fzf-lua").lsp_document_symbols() end,       mode = "n" },
    { "<leader>S", function() require("fzf-lua").lsp_live_workspace_symbols() end, mode = "n" },
    { "<leader>i", function() require("fzf-lua").lsp_document_diagnostics() end, mode = "n" },
    { "<leader>I", function() require("fzf-lua").lsp_workspace_diagnostics() end, mode = "n" },
    { "gd",        function() require("fzf-lua").lsp_definitions() end,            mode = "n" },
    { "gr",        function() require("fzf-lua").lsp_references() end,             mode = "n" },
    { "go",        function() require("fzf-lua").lsp_code_actions() end,           mode = { "v", "n" } },

  },
  config = function()
    require("fzf-lua").setup({
      "hide",
      fzf_opts = { ['--cycle'] = true },
      files = {
        git_icons = false,
      },
      winopts = {
        row = 0.5,
        width = 0.8,
        height = 0.8,
        title_flags = false,
        preview = {
          horizontal = 'right:50%',
          scrollbar = false,
        },
        backdrop = 100,
      },
      keymap = {
        builtin = {
          true,
          ["<esc>"] = "hide",
          ["<C-d>"] = "preview-page-down",
          ["<C-u>"] = "preview-page-up",
        }
      }
    })
    require("fzf-lua").register_ui_select()
  end
}
