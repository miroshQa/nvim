return {
  dir = "~/projects/terminal-and-tasks/",
  lazy = true,
  keys = {
    { "<C-t>",     function() require("terminal-and-tasks.terminal_tweaks").toggle_last_openned_terminal() end, mode = { "n", "t" } },
    {"<Esc><Esc>", "<C-\\><C-n>", mode = "t"},
    { "<leader>r", function() require("terminal-and-tasks.tasks.telescope_tasks").tasks_picker() end },
    { "<leader>R", function() require("terminal-and-tasks.tasks.telescope_tasks").run_last_runned_task() end },
    { "<leader><leader>", function() require('telescope.builtin').buffers({path_display = {'tail'}, sort_mru = true, ignore_current_buffer = true}) end}

  },
  opts = {
  },
}
