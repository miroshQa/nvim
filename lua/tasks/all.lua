local M = {}


M.tasks = {
  {
    name = "dotnet run",
    cmd = {"dotnet run"},
    is_available = function() return vim.bo.filetype == "cs" end,
  }
}

return M
