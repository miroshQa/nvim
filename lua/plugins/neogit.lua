return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",
    "nvim-telescope/telescope.nvim", -- optional
  },
  commit = "b9def142fe44ba62afceb6b07fa83e384fbde86b",
  config = function ()
    vim.keymap.set("n", "<leader>gg", "<cmd>Neogit<CR>", {desc = "Neogit open"})
    require("neogit").setup({
      mappings = {
        finder = {
          ["<esc>"] = "NOP",
        }
      }
    })
  end
}
