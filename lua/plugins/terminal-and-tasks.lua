vim.keymap.set({"n", "t"}, "<C-t>", function() require("terminal-and-tasks.terminal_tweaks").toggle_last_openned_terminal() end, {desc = "Toggle terminal"})
vim.keymap.set("n", "<leader>r", function() require("terminal-and-tasks.telescope_tasks").tasks_picker() end, {desc = "Test telescope extesion"})
vim.keymap.set("n", "<leader>R", function() require("terminal-and-tasks.telescope_tasks").run_last_runned_task() end, {desc = "Test telescope extesion"})
vim.keymap.set("n", "<leader>,", function() require("terminal-and-tasks") end)
return {
  dir = "~/projects/terminal-and-tasks/",
}
