vim.keymap.set('',  '<Esc>', "<ESC>:noh<CR>:lua require('notify').dismiss()<CR>", {silent = true})
-- The main purpose of this plugin for me is to replace default nvim messages when you have to press <CR> to continue editing
-- And by the way command line pop up completion menu with borders is also very nice
-- It also adds search labels for / and ?, *, #, n N, , so I can delete hlslens
-- That is such a amazing plugin!!! I should't never delete it!

vim.api.nvim_create_autocmd("RecordingEnter", {
  callback = function()
    local msg = string.format("Register:  %s", vim.fn.reg_recording())
    _MACRO_RECORDING_STATUS = true
    vim.notify(msg, vim.log.levels.INFO, {
      title = "Macro Recording",
      keep = function() return _MACRO_RECORDING_STATUS end,
    })
  end,
  group = vim.api.nvim_create_augroup("NoiceMacroNotfication", {clear = true})
})

vim.api.nvim_create_autocmd("RecordingLeave", {
  callback = function()
    _MACRO_RECORDING_STATUS = false
    vim.notify("Success!", vim.log.levels.INFO, {
      title = "Macro Recording End",
      timeout = 2000,
    })
  end,
  group = vim.api.nvim_create_augroup("NoiceMacroNotficationDismiss", {clear = true})
})

return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    "MunifTanjim/nui.nvim",
    -- OPTIONAL:
    --   `nvim-notify` is only needed, if you want to use the notification view.
    --   If not available, we use `mini` as the fallback
    "rcarriga/nvim-notify",
  },
  config = function()
    require("noice").setup({
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        lsp_doc_border = true, -- add a border to hover docs and signature help
      },
    })
  end,
}

