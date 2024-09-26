for _, n in ipairs({1, 2, 3, 4, 5}) do
  vim.keymap.set({"n", "t"}, string.format("<C-%s>", n), string.format("<cmd>silent! tabn%s<CR>", n))
end


return {
  dir = "~/projects/rittli.nvim",
  -- "miroshQa/rittli.nvim",
  -- lazy = true,
  keys = {
    { "<C-t>",     function() require("rittli.conveniences.terminal_tweaks").toggle_last_openned_terminal() end, mode = { "n", "t" }},
    {"<Esc><Esc>", "<C-\\><C-n>", mode = "t"},
    { "<leader>r", function() require("rittli.core.telescope").tasks_picker() end, desc = "Pick the task" },
    { "<leader><leader>", function() require('telescope.builtin').buffers({path_display = {'tail'}, sort_mru = true, ignore_current_buffer = true}) end}
  },
  config = function()
    require("rittli").setup({})
  end

}
