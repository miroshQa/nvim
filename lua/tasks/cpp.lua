local M = {}

M.is_available = function() return true end

M.tasks = {
  {
    name = "Run mWeather",
    builder = function()
      local task = {}
      task.cmd = {
        "cd build",
        "cmake .. ",
        "ninja",
        "cd ../bin",
        "./mWeather",
      }
      return task
    end,
  },
  {
    name = "Build and Run current CPP or C file with Args",
    builder = function()
      vim.cmd("wa")
      local cur_file = vim.fn.expand("%")
      if vim.fn.isdirectory("build") == 0 then
        vim.fn.mkdir("build")
      end
      -- See :help fnamemodify, :help filename-modifiers
      local bin_name = vim.fn.fnamemodify(cur_file, ":t:r")
      local compiler = vim.bo.filetype == "c" and "gcc" or "g++"
      local args = vim.fn.input({prompt = "Enter exe arguments: "})
      local task = {
        cmd = {
          string.format("%s %s -o build/%s", compiler, cur_file, bin_name),
          string.format("./build/%s %s", bin_name, args)
        },
      }
      return task
    end,
  },
}

return M
