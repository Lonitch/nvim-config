return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("neo-tree").setup({
      sources = {"filesystem","buffers","git_status","document_symbols"},
      source_selector = {
        winbar = true,
        statusline = false,
        show_scrolled_off_parent_node = false,                    -- boolean
        sources = {                                               -- table
          {
            source = "filesystem",                                -- string
            display_name = " 󰉓 Files "                            -- string | nil
          },
          {
            source = "buffers",                                   -- string
            display_name = " 󰈚 Buffers "                          -- string | nil
          },
          {
            source = "git_status",                                -- string
            display_name = " 󰊢 Git "                              -- string | nil
          },
          {
            source = "document_symbols",
            display_name = "  Components "
          },
        },
      },
      window = {
        mappings = {
          ['f'] = function ()
            vim.api.nvim_exec('Neotree focus filesystem left',true)
          end,
          ['b'] = function ()
            vim.api.nvim_exec('Neotree focus buffers left',true)
          end,
          ['g'] = function ()
            vim.api.nvim_exec('Neotree focus git_status left',true)
          end,
          ['c'] = function ()
            vim.api.nvim_exec('Neotree focus document_symbols left',true)
          end,
        }
      }
    })
    -- <space>+n to open/close file tree
    vim.keymap.set("n", "<leader>n", ":Neotree filesystem reveal left toggle<CR>", {})
    -- <space>+b+o to reveal opened files 
    vim.keymap.set("n", "<leader>bo", ":Neotree buffers reveal float<CR>", {})
  end,
}
