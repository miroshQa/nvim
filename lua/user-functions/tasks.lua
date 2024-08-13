local tasks = {
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
  }
}


local function run_task(task)
  vim.cmd("tabnew")
  local job_id = vim.fn.termopen("bash")
  vim.fn.chansend(job_id, task.cmd)
end

local function draw_task(task)

end

vim.keymap.set("n", "<leader>m", function() run_task(tasks[1]) end, {desc = "Tasks test"})

local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local previewers = require "telescope.previewers"
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

local example = function(opts)
  opts = opts or {}
  pickers.new(opts, {
    prompt_title = "SelectTaskToLaunch",
    finder = finders.new_table({
      results = tasks,
      entry_maker = function(entry)
        return {
          value = entry,
          display = entry.name,
          ordinal = entry.name,
        }
      end
    }),
    previewer = previewers.new_buffer_previewer {
      title = "TaskPreview",
      define_preview = function (self, entry, status)
        require('telescope.previewers.utils').highlighter(self.state.bufnr, "lua")
        vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, {entry.value.name , "local value =  2"})
      end
    },
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        run_task(selection.value)
      end)
      return true
    end,
  }):find()
end


vim.keymap.set("n", "<leader>st", example, {desc = "Test telescope extesion"})

