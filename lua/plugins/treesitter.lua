return {
  "nvim-treesitter/nvim-treesitter",
  event = "BufReadPost",
  build = ":TSUpdate",
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "cpp",
        "python",
        "json",
        "bash",
        "c",
        "html",
        "lua",
        "markdown",
        "vim",
        "vimdoc",
        "go",
        "c_sharp",
        "javascript",
        "typescript"
      },
      auto_install = true,
      highlight = {
        enable = true,
      },
      indent = { enable = true, disable = { "ruby" } },
   }
    )
  end,

}
