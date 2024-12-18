return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    -- General
    {"<leader>f", function() require('fzf-lua').files() end},
    {"<leader>'", function() require("fzf-lua").resume() end},
    {"<leader>k", function() require("fzf-lua").help_tags() end},
    {"<leader>.", function() require("fzf-lua").oldfiles() end},
    {"<leader>/", function() require("fzf-lua").live_grep() end},
    {"<leader>g", function() require("fzf-lua").git_status() end},

    -- LSP
    {"<leader>j", function() require("fzf-lua").lsp_document_symbols() end, mode = "n", desc = 'Jump to symbol (search)'},
    {"<leader>J", function() require("fzf-lua").lsp_live_workspace_symbols() end, mode = "n", desc = "Jump to symbol in workspace (search)"} ,
    {"gd", function() require("fzf-lua").lsp_definitions() end, mode = "n", desc = "Goto Definition"},
    {"gr", function() require("fzf-lua").lsp_references() end, mode = "n", desc = "Goto References"},
    {"go", function() require("fzf-lua").lsp_code_actions() end, mode = { "v", "n" }, desc = "Open actions-preview"},

  },
  config = function()
    -- calling `setup` is optional for customization
    require("fzf-lua").setup({
      winopts = {
        preview = {
          delay = 0,
        },
        backdrop = 100,
      },
      keymap = {

        builtin = {
          true, -- inherit all other default binds
          ["<Esc>"] = "hide",
        }
      }
    })
    require("fzf-lua").register_ui_select()
  end
}
