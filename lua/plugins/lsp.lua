return {
  "neovim/nvim-lspconfig",
  event = {"BufReadPost", "BufNewFile"},
  dependencies = {
    "artemave/workspace-diagnostics.nvim",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
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

    -- 1. help lsp-config 2. /config<CR> (To watch info about server configuration)
    local servers = {
      lua_ls = {},
    }

    require("mason")
    require("mason-lspconfig").setup({ ensure_installed = vim.tbl_keys(servers or {}) })

    require("mason-lspconfig").setup_handlers({
      function(server_name)
        local server = servers[server_name] or {}
        server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
        server.on_attach = function(client, bufnr)
          require("workspace-diagnostics").populate_workspace_diagnostics(client, bufnr)
        end
        require("lspconfig")[server_name].setup(server)
      end,
    })
  end,
}
