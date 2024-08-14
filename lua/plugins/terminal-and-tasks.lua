return {
  dir = "~/projects/terminal-and-tasks/",
  lazy = true,
  keys = {
    { "<C-t>",     function() require("terminal-and-tasks.terminal_tweaks").toggle_last_openned_terminal() end, mode = { "n", "t" } },
    { "<leader>r", function() require("terminal-and-tasks.telescope_tasks").tasks_picker() end },
    { "<leader>R", function() require("terminal-and-tasks.telescope_tasks").run_last_runned_task() end }
  },
  opts = {
  },
}
