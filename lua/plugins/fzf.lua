return {
  "ibhagwan/fzf-lua",
  keys = {
    -- General
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
    { "gd",        function() require("fzf-lua").lsp_definitions() end,            mode = "n",          desc = "Goto Definition" },
    { "gr",        function() require("fzf-lua").lsp_references() end,             mode = "n",          desc = "Goto References" },
    { "go",        function() require("fzf-lua").lsp_code_actions() end,           mode = { "v", "n" }, desc = "Open actions-preview" },

  },
  config = function()
    require("fzf-lua").setup({
      actions = {
        -- https://github.com/ibhagwan/fzf-lua/issues/1595
        files = {
          ['enter'] = {
            fn = function(sel, o)
              require('fzf-lua').hide()
              require('fzf-lua.actions').file_edit_or_qf(sel, o)
            end,
            exec_silent = true,
          },
        },
      },
      files = {
        git_icons = false,
      },
      winopts = {
        width = 0.90,
        preview = {
          horizontal = 'right:50%',
        },
        backdrop = 100,
      },
      keymap = {
        builtin = {
          true, -- inherit all other default binds
          ["<Esc>"] = "hide",
          ["<C-d>"] = "preview-page-down",
          ["<C-u>"] = "preview-page-up",
        }
      }
    })
    require("fzf-lua").register_ui_select()
  end
}
