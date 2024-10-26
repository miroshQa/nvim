local M = {}

M.tasks = {
  {
    name = "GO: RUN File",
    builder = function()
      vim.cmd("wall")
      local file_name = vim.fn.expand("%")
      return {
        cmd = {
          string.format("go run %s", file_name),
        },
      }
    end,
  },
}

return M
