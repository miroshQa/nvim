return {
  "j-hui/fidget.nvim",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    notification = { -- NOTE: you're missing this outer table
      window = {
        winblend = 0, -- NOTE: it's winblend, not blend
      },
    },
  },
}
