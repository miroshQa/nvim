local M = {}

M.tasks = {
  {
    name = "NODE",
    builder = function()
      vim.cmd("wall")
      local file_name = vim.fn.expand("%")
      return {
        cmd = {
          string.format("node %s", file_name),
        },
      }
    end,
  },
  {
    name = "NPM. Start live server",
    builder = function()
      vim.cmd("wall")
      return {
        cmd = {
          'browser-sync start --no-notify --server --files "./**"'
        },
      }
    end,
  },
  {
    name = "TYPESCRIPT: Watch mode",
    builder = function()
      vim.cmd("wall")
      return {
        cmd = {
          "tsc -p ./tsconfig.json -w",
        },
      }
    end,
  }
}

return M
