local M = {}

-- You can define the "is_available" property for the whole module. All tasks will inherit it

local is_rust = function() return vim.fn.filereadable("Cargo.toml") == 1 end
local is_csharp = function() return #vim.fn.glob("./*.csproj", false, true) > 0 end


M.tasks = {
  {
    name = "RUST: Cargo run",
    is_available = is_rust,
    builder = function()
      vim.cmd("wall")
      return { cmd = {"cargo run"} }
    end,
  },
  {
    name = "C#: Dotnet run",
    -- You can also override the "is_available" for a specific task
    is_available = function() return vim.bo.filetype == "cs" end,
    builder = function()
      vim.cmd("wall")
      return {cmd = {"dotnet run"}}
    end,
  },
  {
    name = "C#: Dotnet build",
    is_available = is_csharp,
    builder = function()
      vim.cmd("wall")
      return {cmd = {"dotnet build"}}
    end,
  },
  {
    name = "TYPST: Launch watch mode",
    builder = function()
      vim.cmd("wall")
      local file_name = vim.fn.expand("%")
      local wezterm_new_tab_command = 'wezterm cli spawn -- bash -c "typst watch test.typ; sleep 86400"'
      local command = string.format("typst watch %s", file_name)
      return {cmd = {wezterm_new_tab_command}}
    end,
  },
  {
    name = "LATEX: Compile",
    builder = function()
      vim.cmd("wall")
      local file_name = vim.fn.expand("%")
      local command = string.format("pdflatex %s", file_name)
      return {cmd = {command}}
    end,
  },
  {
    name = "PYTHON: Run",
    builder = function(cache)
      vim.cmd("wall")
      if not cache.file_name then
        cache.file_name = vim.fn.expand("%")
      end
      return {cmd = { string.format("python %s", cache.file_name)}}
    end,
  }
}

return M

