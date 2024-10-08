local M = {}


M.is_available = function() return #vim.fn.glob("./*.csproj", false, true) > 0 end

M.tasks = {
  {
    name = "C#: Dotnet run",
    builder = function()
      vim.cmd("wall")
      return {cmd = {"dotnet run"}}
    end,
  },
  {
    name = "C#: Dotnet build",
    builder = function()
      vim.cmd("wall")
      return {cmd = {"dotnet build"}}
    end,
  },
}

return M
