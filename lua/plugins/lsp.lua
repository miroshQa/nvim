--
-- if we extract require from function it will break lazyloading (require('telescope.builtin').lsp_definitions - WRONG!)
vim.keymap.set("n", "gd", function() require('telescope.builtin').lsp_definitions() end, {desc = "Goto Definition"})
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {desc = "[G]oto [D]eclaration"})
vim.keymap.set("n", "gi", function() require('telescope.builtin').lsp_implementations() end, {desc = "Goto Implementation"})
vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, {desc = "Goto Type Definition"})
vim.keymap.set("n", "gr", function() require('telescope.builtin').lsp_references({fname_width = 100}) end, {desc = "Goto References"})
vim.keymap.set("n", "cd", vim.lsp.buf.rename, {desc = "Rename symbol (Change definition)"})
vim.keymap.set("n", "go", "<cmd>ClangdSwitchSourceHeader<Cr>", {desc = "Goto linked file (src / header)"})

vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set("n", "M", vim.diagnostic.open_float, {desc = "Misstake hover (Open Error / Diagnostic float)"})
vim.keymap.set("n", "K", vim.lsp.buf.hover, {desc = "Hover Signature / Documentation"})

local adequate_symbols = {"function", "class", "struct", "method", "enum", "interface", "type"}
vim.keymap.set("n", "<leader>w", "<cmd>Telescope diagnostics<cr>", { desc = "Find Workspace Diagnostics" })
vim.keymap.set("n", "<leader>s", function() require('telescope.builtin').lsp_document_symbols({symbols = adequate_symbols}) end, { desc = 'Find symbols'})
vim.keymap.set("n", "<leader>S", function() require('telescope.builtin').lsp_workspace_symbols({symbols = adequate_symbols}) end, { desc = "Find symbols in workspace" })
vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, {desc = "Lsp actions"})
vim.keymap.set("n", "<leader>ua", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, {desc = "Toggle inlay_hints (Annotations)"})
vim.keymap.set("n", "<leader>um", "<cmd>Mason<CR>", {desc = "Open Mason"})
vim.keymap.set("n", "<leader>li", "<cmd>LspInfo<CR>", {desc = "Info"})
vim.keymap.set("n", "<leader>lr", "<cmd>LspRestart<CR>", {desc = "Restart"})


return {
  "neovim/nvim-lspconfig",
  -- https://www.reddit.com/r/neovim/comments/1bk4sru/when_to_use_the_bufreadpost_event/
  event = {"BufReadPost", "BufNewFile"},
  dependencies = {
    -- "artemave/workspace-diagnostics.nvim",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    { "j-hui/fidget.nvim", opts = {} },
    { "folke/neodev.nvim", opts = {} },
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

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
      callback = function(event)

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        -- require("workspace-diagnostics").populate_workspace_diagnostics(client, event.buf)

        if client and client.server_capabilities.documentHighlightProvider then
          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            buffer = event.buf,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            buffer = event.buf,
            callback = vim.lsp.buf.clear_references,
          })

        end
      end,
    })

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

    -- 1. help lsp-config 2. /config<CR> (To watch info about server configuration)
    local servers = {
      emmet_language_server = { },
      cssls = {},
      lemminx = {},
      marksman = {},
      lua_ls = {},
      jsonls = {},
      pyright = {},
      tsserver = {},
      rust_analyzer = {
        cargo = {
          allFeatures = true,
        }
      },
      clangd = {},
      csharp_ls = {},
      yamlls = {},
      gopls = {},
      bashls = {},
      taplo = {},
      neocmake = {},
    }

    require("mason").setup()
    require("mason-lspconfig").setup({ ensure_installed = vim.tbl_keys(servers or {}) })

    require("mason-lspconfig").setup_handlers({
      function(server_name)
        local server = servers[server_name] or {}
        server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
        server.capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true
        require("lspconfig")[server_name].setup(server)
      end,
    })
  end,
}
