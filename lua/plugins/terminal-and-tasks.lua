return {
  dir = "~/projects/terminal-and-tasks/",
  lazy = true,
  keys = {
    { "<C-t>",     function() require("terminal-and-tasks.terminal_tweaks").toggle_last_openned_terminal() end, mode = { "n", "t" }},
    {"<Esc><Esc>", "<C-\\><C-n>", mode = "t"},
    { "<leader>r", function() require("terminal-and-tasks.tasks.telescope_tasks").run_last_runned_task() end, desc = "Rerun the last task or pick the new" },
    { "<leader>R", function() require("terminal-and-tasks.tasks.telescope_tasks").tasks_picker() end, desc = "Pick the task" },
    -- { "<leader><leader>", function() require('telescope.builtin').buffers({path_display = {'tail'}, sort_mru = true, ignore_current_buffer = true}) end}
  },
  config = function()

    local function open_buf_in_float_win(bufnr)
      local curved = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }

      local width = math.ceil(math.min(vim.o.columns, math.max(80, vim.o.columns - 20)))
      local height = math.ceil(math.min(vim.o.lines, math.max(20, vim.o.lines - 10)))

      local row = math.ceil(vim.o.lines - height) * 0.5 - 1
      local col = math.ceil(vim.o.columns - width) * 0.5 - 1


      local win_settings = {
        row = row,
        col = col,
        relative = "editor",
        width = width,
        height = height,
        border = curved,
      }
      vim.api.nvim_open_win(bufnr, true, win_settings)
    end

    local function open_entry_in_float_win()
      local action_state = require "telescope.actions.state"
      local entry = action_state.get_selected_entry()
      local buf = vim.fn.bufadd(entry.filename)
      vim.fn.bufload(buf)
      open_buf_in_float_win(buf)
    end


    require("terminal-and-tasks").setup({create_window_for_terminal = open_buf_in_float_win})
    local improved_buffer_picker = function()
      require("telescope.builtin").buffers({
        path_display = {'tail'},
        sort_mru = true,
        ignore_current_buffer = true,
        attach_mappings = function(_, map)
          map({"i", "n"}, "<C-f>", open_entry_in_float_win)
          return true
        end})
    end

    vim.keymap.set("n", "<leader><leader>", improved_buffer_picker)

  end,

}
