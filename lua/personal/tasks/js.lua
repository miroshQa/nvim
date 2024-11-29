local user = require("rittli.user")

local M = {}

M.tasks = {
  {
    name = "NODE",
    builder = user.run_cur("node"),
  },
  {
    name = "NPM. Start live server",
    builder = user.single('browser-sync start --no-notify --server --files "./**"'),
  },
  {
    name = "TYPESCRIPT: Watch mode",
    builder = user.single("tsc -p ./tsconfig.json -w"),
  }
}

return M
