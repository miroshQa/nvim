local M = {}

M.tasks = {
  {
    name = "Run mWeather",
    cmd = "cd build ; cmake .. ; make ; cd ../bin ; ./mWeather",
    env = "",
    cwd = "",
    some_func = function()
      print("You can even add you own functions because tasks configures in lua!")
    end
  },
  {
    name = "Run main.cpp",
    cmd = "g++ main.cpp -o main ; ./main"
  },
}


return M
