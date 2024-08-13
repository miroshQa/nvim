local all_tasks = {
  -- {
  --   task_source_path = "",
  --   task = {}
  -- },
}

local function run_task(task)
  vim.cmd("tabnew")
  local job_id = vim.fn.termopen("bash")
  vim.fn.chansend(job_id, task.cmd)
end

local function load_tasks_from_file(file_path)
  local is_success, module_with_tasks = pcall(dofile, file_path)
  if not is_success then
    print("Can't load file from " .. file_path)
    return
  end

  for _, task in ipairs(module_with_tasks.tasks) do
    local task_container = {
      task_source_path = file_path,
      task = task,
    }
    table.insert(all_tasks, task_container)
  end
end

local function init_tasks()
  for _, file_path in ipairs(vim.api.nvim_get_runtime_file("lua/tasks/*.lua", true)) do
    load_tasks_from_file(file_path)
  end
end

init_tasks()

local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local previewers = require "telescope.previewers"
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local tasks_picker = function(opts)
  opts = opts or {}
  pickers.new(opts, {
    prompt_title = "SelectTaskToLaunch",
    finder = finders.new_table({
      results = all_tasks,
      entry_maker = function(entry)
        return {
          value = entry,
          display = entry.task.name,
          ordinal = entry.task.name,
        }
      end
    }),
    previewer = previewers.new_buffer_previewer {
      title = "TaskPreview",
      define_preview = function (self, entry, status)
        require('telescope.previewers.utils').highlighter(self.state.bufnr, "lua")
        local task_container = entry.value
        local lines = vim.split(vim.inspect(task_container.task), "\n")
        vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, lines)
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

vim.keymap.set("n", "<leader>st", tasks_picker, {desc = "Test telescope extesion"})
