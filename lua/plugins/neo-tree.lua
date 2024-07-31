vim.keymap.set("n", "<leader>e", function() require('neo-tree') vim.cmd('Neotree toggle reveal') end, { desc = "Toggle file explorer" })

return {
  "nvim-neo-tree/neo-tree.nvim",
  cmd = {"Neotree"},
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()

    require("neo-tree").setup({
      hijack_netrw_behavior = "open_current",
      popup_border_style = "rounded",
      filesystem = {
        filtered_items = {
          visible = false,
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_hidden = false,
        },
      },

      window = {
        position = "current",
        mappings = {
          ["/"] = false,
          ["<space>"] = false,
          ["?"] = false,
          ["f"] = false,
          ["t"] = false,
          ["D"] = false,
          ["g?"] = "show_help",
          ["q"] = false,
          ["P"] = { "toggle_preview", config = { use_float = false, use_image_nvim = true } },
          ["<esc>"] = false,
          ["#"] = false,
          ["<"] = false,
          [">"] = false,
          ["s"] = false,
          ["Y"] = function(state)
            local node = state.tree:get_node()
            local filepath = node:get_id()
            vim.fn.setreg('*', filepath)
            vim.notify("Copied absolute path: " .. filepath)
          end,
        },
      },

    }
    )
  end,
}
