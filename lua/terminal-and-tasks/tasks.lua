require("terminal-and-tasks.terminal_tweaks")

local M = {}
local all_tasks = {
  -- THIS TABLE CONTAINS TASK CONTAINERS AS BELOW
  -- [name] = { -- this 'name' key duplucate the task name
  --   task_source_file_path = "",
  --   task_begin_line_number = 0,
  --   task = {
  --        name = "",
  --        env = "",
  --        cmd = "",
  --        cwd = "",
  --      },
  -- },
}
local last_runned_task = nil

-- We have to launch this function before load tasks frome file again (before resoruce)
local function clear_tasks_loaded_from_file(file_path)
  for key, value in pairs(all_tasks) do
    if value.task_source_file_path == file_path then
      all_tasks[key] = nil
    end
  end
end

local function collect_tasks()
  local tasks = {}
  for _, value in pairs(all_tasks) do
    table.insert(tasks, value)
  end
  return tasks
end


local function run_task(task)
  last_runned_task = task
  vim.cmd("tabnew")
  local job_id = vim.fn.termopen(vim.o.shell, {detach = true})
  vim.fn.chansend(job_id, {task.cmd, ""})
end

local function find_task_begin_line_number_by_name(file_with_tasks, name)
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
    return false
  end

  local file_with_tasks = io.open(file_path, "r")

  for _, task in ipairs(module_with_tasks.tasks) do
    local task_container = {
      task_source_file_path = file_path,
      task = task,
      task_begin_line_number = find_task_begin_line_number_by_name(file_with_tasks, task.name)
    }
    all_tasks[task.name] = task_container
  end
  return true
end

local function init_tasks()
  for _, file_path in ipairs(vim.api.nvim_get_runtime_file("lua/tasks/*.lua", true)) do
    local is_success = load_tasks_from_file(file_path)
    if not is_success then
      vim.print("Can't load file from " .. file_path, vim.log.levels.ERROR)
    end
  end
end

init_tasks()


vim.api.nvim_create_autocmd("BufLeave", {
  pattern = {vim.fn.stdpath("config") .. "/lua/tasks/*.lua"},
  group = vim.api.nvim_create_augroup("TasksReloader", {clear = true}),
  callback = function(data)
    clear_tasks_loaded_from_file(data.match)
    local is_success = load_tasks_from_file(data.match)
    if not is_success then
      vim.print(string.format("Unable to reload tasks. FILE: %s", data.match))
    else
      vim.print(string.format("Reload success. FILE: %s", data.match))
    end
  end
})

local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local previewers = require "telescope.previewers"
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
M.tasks_picker = function(opts)
  opts = opts or {}
  pickers.new(opts, {
    prompt_title = "SelectTaskToLaunch",
    finder = finders.new_table({
      results = collect_tasks(),
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
        vim.fn.feedkeys("i", "n")
      end)
      return true
    end,
  }):find()
end

M.run_last_runned_task = function(opts)
  if last_runned_task then
    run_task(last_runned_task)
  else
    M.tasks_picker(opts)
  end
end


return M
