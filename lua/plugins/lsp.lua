return {
  "neovim/nvim-lspconfig",
  event = {"BufReadPost", "BufNewFile"},
  dependencies = {
    {"williamboman/mason.nvim", opts = {}},
    {"williamboman/mason-lspconfig.nvim", opts = {}},
  },
  keys = {
    {"go", vim.lsp.buf.code_action, mode = "n", desc = "Code Actions"},
    {"cd", vim.lsp.buf.rename, mode = "n", desc = "Rename symbol (Change definition)"},
    {"gh", "<cmd>ClangdSwitchSourceHeader<CR>", mode = "n", desc = "Goto linked file (src / header)"},
    {"<C-s>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature help"},
    {'[d', vim.diagnostic.goto_prev, mode = 'n', desc = 'Go to previous [D]iagnostic message'},
    {']d', vim.diagnostic.goto_next, mode = 'n', desc = 'Go to next [D]iagnostic message'},
    {"M", vim.diagnostic.open_float, mode = "n", desc = "Misstake hover (Open Error / Diagnostic float)"},
    {"<leader>lr", "<cmd>LspRestart<CR>", mode = "n", desc = "Restart"},
    {"<leader>lf", vim.lsp.buf.format, mode = "n", desc = "LSP! Format my code!"},
  },
  config = function()
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
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

    require("mason")
    require("mason-lspconfig").setup({ ensure_installed = {"lua_ls"} })

    require("mason-lspconfig").setup_handlers({
      function(server_name)
        local opts = {}
        opts.capabilities = capabilities
        require("lspconfig")[server_name].setup(opts)
      end,
    })
  end,
}
