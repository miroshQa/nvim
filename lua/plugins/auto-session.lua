vim.o.sessionoptions="buffers,curdir,help,tabpages,winsize,winpos,terminal,localoptions"

return {
  'rmagatti/auto-session',
  lazy = false,

  ---@module "auto-session"
  ---@type AutoSession.Config
  opts = {
    suppressed_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
    -- https://github.com/rmagatti/auto-session/issues/244
    session_lens = {
      load_on_setup = false,
    }
  },
}
