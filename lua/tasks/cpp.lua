local M = {}

M.is_available = function() return vim.bo.filetype == "cpp" or vim.bo.filetype == "c" end

M.tasks = {
  {
    name = "Run mWeather",
    cmd = {
      "cd build",
      "cmake .. ",
      "ninja",
      "cd ../bin",
      "./mWeather",
    },
    -- env = "",
  },
  {
    name = "Build and run current cpp / c file",
    builder = function()
      vim.cmd("wa")
      local cur_file = vim.fn.expand("%")
      if vim.fn.isdirectory("build") == 0 then
        vim.fn.mkdir("build")
      end
      -- See :help fnamemodify, :help filename-modifiers
      local bin_name = vim.fn.fnamemodify(cur_file, ":t:r")
      local compiler = vim.bo.filetype == "c" and "gcc" or "g++"
      local task = {
        cmd = {
          string.format("%s %s -o build/%s", compiler, cur_file, bin_name),
          string.format("./build/%s", bin_name)
        },
      }
      return task
    end,
  }
}

return M
