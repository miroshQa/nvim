return {
  name = "g++ build and runn current file",
  builder = function()
    -- Full path to current file (see :help expand())
    local file = vim.fn.expand("%:p")
    -- https://github.com/stevearc/overseer.nvim/issues/146
    return {
      cmd = {string.format("g++ %s -o a ; ./a ", file)},
      args = { file },
      -- components = { { "on_output_quickfix", open = true }, "default" },
    }
  end,
  condition = {
    filetype = { "cpp" },
  },
}
