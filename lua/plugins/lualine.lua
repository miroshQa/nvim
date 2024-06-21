local function show_macro_recording()
  local recording_register = vim.fn.reg_recording()
  if recording_register == "" then
    return ""
  else
    return "Recording @" .. recording_register
  end
end

return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  config = function()

    require("lualine").setup({
      options = {
        globalstatus = true, -- https://www.youtube.com/watch?v=jH5PNvJIa6o
        ignore_focus = {
          "dapui_watches",
          "dapui_breakpoints",
          "dapui_scopes",
          "dapui_console",
          "dapui_stacks",
          "dap-repl",
        },
      },
      sections = {
      lualine_a = {"mode", },
        lualine_c = {
          {"filename", path = 1},
          { "macro-recording", fmt = show_macro_recording},
        },
        lualine_x = {{"tabs", mode = 1, cond = function() return #vim.fn.gettabinfo() > 1 end}},
        lualine_y = {"encoding", "fileformat", "filetype" },
        lualine_z = {"progress","location" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
    })

    local lualine = require("lualine")
    vim.api.nvim_create_autocmd("RecordingEnter", {
      callback = function()
        lualine.refresh({
          place = { "statusline" },
        })
      end,
    })

    vim.api.nvim_create_autocmd("RecordingLeave", {
      callback = function()
        -- This is going to seem really weird!
        -- Instead of just calling refresh we need to wait a moment because of the nature of
        -- `vim.fn.reg_recording`. If we tell lualine to refresh right now it actually will
        -- still show a recording occuring because `vim.fn.reg_recording` hasn't emptied yet.
        -- So what we need to do is wait a tiny amount of time (in this instance 50 ms) to
        -- ensure `vim.fn.reg_recording` is purged before asking lualine to refresh.
        local timer = vim.loop.new_timer()
        timer:start(
          50,
          0,
          vim.schedule_wrap(function()
            lualine.refresh({
              place = { "statusline" },
            })
          end)
        )
      end,
    })
  end,
}
