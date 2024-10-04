local M = {}

M.tasks = {
  {
    name = "CMAKE: Build C++ project (DEBUG)",
    builder = function()
      vim.cmd("wall")
      local task = {}
      task.cmd = {
        "cmake -B build -Wdev -DCMAKE_BUILD_TYPE=Debug",
        "cmake --build build",
      }
      return task
    end,
  },
}

return M
