local M = {}


M.tasks = {
  {
    name = "dotnet run",
    is_available = function() return vim.bo.filetype == "cs" end,
    builder = function()
      vim.cmd("wa")
      return {cmd = {"dotnet run"}}
    end
  },
  {
    name = "run node",
    builder = function() 
      vim.cmd("wa")
      local file = vim.fn.fnamemodify(vim.fn.expand("%"), ":t")
      return {cmd = {string.format("node %s", file)}}
    end,
  }
}

return M
