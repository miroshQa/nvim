local user = require("rittli.user")
local M = {}

M.tasks = {
  {
    name = "GO: RUN File",
    builder = user.run_cur("go run"),
  },
}

return M
