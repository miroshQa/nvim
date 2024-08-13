local all_tasks = {
  -- THIS TABLE CONTAINS TASK CONTAINERS AS BELOW.
  -- {
  --   task_source_file_path = "",
  --   task_begin_line_number = 0,
  --   task = {},
  -- },
}

local last_runned_task = nil

local function run_task(task)
  last_runned_task = task
  vim.cmd("tabnew")
  local job_id = vim.fn.termopen(vim.o.shell)
  vim.fn.feedkeys("i", "n")
  vim.fn.chansend(job_id, {task.cmd, ""})
end

local function get_task_begin_line_number_by_name(file_with_tasks, name)
  file_with_tasks:seek("set", 0)
  local lines = file_with_tasks:lines()
  local line_number = 1
  for line in lines do
    if string.find(line, name) then
      return line_number
    end
    line_number = line_number + 1
  end
end

local function load_tasks_from_file(file_path)
  local is_success, module_with_tasks = pcall(dofile, file_path)
  if not is_success then
    vim.notify("Can't load file from " .. file_path, vim.log.levels.ERROR)
    return
  end

  local file_with_tasks = io.open(file_path, "r")

  for _, task in ipairs(module_with_tasks.tasks) do
    local task_container = {
      task_source_file_path = file_path,
      task = task,
      task_begin_line_number = get_task_begin_line_number_by_name(file_with_tasks, task.name)
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
          filename = entry.task_source_file_path,
          lnum = entry.task_begin_line_number,
        }
      end
    }),
    previewer = conf.grep_previewer({}),
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        run_task(selection.value.task)
      end)
      return true
    end,
  }):find()
end

vim.keymap.set("n", "<leader>r", tasks_picker, {desc = "Test telescope extesion"})
