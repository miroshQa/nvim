local M = {}

M.tasks = {
  {
    name = "Cargo run",
    builder = function()
      vim.cmd("wa")
      return { cmd = {"cargo run"} }
    end,
  },
}

return M
