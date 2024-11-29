local user = require("rittli.user")
local M = {}

M.is_available = function()
  return vim.fn.filereadable("Cargo.toml") == 1
end

M.tasks = {
  {
    name = "RUST: Cargo run",
    builder = user.single("cargo run"),
  },
}

return M
