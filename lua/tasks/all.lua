local M = {}

M.tasks = {
  {
    name = "List all the files",
    cmd = "ls -la",
    env = "",
    cwd = "",
  },
  {
    name = "Run mWeather",
    cmd = "cd build ; cmake .. ; make ; cd ../bin ; ./mWeather",
    env = "",
    cwd = "",
    some_func = function()
      print("Hello world")
    end
  }
}


return M
