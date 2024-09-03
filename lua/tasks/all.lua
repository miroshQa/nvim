local M = {}


M.tasks = {
  {
    name = "run application",
    builder = function()
      return {cmd = {"node backend/app.js"}}
    end,
  },
  {
    name = "Dotnet run",
    builder = function()
      vim.cmd("wall");
      return {cmd = {"dotnet run"}}
    end,
  }
}

return M
