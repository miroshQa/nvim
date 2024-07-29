-- Windows / Tabs Navigation
vim.keymap.set('n', '<left>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<right>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<down>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<up>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
vim.keymap.set("n", "[t", "<cmd>tabp<CR>", {desc = "Go to prev tab"})
vim.keymap.set("n", "]t", "<cmd>tabn<CR>", {desc = "Go to next tab"})
vim.keymap.set("n", "<tab>", "<cmd>tabn<CR>")
vim.keymap.set("n", "<S-tab>", "<cmd>tabp<CR>")
vim.keymap.set("n", "<leader>Q", "<cmd>quitall!<CR>", {desc = "Force quit all (Be careful!)"})
vim.keymap.set("n", "<leader>q", "<cmd>quit<CR>", {desc = "Close current buffer"})

-- Improved motions
vim.keymap.set("v", "J", ":m '>+1<CR>gv==kgvo<esc>=kgvo", { desc = "move highlighted text down", silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv==jgvo<esc>=jgvo", { desc = "move highlighted text up", silent = true })
vim.keymap.set({"n", "x", "o"}, 'gh', '^')
vim.keymap.set({"n", "x", "o"}, 'gl', '$')
vim.keymap.set('v', '<', '<gv', { noremap = true })
vim.keymap.set('v', '>', '>gv', { noremap = true })
vim.keymap.set("n", "g.", "<cmd>b#<CR>", {desc = "Go to previous buffer (. - most recent)"})
vim.keymap.set("n", "+", "ggVG=<C-o>", {desc = "Autoindent all text in buffer"})
vim.keymap.set("x", "R", ":s##<left>", {desc = "Start replacement in selected range"})

-- Quickfix list
vim.keymap.set("n", "<C-p>", "<cmd>cprev<CR>", {desc = "Go to prev quickfixlist entry"})
vim.keymap.set("n", "<C-n>", "<cmd>cnext<CR>", {desc = "Go to next quickfixlist entry"})

vim.keymap.set("n", "<leader>ul", "<cmd>Lazy<CR>", {desc = "Open Lazy Ui"})
vim.keymap.set("n", "<leader>uh", "<cmd>checkhealth<CR>", {desc = "Run editor checkhealth"})

vim.keymap.set("i", "<esc>", "<esc><cmd>write<CR>", {silent = true, noremap = true, desc = "Autowrite"})

-- For snippets
vim.keymap.del("s", "<")
vim.keymap.del("s", ">")

vim.keymap.set("i", "<up>", "")
vim.keymap.set("i", "<down>", "")
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Fix kitty Enter key
vim.api.nvim_set_keymap("n", "<kEnter>", "<Enter>", {})
vim.api.nvim_set_keymap("i", "<kEnter>", "<Enter>", {})
vim.api.nvim_set_keymap("c", "<kEnter>", "<Enter>", {})

if vim.g.neovide then
  local map = vim.keymap
  map.set({ "n", "v" }, "<C-+>", "<cmd>lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1<CR>")
  map.set({ "n", "v" }, "<C-->", "<cmd>lua vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1<CR>")
  map.set({ "n", "v" }, "<C-0>", "<cmd>lua vim.g.neovide_scale_factor = 1<CR>")
end

local diagnostics_active = true
Toggle_diagnostics = function()
  diagnostics_active = not diagnostics_active
  if diagnostics_active then
    vim.api.nvim_echo({ { "Show diagnostics" } }, false, {})
    vim.diagnostic.enable()
  else
    vim.api.nvim_echo({ { "Disable diagnostics" } }, false, {})
    vim.diagnostic.enable(false)
  end
end

vim.api.nvim_set_keymap( 'n', '<Leader>ud', '<Cmd>lua Toggle_diagnostics()<CR>', {silent=true, noremap=true})



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

local function changeSelected(edit_mode)
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

vim.keymap.set("v", "<C-r>", function() changeSelected(false) end) -- Replace selected
vim.keymap.set("v", "<C-right>", function() changeSelected(true) end) -- Edit selected (C-right equal to C-e because of my keymaps in the OS)
-- very convinient to combine with Ctrl + f and Ctrl + c to return after

