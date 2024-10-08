local M = {}

M.is_available = function()
  return vim.fn.filereadable("Cargo.toml") == 1
end

M.tasks = {
  {
    name = "RUST: Cargo run",
    builder = function()
      vim.cmd("wall")
      return { cmd = { "cargo run" } }
    end,
  },
}

return M
