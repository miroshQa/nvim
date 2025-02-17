local M = {}

vim.snippet.add("at", "/** @type {${1:Type}} */\n$0", {ft = "lua"})
vim.snippet.add("ai", "/** @implements {${1:Interface}} */\n$0", {ft = "lua"})
vim.snippet.add("ad", "/** @typedef {${0:Typename}} */\n$0", {ft = "lua"})

return M
