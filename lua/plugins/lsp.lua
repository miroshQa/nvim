-- about dependencies and require
-- we use dependencies only when we have not file for this plugin in plugin folder
-- because plugins in dependencies downloads and LOads (loads when target plugin requires), when require only load plugin
-- https://lazy.folke.io/developers

return {
  "neovim/nvim-lspconfig",
-- https://www.reddit.com/r/neovim/comments/1bk4sru/when_to_use_the_bufreadpost_event/
  event = {"BufReadPost", "BufNewFile"},
  dependencies = {
    "artemave/workspace-diagnostics.nvim",
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

    vim.keymap.set("n", "<leader>li", "<cmd>LspInfo<CR>", {desc = "Info"})
    vim.keymap.set("n", "<leader>lr", "<cmd>LspRestart<CR>", {desc = "Restart"})

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
      callback = function(event)

        vim.keymap.set("n", "gd", "<cmd>lua require('telescope.builtin').lsp_definitions()<CR>", {desc = "Goto Definition"})
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {desc = "[G]oto [D]eclaration"})
        vim.keymap.set("n", "gi", "<cmd>lua require('telescope.builtin').lsp_implementations()<CR>", {desc = "Goto Implementation"})
        vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, {desc = "Goto Type Definition"})
        vim.keymap.set("n", "gr", "<cmd>lua require('telescope.builtin').lsp_references({fname_width = 100})<CR>", {desc = "Goto References"})
        vim.keymap.set("n", "cd", vim.lsp.buf.rename, {desc = "Rename symbol (Change definition)"})
        -- vim.keymap.set("n", "gl", "<cmd>ClangdSwitchSourceHeader<Cr>", {desc = "Goto linked file (src / header)"})

        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
        vim.keymap.set("n", "M", vim.diagnostic.open_float, {desc = "Misstake hover (Open Error / Diagnostic float)"})
        vim.keymap.set("n", "K", vim.lsp.buf.hover, {desc = "Hover Signature / Documentation"})
        -- don't add C-s to hover signature in insert mode. This is too much. It is easily to go in normal mode and check using "K" whatever you need

        vim.keymap.set("n", "<leader>ls", "<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>", { desc = 'Find symbols'})
        vim.keymap.set("n", "<leader>lS", "<cmd>lua require('telescope.builtin).lsp_workspace_symbols()<CR>", { desc = "Find symbols in workspace" })
        vim.keymap.set("n", "<leader>lm", "<cmd>lua require('telescope.builtin').lsp_document_symbols({symbols = {'function', 'class', 'struct', 'method'}})<CR>", { desc = "Find functions / classes / methods" })
        vim.keymap.set("n", "<leader>lM", "<cmd>lua require('telescope.builtin').lsp_workspace_symbols({symbols = {'function', 'class', 'struct', 'method'}})<CR>", { desc = "Find functions / classes / methods in workspace" })
        vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, {desc = "Lsp actions"})
        vim.keymap.set("n", "<leader>ua", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, {desc = "Toggle inlay_hints (Annotations)"})
        vim.keymap.set("n", "<leader>um", "<cmd>Mason<CR>", {desc = "Open Mason"})

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        require("workspace-diagnostics").populate_workspace_diagnostics(client, event.buf)

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
      pyright = {}, -- Нужно сначала запусить neovim (nvim .) и только затем заходить в файл
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
    }

    require("mason").setup()
    require("mason-lspconfig").setup({ ensure_installed = vim.tbl_keys(servers or {}) })

    require("mason-lspconfig").setup_handlers({
        function(server_name)
          local server = servers[server_name] or {}
          server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
          server.capabilities.workspace.didChangeWatchedFiles.dynamicRegirsation = true
          require("lspconfig")[server_name].setup(server)
        end,
    })
  end,
}
