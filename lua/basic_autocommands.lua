
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

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)

    if client and client.server_capabilities.documentHighlightProvider then
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = event.buf,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = event.buf,
        callback = vim.lsp.buf.clear_references,
      })

    end
  end,
})

-- Disable certain features when opening large files
local big_file = vim.api.nvim_create_augroup('BigFile', { clear = true })
vim.filetype.add({
  pattern = {
    ['.*'] = {
      function(path, buf)
        return vim.bo[buf] and vim.bo[buf].filetype ~= 'bigfile' and path and vim.fn.getfsize(path) > 1024 * 500 and 'bigfile' or nil -- bigger than 500KB
      end,
    },
  },
})

vim.api.nvim_create_autocmd({ 'FileType' }, {
  group = big_file,
  pattern = 'bigfile',
  callback = function(ev)
    -- vim.cmd('syntax off')
    vim.cmd("set nowrap")
    vim.cmd("set noundofile")
    vim.opt_local.foldmethod = 'manual'
    vim.opt_local.spell = false
    vim.schedule(function()
      local ok, ft = pcall(vim.filetype.match, { buf = ev.buf })
      if ok then
        vim.bo[ev.buf].syntax = ft or ''
      end
    end)
  end,
})
