-- https://stackoverflow.com/questions/75397223/can-i-configure-nvim-lspconfig-to-fail-silently-rather-than-print-a-warning
-- Since neovim 0.11 I probably will be able to delete these checks
local function lsp_binary_exists(server_config)
  local valid_config = server_config.config_def and
      server_config.config_def.default_config and
      type(server_config.config_def.default_config.cmd) == "table" and
      #server_config.config_def.default_config.cmd >= 1

  if not valid_config then
    return false
  end

  local binary = server_config.config_def.default_config.cmd[1]

  return vim.fn.executable(binary) == 1
end

return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPost", "BufNewFile" },
  keys = {
    { "go",         vim.lsp.buf.code_action,             mode = "n", desc = "Code Actions" },
    { "cd",         vim.lsp.buf.rename,                  mode = "n", desc = "Rename symbol (Change definition)" },
    { "gh",         "<cmd>ClangdSwitchSourceHeader<CR>", mode = "n", desc = "Goto linked file (src / header)" },
    { "<C-s>",      vim.lsp.buf.signature_help,          mode = "i", desc = "Signature help" },
    { '[d',         vim.diagnostic.goto_prev,            mode = 'n', desc = 'Go to previous [D]iagnostic message' },
    { ']d',         vim.diagnostic.goto_next,            mode = 'n', desc = 'Go to next [D]iagnostic message' },
    { "M",          vim.diagnostic.open_float,           mode = "n", desc = "Misstake hover (Open Error / Diagnostic float)" },
    { "K",          function() vim.lsp.buf.hover({border = "rounded"}) end,           mode = "n", desc = "Misstake hover (Open Error / Diagnostic float)" },
    { "<leader>lr", "<cmd>LspRestart<CR>",               mode = "n", desc = "Restart" },
    { "<leader>lf", vim.lsp.buf.format,                  mode = "n", desc = "LSP! Format my code!" },
  },
  config = function()
    local lspconfig = require("lspconfig")

    vim.diagnostic.config({
      float = { border = "rounded" },
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = " ",
          [vim.diagnostic.severity.WARN] = " ",
          [vim.diagnostic.severity.HINT] = " ",
          [vim.diagnostic.severity.INFO] = " ",
        },
      },
    })

    local servers = {}

    servers.lua_ls = {
      settings = {
        Lua = {
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME,
              "${3rd}/luv/library"
            }
          }
        }
      }
    }
    servers.clangd = {}
    servers.rust_analyzer = {}
    servers.ts_ls = {}
    servers.bashls = {}
    servers.jsonls = {}
    servers.gopls = {}
    -- type :help lspconfig-all

    for name, opts in pairs(servers) do
      local conf = lspconfig[name]
      if lsp_binary_exists(conf) then
        conf.setup(opts)
      end
    end

  end,
}
