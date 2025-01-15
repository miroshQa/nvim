return {
  "ibhagwan/fzf-lua",
  branch = "hide",
  keys = {
    { "<leader>f", function() require('fzf-lua').files() end },
    { "<leader>'", function() require("fzf-lua").resume() end },
    { "<leader>k", function() require("fzf-lua").help_tags() end },
    { "<leader>.", function() require("fzf-lua").oldfiles() end },
    { "<leader>/", function() require("fzf-lua").live_grep() end },
    { "<leader>g", function() require("fzf-lua").git_status() end },
    { "<leader>b", function() require("fzf-lua").buffers() end },

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
      files = {
        git_icons = false,
      },
      winopts = {
        row = 0.5,
        width = 0.8,
        height = 0.8,
        preview = {
          horizontal = 'right:50%',
          scrollbar = false,
        },
        backdrop = 100,
      },
      keymap = {
        builtin = {
          true,
          ["<C-d>"] = "preview-page-down",
          ["<C-u>"] = "preview-page-up",
        }
      }
    })
    require("fzf-lua").register_ui_select()
  end
}
