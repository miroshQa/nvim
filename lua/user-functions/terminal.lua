local M = {}

local openned_terminal_buffer_number = nil
local openned_terminal_window_id = nil


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
  else
    vim.api.nvim_command("tab sb " .. openned_terminal_buffer_number)
    openned_terminal_window_id = vim.fn.win_getid()
  end
end


vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup("InsertAndId", { clear = true }),
  callback = function()
      vim.api.nvim_command("set ft=terminal | startinsert")
      openned_terminal_buffer_number = vim.fn.bufnr('%')
      openned_terminal_window_id = vim.fn.win_getid()
  end,
})

vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
  group = vim.api.nvim_create_augroup("ToggleLastTerminal", { clear = true }),
  callback = function()
    if vim.bo.filetype == "terminal" then
      vim.api.nvim_command("startinsert")
      openned_terminal_buffer_number = vim.fn.bufnr('%')
      openned_terminal_window_id = vim.fn.win_getid()
    end
  end,
})



return M
