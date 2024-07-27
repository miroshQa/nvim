-- Overriding vim.notify with fancy notify if fancy notify exists


local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("vim-options")
require("basic_keymaps")
require("basic_autocommands")
require("lazy").setup({
  spec = {
    {import = "plugins"},
  },
  checker = {
    notify = false,
  },
  change_detection = {
    enabled = true,
    notify = false
  },
	performance = {
		rtp = {
			disabled_plugins = {
				-- "matchit",
				-- "matchparen",
				"netrwPlugin",
				"gzip",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
}
)
