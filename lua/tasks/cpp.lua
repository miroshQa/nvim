local M = {}


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
    name = "Run main.cpp",
    cmd = {"g++ main.cpp -o main", "./main"},
  },
  {
    name = "Build and run current cpp / c file",
    builder = function()
      local cur_file = vim.fn.expand("%")
      -- See :help fnamemodify, :help filename-modifiers
      local bin_name = vim.fn.fnamemodify(cur_file, ":t:r")
      local compiler = vim.bo.filetype == "c" and "gcc" or "g++"
      local task = {
        cmd = {
          string.format("%s %s -o %s", compiler, cur_file, bin_name),
          string.format("./%s", bin_name)
        },
      }
      return task
    end,
  }
}

return M
