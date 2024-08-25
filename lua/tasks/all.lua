local M = {}


M.tasks = {
  {
    name = "dotnet run",
    is_available = function() return vim.bo.filetype == "cs" end,
    builder = function()
      vim.cmd("wa")
      return {cmd = {"dotnet run"}}
    end
  }
}

return M
