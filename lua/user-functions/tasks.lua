local all_tasks = {
  -- THIS TABLE CONTAINS TASK CONTAINERS AS BELOW. THIS ALSO ENTRY FOR TELESCOPE
  -- {
  --   path = "",
  --   task = {},
  --   lnum = 0,
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
    vim.notify("Can't load file from " .. file_path, vim.log.levels.ERROR)
    return
  end

  for _, task in ipairs(module_with_tasks.tasks) do
    local task_container = {
      path = file_path,
      task = task,
      -- lnum = 2,
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
    -- previewer = conf.file_previewer({}),
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr, map)
      -- MAPPINGS TO ADD
      -- 1. Ctrl + r (Reuse task as template - creates task duplicate in local tasks directory (cwd/.tasks)
      -- 2. Ctrl + e (Edit task. Open  file for selected task and allows to edit. Reload this file on buffer leaving and sent notification "Reloaded") 
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        run_task(selection.value.task)
      end)
      return true
    end,
  }):find()
end

vim.keymap.set("n", "<leader>st", tasks_picker, {desc = "Test telescope extesion"})
