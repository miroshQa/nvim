local M = {}

--- Smart delete lines; don't clutter clipboard with whitespace lines
function M.smart_line_delete()
    local line = vim.api.nvim_get_current_line()
    if line:match("^%s*$") then
        return '"_dd'
    end
    return "dd"
end

local diagnostics_active = true
function M.toggle_diagnostic()
  diagnostics_active = not diagnostics_active
  if diagnostics_active then
    vim.api.nvim_echo({ { "Show diagnostics" } }, false, {})
    vim.diagnostic.enable()
  else
    vim.api.nvim_echo({ { "Disable diagnostics" } }, false, {})
    vim.diagnostic.enable(false)
  end
end

-- https://stackoverflow.com/questions/676600/vim-search-and-replace-selected-text
table.unpack = table.unpack or unpack
local function get_visual()
  local _, ls, cs = table.unpack(vim.fn.getpos('v'))
  local _, le, ce = table.unpack(vim.fn.getpos('.'))
  return vim.api.nvim_buf_get_text(0, ls-1, cs-1, le-1, ce, {})
end

local function escapeLt(old)
  local result = ""
  for char in old:gmatch(".") do
    if char == "<" then
      result = result .. "<lt>"
    else
      result = result .. char
    end
  end
  return result
end

function M.changeSelected(edit_mode)
  local pattern = table.concat(get_visual())
  pattern = vim.fn.substitute(vim.fn.escape(pattern, "^$.*\\~[]"),'\n', '\\n', 'g')
  -- https://github.com/neovim/pynvim/issues/127
  -- :help keycodes
  pattern = escapeLt(pattern)
  local input = ""
  if edit_mode then
    input = '<Esc>:%s#' .. pattern .. "#" .. pattern .. "#g<Left><Left>"
  else
    input = '<Esc>:%s#' .. pattern .. "##g<Left><Left>"
  end
  vim.api.nvim_input(input)
end

return M
