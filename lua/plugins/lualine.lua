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
    local hydra_statusline = require("hydra.statusline");

    require("lualine").setup({
      options = {
        ignore_focus = {
          "dapui_watches",
          "dapui_breakpoints",
          "dapui_scopes",
          "dapui_console",
          "dapui_stacks",
          "dap-repl",
        },
        refresh = {
          statusline = 250,
        }
      },
      sections = {
      lualine_a = {
          {
            'mode',
            fmt = function(str)
              if hydra_statusline.is_active() == true then
                return hydra_statusline.get_name()
              end
              return str
            end,

            color = function(tb)
              if hydra_statusline.is_active() == true then
                return {bg = hydra_statusline.get_color()}
              end
              return tb
            end,
          }
        },
        lualine_c = {
          {"filename", path = 1},
          {
            "macro-recording",
            fmt = show_macro_recording,
          },
        },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
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
