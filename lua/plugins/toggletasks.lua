vim.keymap.set("n", "<leader>r", "<cmd>Telescope toggletasks spawn<CR>", {desc = "Run task in terminal"})
vim.keymap.set("n", "<leader>ts", "<cmd>Telescope toggletasks select<CR>", {desc = "Select running task"})
vim.keymap.set("n", "<leader>te", "<cmd>Telescope toggletasks edit<CR>", {desc = "Edit tasks"})


return {
  'jedrzejboczar/toggletasks.nvim',
  cmd = "Telescope toggletasks",
  dependencies = {
    'nvim-lua/plenary.nvim',
    'akinsho/toggleterm.nvim',
    'nvim-telescope/telescope.nvim',
  },
  config = function()
    require('telescope').load_extension('toggletasks')
    require('toggletasks').setup {
      tasks = {
        {
          name = "List all files in directory",
          cmd = "ls",
        },
        {
          name = "CPP: Build and run mWeather",
          cmd = "cd build ; cmake .. ; make ; cd ../bin ; ./mWeather"
        }
      },
      telescope = {
        spawn = {
          open_single = true,  -- auto-open terminal window when spawning a single task
          show_running = false, -- include already running tasks in picker candidates
          -- Replaces default select_* actions to spawn task (and change toggleterm
          -- direction for select horiz/vert/tab)
          mappings = {
            select_float = '<C-f>',
            spawn_smart = '<C-a>',  -- all if no entries selected, else use multi-select
            spawn_all = '<M-a>',    -- all visible entries
            spawn_selected = nil,   -- entries selected via multi-select (default <tab>)
          },
        },
        -- Replaces default select_* actions to open task terminal (and change toggleterm
        -- direction for select horiz/vert/tab)
        select = {
          mappings = {
            select_float = '<C-f>',
            open_smart = '<C-a>',
            open_all = '<M-a>',
            open_selected = nil,
            kill_smart = '<C-q>',
            kill_all = '<M-q>',
            kill_selected = nil,
            respawn_smart = '<C-s>',
            respawn_all = '<M-s>',
            respawn_selected = nil,
          },
        },
      },
    }
  end,
}
