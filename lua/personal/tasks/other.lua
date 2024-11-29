local M = {}
local user = require("rittli.user")

M.tasks = {
  {
    name = "PYTHON: Run",
    builder = function(cache)
      vim.cmd("wall")
      if not cache.file_name then
        cache.file_name = vim.fn.expand("%")
      end
      return {
        cmd = {
          "\x0C",
          string.format("python %s", cache.file_name),
        },
      }
    end,
  },
  {
    name = "NASM: Compile and run",
    builder = function()
      vim.cmd("wall")
      local file_name = vim.fn.expand("%")
      local bin_name = vim.fn.fnamemodify(file_name, ":t:r")
      local task = {}
      task.cmd = {
        string.format("nasm -f elf64 %s -o %s.o", file_name, bin_name),
        string.format("ld -o %s %s.o", bin_name, bin_name),
        string.format("./%s", bin_name)
      }
      return task
    end
  },
  {
    name = "Run shell script",
    builder = user.run_cur(""),
  }

}

return M

