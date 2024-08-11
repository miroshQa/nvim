M = {}

local openned_terminal_buffer_number = nil
local openned_terminal_window_id = nil


local function openTerminal()
  if vim.fn.bufexists(openned_terminal_buffer_number) ~= 1 then
    vim.api.nvim_command("au TermOpen * setlocal nonumber norelativenumber signcolumn=no")
    -- vim.api.nvim_command("sp | winc J | res 10 | te")
    vim.api.nvim_command("tabnew | terminal")
    openned_terminal_window_id = vim.fn.win_getid()
    openned_terminal_buffer_number = vim.fn.bufnr('%')
  elseif vim.fn.win_gotoid(openned_terminal_window_id) ~= 1 then
    vim.api.nvim_command("sb " .. openned_terminal_buffer_number .. "| winc J | res 10")
    openned_terminal_window_id = vim.fn.win_getid()
  end
  vim.api.nvim_command("startinsert")
end

local function hideTerminal()
  if vim.fn.win_gotoid(openned_terminal_window_id) == 1 then
    vim.api.nvim_command("hide")
  end
end

function M.ToggleTerminal()
  if vim.fn.win_gotoid(openned_terminal_window_id) == 1 then
    hideTerminal()
  else
    openTerminal()
  end
end

return M
