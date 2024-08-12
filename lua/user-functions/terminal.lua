local M = {}

local openned_terminal_buffer_number = nil
local openned_terminal_window_id = nil
local last_entered_tab = nil
local tabs_list_before_close = {}


function M.toggle_last_openned_terminal()
  if openned_terminal_window_id == vim.fn.win_getid() then
    vim.api.nvim_command("hide")
    return
  end

  if vim.fn.win_gotoid(openned_terminal_window_id) == 1  then
    return
  end

  if vim.fn.bufexists(openned_terminal_buffer_number) == 0 then
    vim.api.nvim_command("au TermOpen * setlocal nonumber norelativenumber signcolumn=no")
    vim.api.nvim_command("tabnew | terminal")
    openned_terminal_window_id = vim.fn.win_getid()
    openned_terminal_buffer_number = vim.fn.bufnr('%')
    vim.api.nvim_buf_set_name(0, "MainTerminalBuffer")
  else
    vim.api.nvim_command("tab sb " .. openned_terminal_buffer_number)
    openned_terminal_window_id = vim.fn.win_getid()
  end
end

-- Default behaviour when close tab:
-- If tab is on the last position then go to the previous tab.
-- If tab is not on the last position the go to the next tab
-- Desired behaviour: Go always to the previous tab
vim.api.nvim_create_autocmd("TabEnter", {
  callback = function()
    last_entered_tab = vim.api.nvim_win_get_tabpage(0)
    tabs_list_before_close = vim.api.nvim_list_tabpages()
  end
})

vim.api.nvim_create_autocmd("TabClosed", {
  callback = function()
    if tabs_list_before_close[#tabs_list_before_close] ~= last_entered_tab then
      vim.cmd("tabp")
    end
  end
})


vim.api.nvim_create_autocmd("TermOpen", {
  callback = function()
    vim.api.nvim_command("set ft=terminal | startinsert")
    openned_terminal_buffer_number = vim.fn.bufnr('%')
    openned_terminal_window_id = vim.fn.win_getid()
  end,
})

vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
  callback = function()
    if vim.bo.filetype == "terminal" then
      vim.api.nvim_command("startinsert")
      openned_terminal_buffer_number = vim.fn.bufnr('%')
      openned_terminal_window_id = vim.fn.win_getid()
    end
  end,
})

return M
