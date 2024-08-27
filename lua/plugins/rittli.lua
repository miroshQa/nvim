for _, n in ipairs({1, 2, 3, 4, 5}) do
  vim.keymap.set({"n", "t"}, string.format("<C-%s>", n), string.format("<cmd>silent! tabn%s<CR>", n))
end


return {
  dir = "~/projects/rittli.nvim",
  lazy = true,
  keys = {
    { "<C-t>",     function() require("rittli.terminal_tweaks").toggle_last_openned_terminal() end, mode = { "n", "t" }},
    {"<Esc><Esc>", "<C-\\><C-n>", mode = "t"},
    { "<leader>r", function() require("rittli.tasks.telescope").run_last_runned_task() end, desc = "Rerun the last task or pick the new" },
    { "<leader>R", function() require("rittli.tasks.telescope").tasks_picker() end, desc = "Pick the task" },
    { "<leader><leader>", function() require('telescope.builtin').buffers({path_display = {'tail'}, sort_mru = true, ignore_current_buffer = true}) end}
  },
  opts = { }
}
