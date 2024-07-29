
return {
  "uga-rosa/ccc.nvim",
	event = {"BufReadPost", "BufNewFile"},
  config = function()
    	local ccc = require("ccc")

      vim.keymap.set("n", "<leader>up", "<cmd>CccPick<CR>", {desc = "Pick color"})
      vim.keymap.set("n", "<leader>uh", "<cmd>:CccHighlighterToggle<CR>", {desc = "Highlighter toggle"})

      local mapping = ccc.mapping
      ccc.setup({
        -- Your preferred settings
        -- Example: enable highlighter
        highlighter = {
          auto_enable = true,
          lsp = true,
        },
        mappings = {
          w = mapping.increase5,
          W = mapping.increase10,
          e = mapping.increase5,
          E = mapping.increase10,
          b = mapping.decrease5,
          B = mapping.decrease10,
        }
      })
  end,
}
