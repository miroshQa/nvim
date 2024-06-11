return {
  'stevearc/oil.nvim',
  opts = {},
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("oil").setup(
      {
        keymaps = {
          ["g?"] = "actions.show_help",
          ["<CR>"] = "actions.select",
          ["<C-s>"] = "actions.select_vsplit",
          ["<C-h>"] = "actions.select_split",
          ["<C-t>"] = "actions.select_tab",
          ["<C-p>"] = "actions.preview",
          ["<C-c>"] = "actions.close",
          ["<C-l>"] = "actions.refresh",
          ["-"] = "actions.parent",
          ["_"] = "actions.open_cwd",
          ["`"] = "actions.cd",
          ["~"] = "actions.tcd",
          ["gs"] = "actions.change_sort",
          ["gx"] = "actions.open_external",
          ["gh"] = "actions.toggle_hidden",
          ["g\\"] = "actions.toggle_trash",
        },
        use_default_keymaps = false,
      }
    )

    vim.api.nvim_create_user_command("OilToggle", function()
      local current_buf = vim.api.nvim_get_current_buf()
      local current_filetype = vim.api.nvim_buf_get_option(current_buf, "filetype")
      local buffers = vim.api.nvim_list_bufs()
      local buffers_counter = 0

      for _, buffer in pairs(buffers) do
        if vim.api.nvim_buf_is_loaded(buffer) then
          buffers_counter = buffers_counter + 1

          if buffers_counter > 1 then
            break
          end

        end
      end

      if current_filetype == "oil" then
        -- We use a command to go to the previous buffer
        if buffers_counter > 1 then
          vim.cmd("b#")
        end
      else
        -- Open oil if not already in an oil buffer
        vim.cmd("Oil")
      end
    end, { nargs = 0 })


    vim.keymap.set("n", "<leader>e", "<cmd>OilToggle<CR>", { desc = "Toggle Oil" })
  end
}
