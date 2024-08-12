
-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.cmd([[autocmd FileType * set formatoptions-=ro]]) -- disable new line autocomment


vim.api.nvim_create_autocmd({"InsertLeave", "TextChanged" }, {
  callback = function()
    if #vim.api.nvim_buf_get_name(0) ~= 0 and vim.bo.buflisted then
      vim.cmd "silent update"
    end
  end,
})

-- https://github.com/Alexis12119/nvim-config/blob/main/lua/core/autocommands.lua
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- General Settings
local general = augroup("General", { clear = true })

autocmd("VimEnter", {
  callback = function(data)
    -- buffer is a directory
    local directory = vim.fn.isdirectory(data.file) == 1

    -- change to the directory
    if directory then
      vim.cmd.cd(data.file)
      vim.cmd("lua require('neo-tree')")
      vim.cmd("Neotree")
      vim.cmd("Telescope find_files")
    end
  end,
  group = general,
  desc = "Open Telescope when it's a Directory",
})
