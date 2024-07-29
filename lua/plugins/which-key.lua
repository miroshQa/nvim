return  {
    'folke/which-key.nvim',
    event = "VeryLazy",
    version = "3.x.x",
    config = function()
      require('which-key').setup({
        notify = false,
        triggers = { "<auto>", mode = "niotc" },
    })

      require('which-key').add {
        { "<leader>d", group = "Debug" },
        { "<leader>o", group = "Overseer", icon = {icon = "", color = "orange"} },
        { "<leader>h", group = "Hunks", icon = {icon = "", color = "red"} }, -- NvimWebDeviconsHiTest
        { "<leader>a", group = "AI" },
        { "<leader>f", group = "Find" },
        { "<leader>g", group = "Git" },
        { "<leader>l", group = "Lsp", icon = {icon = "", color = "blue"} },
        { "<leader>u", group = "Ui/Update" },
      }
    end,
}
