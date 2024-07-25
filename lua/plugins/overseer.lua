vim.keymap.set("n", "<leader>or", "<cmd>OverseerRun<CR>", {desc = "Run overseer"})


return {
  'stevearc/overseer.nvim',
  cmd = "OverseerRun",
  config = function()
    require("overseer").setup({
      templates = { "builtin", "user.cpp_build" },
      strategy = {
        "toggleterm",
        -- load your default shell before starting the task
        use_shell = true,
        -- overwrite the default toggleterm "direction" parameter
        direction = "tab",
        -- have the toggleterm window close and delete the terminal buffer
        -- automatically after the task exits
        close_on_exit = false,
        -- have the toggleterm window close without deleting the terminal buffer
        -- automatically after the task exits
        -- can be "never, "success", or "always". "success" will close the window
        -- only if the exit code is 0.
        quit_on_exit = "never",
        -- open the toggleterm window when a task starts
        open_on_start = true,
        -- mirrors the toggleterm "hidden" parameter, and keeps the task from
        -- being rendered in the toggleable window
        hidden = false,
      },
    })
    -- https://vi.stackexchange.com/questions/17816/solved-ish-neovim-dont-close-terminal-buffer-after-process-exit
    vim.cmd([[
        augroup TerminalSettings
            autocmd!
            autocmd TermClose * setlocal | lua vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-\\><C-n>", true, false, true), "n", true)
        augroup END
    ]])

  end,
}
