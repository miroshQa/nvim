return {
  "neovim/nvim-lspconfig",
  event = "VimEnter",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "artemave/workspace-diagnostics.nvim",
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

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
      callback = function(event)
        vim.keymap.set("n", "gd", require("telescope.builtin").lsp_definitions, {desc = "Goto Definition"})
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, {desc = "[G]oto [D]eclaration"})
        vim.keymap.set("n", "gi", require("telescope.builtin").lsp_implementations, {desc = "Goto Implementation"})
        vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, {desc = "Goto References"})
        vim.keymap.set("n", "gl", "<cmd>ClangdSwitchSourceHeader<Cr>", {desc = "Goto linked file (src / header)"})
        vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, {desc = "Rename symbol"})
        vim.keymap.set("n", "<leader>lR", "<cmd>LspRestart<CR>", {desc = "Restart"})
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
        vim.keymap.set("n", "H", vim.diagnostic.open_float, {desc = "Open diagnostic float"})
        vim.keymap.set("n", "sda;jfa", vim.lsp.buf.hover, {desc = "Hover Documentation"})
        vim.keymap.set("i", '<up>', vim.lsp.buf.signature_help, {desc = "Hover Signature help"})


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
      clangd = { cmd = { "clangd", "--function-arg-placeholders=0", }, single_file_support = true,},
      emmet_language_server = { },
      neocmake = {},
      pyright = {},
      cssls = {},
      lemminx = {},
      marksman = {},
      lua_ls = {},
      jsonls = {},

    }

    require("mason").setup()
    require("mason-lspconfig").setup({ ensure_installed = vim.tbl_keys(servers or {}) })

    require("mason-lspconfig").setup_handlers({
        function(server_name)
          local server = servers[server_name] or {}
          server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
          require("lspconfig")[server_name].setup(server)
        end,
    })
  end,
}
