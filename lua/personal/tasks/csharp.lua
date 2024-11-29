local user = require("rittli.user")
local M = {}


M.is_available = function() return #vim.fn.glob("./*.csproj", false, true) > 0 end

M.tasks = {
  {
    name = "C#: Dotnet run",
    builder = user.single("dotnet run"),
  },
  {
    name = "C#: Dotnet build",
    builder = user.single("dotnet build -c Release /nologo /clp:NoSummary"),
  },
}

return M
